From: Mark Jackson <mpfj-list@newflow.co.uk>
Subject: Re: v3.9.0-rc8 : oops in tick_do_update_jiffies64+0xbc/0x110
Date: Mon, 29 Apr 2013 16:46:18 +0100
Message-ID: <517E95CA.4000708@newflow.co.uk>
References: <517E3039.2070204@newflow.co.uk> <20130429154146.GB28721@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130429154146.GB28721@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, tglx@linutronix.de, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 29/04/13 16:41, Tony Lindgren wrote:
> * Mark Jackson <mpfj-list@newflow.co.uk> [130429 01:38]:
>> I've been experiencing several crashes all pointing exactly the same place in the same tick routine (see below).
>>
>> The "exception stack" trace at the end changes depending on when the oops occurs.
>>
>> I've had the oops occur maybe 6 times in the last 50 reboots.
>>
>> Any ideas ?
> 
> Sounds like it might be an issue with the physical memory or
> the timings. It could also be related to the idle loop not
> restoring something right for deeper idle states that corrupts
> the memory. And that's why it would seem to appear while waking
> to a timer.

I am suspecting a borderline CPU.  We only have "X" AM3359 parts which
are all pre-production.

> Maybe disable PM and run memtester to see if that runs reliably?

I'll see if I can get it running on our platform.

Thanks
Mark J.
