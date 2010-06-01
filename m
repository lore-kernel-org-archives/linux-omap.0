From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 2 Jun 2010 00:24:14 +0200
Message-ID: <201006020024.14220.rjw@sisk.pl>
References: <20100527232357.6d14fdb2@lxorguk.ukuu.org.uk> <20100601135102.GA8098@srcf.ucam.org> <1275426085.21962.967.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1275426085.21962.967.camel@mulgrave.site>
Sender: linux-kernel-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Arve =?utf-8?q?Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, tytso@mit.edu, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Stern <stern@rowland.harvard.edu>, mark.gross@intel.com, Neil Brown <neilb@suse.de>
List-Id: linux-omap@vger.kernel.org

On Tuesday 01 June 2010, James Bottomley wrote:
> On Tue, 2010-06-01 at 14:51 +0100, Matthew Garrett wrote:
> > On Mon, May 31, 2010 at 04:21:09PM -0500, James Bottomley wrote:
> > 
> > > You're the one mentioning x86, not me.  I already explained that some
> > > MSM hardware (the G1 for example) has lower power consumption in S3
> > > (which I'm using as an ACPI shorthand for suspend to ram) than any
> > > suspend from idle C state.  The fact that current x86 hardware has the
> > > same problem may be true, but it's not entirely relevant.
> > 
> > As long as you can set a wakeup timer, an S state is just a C state with 
> > side effects. The significant one is that entering an S state stops the 
> > process scheduler and any in-kernel timers. I don't think Google care at 
> > all about whether suspend is entered through an explicit transition or 
> > something hooked into cpuidle - the relevant issue is that they want to 
> > be able to express a set of constraints that lets them control whether 
> > or not the scheduler keeps on scheduling, and which doesn't let them 
> > lose wakeup events in the process.
> 
> Exactly, so my understanding of where we currently are is:

Thanks for the recap.

>      1. pm_qos will be updated to be able to express the android suspend
>         blockers as interactivity constraints (exact name TBD, but
>         probably /dev/cpu_interactivity)

I think that's not been decided yet precisely enough.  I saw a few ideas
here and there in the thread, but which of them are we going to follow?

>      2. pm_qos will be updated to be callable from atomic context
>      3. pm_qos will be updated to export statistics initially closely
>         matching what suspend blockers provides (simple update of the rw
>         interface?)
> 
> After this is done, the current android suspend block patch becomes a
> re-expression in kernel space in terms of pm_qos, with the current
> userspace wakelocks being adapted by the android framework into pm_qos
> requirements expressed to /dev/cpu_interactivity (or whatever name is
> chosen).  Then opportunistic suspend is either a small add-on kernel
> patch they have in their tree to suspend when the interactivity
> constraint goes to NONE, or it could be done entirely by a userspace
> process.  Long term this could migrate to the freezer and suspend from
> idle approach as the various problem timers get fixed.
> 
> I think the big unresolved issue is the stats extension.  For android,
> we need just a name written along with the value, so we have something
> to hang the stats off ... current pm_qos userspace users just write a
> value, so the name would be optional.  From the kernel, we probably just
> need an additional API that takes a stats name or NULL if none
> (pm_qos_add_request_named()?).  Then reading the stats could be done by
> implementing a fops read routine on the misc device.

Is the original idea of having that information in debugfs objectionable?

Rafael
