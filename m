From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Tue, 25 May 2010 14:25:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005251408120.1634-100000@iolanthe.rowland.org>
References: <20100525165137.GB2730@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100525165137.GB2730@core.coreip.homeip.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Sven Neumann <s.neumann@raumfeld.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Kernel development list <linux-kernel@vger.kernel.org>, Tero Saarni <tero.saarni@gmail.com>, linux-input@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Alexey Dobriyan <adobriyan@gmail.com>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Daniel Mack <daniel@caiaq.de>, Oleg Nesterov <oleg@redhat.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Daniel Walker <dwalker@codeaurora.org>, Theodore Ts'o <tytso@mit.edu>, =?iso-8859-1?Q?M=E1rton_N=E9meth?= <nm127@freemail.hu>, Brian Swetland <swetland@google.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 25 May 2010, Dmitry Torokhov wrote:

> What I do not quite understand is how exactly suspend blocks save us
> from missing wakeup events. Consider case when all events have been
> processed and system starts entering the sleep: we are in a half-sleep,
> half awake state, with some devices already put to sleep and some just
> now being processed. If user presses a key while physical input device
> is being suspended, what will happen? Do you expect interrupt routine
> abort suspend process? Initiate resume if suspend of the device has
> completed?

This depends on several factors, such as how the input device drivers
are written and how the hardware works, as well as the details of the 
timing.  Here are a few possibilities:

	The keypress is not handled but stays in the hardware as a
	wakeup event.  The system goes through its entire suspend
	procedure, and then the pending wakeup event immediately
	cases it to wake up.  Then the keypress gets handled
	normally.

	Or the keypress is treated as a normal IRQ and handled by
	the hardware.  The input subsystem puts the keystroke on
	the event queue (all done while in_interrupt), where it
	languishes because userspace is frozen and can't read it.
	The system goes to sleep and stays that way until something
	else wakes it up.  (This is a type-3 failure as described
	in my earlier email.)

	Or the keypress is handled normally and the input subsystem 
	interprets it as a runtime resume request, telling the PM core 
	to queue a resume call.  But the PM core's runtime workqueue 
	thread has already been frozen, and so the event remains on the 
	work queue until the system wakes up on its own.  (This is a
	type-2 failure.)

	Or we fix the PM core, so that when the resume call is added
	to the workqueue it realizes the suspend-in-progress needs
	to be aborted.  The system goes back to a fully-awake state
	and the keystroke is handled normally.

> Also, let's say device is suspended and is configured as a wakeup source
> while the rest of the system is still awake... If I press a key I do not
> think that it will necessarily abort suspend process. Or will it?

Since the keyboard is a wakeup device, it certainly should abort the
suspend.  Or at least it should wake the system up as soon as the
system finishes going to sleep.  At the moment, though, I'm not sure
that it does behave either way.

> BTW, If you are concerned about events that already "left" physical
> device but has not reached userspace yet - maybe instead of suspend
> blockers we should make sure that all drivers throughout the chain
> implement suspend/resume and refuse suspending if their queues are not
> empty.  In input land that would mean extending suspend routine in
> input_dev and adding one to evdev.

That's not the only problem.  We also have to consider events that have
reached userspace but not yet been fully processed.  The user thread
handling the event needs some way to prevent the system from suspending
until it is all done.

Alan Stern
