From: Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [WARNING: A/V UNSCANNABLE][Merge tag 'media/v4.11-1' of git]
 ff58d005cd: BUG: unable to handle kernel NULL pointer dereference at
 0000039c
Date: Mon, 27 Feb 2017 16:41:24 +0100
Message-ID: <20170227154124.GA20569@gmail.com>
References: <58b07b30.9XFLj9Hhl7F6HMc2%fengguang.wu@intel.com>
 <CA+55aFytXj+TZ_TanbxcY0KgRTrV7Vvr=fWON8tioUGmYHYiNA@mail.gmail.com>
 <20170225090741.GA20463@gmail.com>
 <CA+55aFy+ER8cYV02eZsKAOLnZBWY96zNWqUFWSWT1+3sZD4XnQ@mail.gmail.com>
 <alpine.DEB.2.20.1702271105090.4732@nanos>
 <alpine.DEB.2.20.1702271231410.4732@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1702271231410.4732@nanos>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ruslan Ruslichenko <rruslich-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, Sean Young <sean-hENCXIMQXOg@public.gmane.org>, wfg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mauro Carvalho Chehab <mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linux LED Subsystem <linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, LKP <lkp-JC7UmRfGjtg@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Media Mailing List <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


* Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org> wrote:

> The pending interrupt issue happens, at least on my test boxen, mostly on
> the 'legacy' interrupts (0 - 15). But even the IOAPIC interrupts >=16
> happen occasionally.
>
> 
>  - Spurious interrupts on IRQ7, which are triggered by IRQ 0 (PIT/HPET). On
>    one of the affected machines this stops when the interrupt system is
>    switched to interrupt remapping !?!?!?
> 
>  - Spurious interrupts on various interrupt lines, which are triggered by
>    IOAPIC interrupts >= IRQ16. That's a known issue on quite some chipsets
>    that the legacy PCI interrupt (which is used when IOAPIC is disabled) is
>    triggered when the IOAPIC >=16 interrupt fires.
> 
>  - Spurious interrupt caused by driver probing itself. I.e. the driver
>    probing code causes an interrupt issued from the device
>    inadvertently. That happens even on IRQ >= 16.
> 
>    This problem might be handled by the device driver code itself, but
>    that's going to be ugly. See below.

That's pretty colorful behavior...

> We can try to sample more data from the machines of affected users, but I doubt 
> that it will give us more information than confirming that we really have to 
> deal with all that hardware wreckage out there in some way or the other.

BTW., instead of trying to avoid the scenario, wow about moving in the other 
direction: making CONFIG_DEBUG_SHIRQ=y unconditional property in the IRQ core code 
starting from v4.12 or so, i.e. requiring device driver IRQ handlers to handle the 
invocation of IRQ handlers at pretty much any moment. (We could also extend it a 
bit, such as invoking IRQ handlers early after suspend/resume wakeup.)

Because it's not the requirement that hurts primarily, but the resulting 
non-determinism and the sporadic crashes. Which can be solved by making the race 
deterministic via the debug facility.

If the IRQ handler crashed the moment it was first written by the driver author 
we'd never see these problems.

Thanks,

	Ingo
