From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH V5 0/4] DRIVERS: IRQCHIP: Add support for crossbar IP
Date: Wed, 8 Jan 2014 11:18:03 -0800
Message-ID: <20140108191802.GA31323@atomide.com>
References: <1386066445-28245-1-git-send-email-r.sricharan@ti.com>
 <52B168A5.4010202@ti.com>
 <52BBB614.5010707@ti.com>
 <52BC6B16.80507@ti.com>
 <52BD856E.7010609@ti.com>
 <52C11284.2030500@ti.com>
 <20140107230733.GD5074@atomide.com>
 <20140107235514.GG5074@atomide.com>
 <52CD5010.6030309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52CD5010.6030309-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Cc: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org> [140108 05:20]:
> On Wednesday 08 January 2014 05:25 AM, Tony Lindgren wrote:
> > 
> > Oops, I noticed some errors on these:
> > 
> > WARNING: drivers/built-in.o(.text+0xcd0): Section mismatch in reference from the function irqcrossbar_init() to the function .init.text:crossbar_of_init()
> > The function irqcrossbar_init() references
> > the function __init crossbar_of_init().
> > This is often because irqcrossbar_init lacks a __init 
> > annotation or the annotation of crossbar_of_init is wrong.
> > 
> > WARNING: drivers/built-in.o(.text+0xcdc): Section mismatch in reference from the function irqcrossbar_init() to the (unknown reference) .init.rodata:(unknown)
> > The function irqcrossbar_init() references
> > the (unknown reference) __initconst (unknown).
> > This is often because irqcrossbar_init lacks a __initconst 
> > annotation or the annotation of (unknown) is wrong.
> > 
> > So I've dropped them for now. Care to fix up those errors and
> > base your patches against let's say v3.13-rc5?
> > 
>    Very Sorry for the section mismatch warning.
>    I have fixed it and pushed a new branch below based on v3.13-rc5
> 
>    git://github.com/Sricharanti/sricharan.git
>    branch: crossbar_3.13_rc5

Thanks, applying again.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
