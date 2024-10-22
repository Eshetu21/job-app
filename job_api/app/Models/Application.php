<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Application extends Model
{
    use HasFactory;

    protected $fillable = [
        'job_id',
        'jobseeker_id',
        'status',
        'statement',
        'cover_letter',
        'cv'
    ];

    public function job(){
        return $this->belongsTo(Job::class);
    }
    public function jobseeker(){
<<<<<<< HEAD
        return $this->belongsTo(Jobseeker::class);
=======
        return $this->belongsTo(JobSeeker::class);
>>>>>>> f3b7e31f9a2b497d0d585b0d751344164bba572d
    }
    
}
