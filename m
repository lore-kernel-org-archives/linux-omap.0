From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Seeking clarity on IRQCHIP_MASK_ON_SUSPEND
Date: Tue, 11 Sep 2012 15:20:53 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1209111512130.7093@ionos>
References: <20120910165127.37dd07f3@notabene.brown> <alpine.LFD.2.02.1209101215300.2724@ionos> <20120911094252.0e78a8f9@notabene.brown>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120911094252.0e78a8f9@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, lkml <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Abhijeet Dharmapurikar <adharmap@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

On Tue, 11 Sep 2012, NeilBrown wrote:
> On Mon, 10 Sep 2012 12:28:35 +0200 (CEST) Thomas Gleixner
> <tglx@linutronix.de> wrote:
> > You might be looking for a different functionality. Can you explain
> > what you need?
> 
> I want as particular GPIO interrupt to be masked before entering suspend.
> I produced code to get the ->suspend() callback to perform this masking.
> Another developer (Santosh) felt that IRQCHIP_MASK_ON_SUSPEND was the
> preferred way to do this and on the surface this looks like it should be
> correct.  However it doesn't work as explained previously.
> I want a resolution to this difference of opinion that doesn't just sweep the
> issue under that carpet but provides a clear answer to this sort of issue.
> 
> My current opinion is that IRQCHIP_MASK_ON_SUSPEND should be discarded.  The
> patch which introduced it says:
> 
>     Rather than working around this in the affected interrupt chip
>     implementations we can solve this elegant in the core code itself.
>     
> It appears that the solution in core code, while elegant, is wrong.  It
> happens too late to be generally usable.  It is easy enough to handle this

Sigh. The flag was invented with the semantics to keep the current
"check for any interrupt" pending functionality alive and then mask it
right before going down, so only the designated wakeup interrupts can
wake the device. That was the result of the discussion back then and
that was what the developer wanted to achieve with his driver suspend
hackery.

> issue in the interrupt chip drivers so maybe that is the best place
> to handle it.

And have the same "keep track of wakeup interrupts" code over and over
in the drivers.
 
> The the very least I think we need a big comment saying the
> IRQCHIP_MASK_ON_SUSPEND can only be used for irqchips which can always be
> programmed, even when they are suspended from an runtime-PM perspective,
> and that those chips must handle masking in their 'suspend' callback.

Sigh, no. Either we make IRQCHIP_MASK_ON_SUSPEND into an
implementation which masks the interrupts early, if the existing users
find this acceptable or have a separate IRQCHIP_MASK_BEFORE_SUSPEND
flag.

This GPIO driver at hand is probably not the last one which requires
this and we really want to do stuff in the core code instead of having
random implementations of the same stuff all over the place.

Thanks,

	tglx
