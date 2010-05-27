From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 20:50:09 +0100
Message-ID: <20100527205009.391803b6@lxorguk.ukuu.org.uk>
References: <Pine.LNX.4.44L0.1005271344040.3239-100000@iolanthe.rowland.org>
	<1274982779.27810.5708.camel@twins>
	<20100527175719.GD3543@srcf.ucam.org>
	<1274983333.27810.5744.camel@twins>
	<20100527181433.GG3543@srcf.ucam.org>
	<20100527200313.5c532f2f@lxorguk.ukuu.org.uk>
	<20100527191302.GC5703@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100527191302.GC5703@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux@smtp1.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, felipe.balbi@nokia.com
List-Id: linux-omap@vger.kernel.org

> Sigh. No. Forced suspend is a fact of life

'Fact of life' isn't a useful reasoning basis. It tells me nothing about
how you got to that pronouncement.

> Drivers should enable wakeups before they disable interrupts. So either 
> the packet hits the IRQ handler and the driver takes a suspend block 
> (aborting suspend in the process) or it doesn't, the GPE goes high and 
> the system resumes immediately after entering S3.
> 
> > 	Set wake flags
> > 	Check if idle
> > 	If idle
> > 		Suspend
> > 	else
> > 		Clear wake flags
> > 		Unwind
> > 
> > and the wake flags guarantee that an event at any point after the wake
> > flags are set until they are cleared will cause a suspend to be resumed,
> > possibly immediately after the suspend.
> 
> Exactly. So the 5 nanosecond case is already handled. The interesting 
> case is where userspace makes the decision to go to sleep and starts 
> performing various housekeeping tasks before triggering the suspend. You 
> need some way to abort that suspend. 

See above. You can't always abort the suspend you may have to go full
circle. Not only that but the exactly algorithm above can be applied
user to kernel as well as kernel to hardware.

Given your average app author I think I'd rather just run their suspend
then their resume handling back to back anyway because it's a single
tested code path, while half way through cases in apps will *never* get
tested or work properly.

So I guess if you are driving this rom user space (which I take it you
are given you talk about housekeeping)

	foreach app we need to suspend
		kick app to suspend (signal)
		(policy) kick harder if needed (SIGSTOP/bitch/shall I
					kill it dialogue)
	rendezvous (apps now all sleeping or dead)

X
	if (we still want to suspend) {
		prod kernel
		kernel suspends
		kernel resumes
	}
	resume all the apps


The important msising bit from that is 'set wake flags'.

Now what actually happens here beyond point X. Any event that gets kernel
processed moves the task into RUNNING. Any event that occurs after that
point causes the hardware to go suspend/resume. If not the driver is
buggy.

Now replace "kernel suspends" with "let the kernel know it can drop into
suspend level idle". The power management code will handle the races
beyond point X for you.

So for that you simply need a constraint to remain above suspend level
idle that you drop where it says "prod kernel" and pick up on "resume"

Alan
