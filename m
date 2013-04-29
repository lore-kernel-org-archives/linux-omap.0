From: Tony Lindgren <tony@atomide.com>
Subject: Re: v3.9.0-rc8 : oops in tick_do_update_jiffies64+0xbc/0x110
Date: Mon, 29 Apr 2013 08:41:47 -0700
Message-ID: <20130429154146.GB28721@atomide.com>
References: <517E3039.2070204@newflow.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <517E3039.2070204@newflow.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Jackson <mpfj-list@newflow.co.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, tglx@linutronix.de, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Mark Jackson <mpfj-list@newflow.co.uk> [130429 01:38]:
> I've been experiencing several crashes all pointing exactly the same place in the same tick routine (see below).
> 
> The "exception stack" trace at the end changes depending on when the oops occurs.
> 
> I've had the oops occur maybe 6 times in the last 50 reboots.
> 
> Any ideas ?

Sounds like it might be an issue with the physical memory or
the timings. It could also be related to the idle loop not
restoring something right for deeper idle states that corrupts
the memory. And that's why it would seem to appear while waking
to a timer.

Maybe disable PM and run memtester to see if that runs reliably?

Regards,

Tony
