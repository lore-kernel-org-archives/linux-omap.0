From: john stultz <johnstul@us.ibm.com>
Subject: Re: Timekeeping issue on aggressive suspend/resume
Date: Thu, 10 Jun 2010 12:52:48 -0700
Message-ID: <1276199568.16089.35.camel@work-vm>
References: <AANLkTinIO5a1EeK6Ej2ljkuyL9zv06OMfbyiZBaxTQTd@mail.gmail.com>
	 <alpine.LFD.2.00.1006092206020.2933@localhost.localdomain>
	 <AANLkTin-6XsW49ECufTLcdzaD1eK9bAxe0j7RXvPqN7p@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTin-6XsW49ECufTLcdzaD1eK9bAxe0j7RXvPqN7p@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suresh Rajashekara <suresh.raj+linuxomap@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-omap@vger.kernel.org

On Wed, 2010-06-09 at 23:34 -0700, Suresh Rajashekara wrote:
> On Wed, Jun 9, 2010 at 1:22 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > Though we could change that conditionally - the default would still be
> > the freeze of jiffies and CLOCK_MONOTONIC for historical compability.
> 
> If I were to change it only for our implementation, and make all the
> user space timers use CLOCK_REALTIME, then could you please point me
> in a direction as to what part of the kernel I should be touching to
> make that change?

I think Thomas was suggesting that you consider creating a option for
where CLOCK_MONOTONIC included total_sleep_time.

In that case the *hack* (and this is a hack, we'll need some more
thoughtful discussion before anything like it could make it upstream)
would be in timekeeping_resume() to comment out the lines that update
wall_to_monotonic and total_sleep_time.

It would be interesting to hear if that hack works for you, and we can
try to come up with a better way to think about how to accommodate both
views of how to account time over suspend.

Thomas, might this call for a new posix clock_id, CLOCK_BOOTTIME (ie:
CLOCK_MONOTONIC + total_sleep_time) or something that userland could use
to set timers on?

thanks
-john
