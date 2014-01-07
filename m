From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH V5 0/4] DRIVERS: IRQCHIP: Add support for crossbar IP
Date: Tue, 7 Jan 2014 15:55:15 -0800
Message-ID: <20140107235514.GG5074@atomide.com>
References: <1386066445-28245-1-git-send-email-r.sricharan@ti.com>
 <52B168A5.4010202@ti.com>
 <52BBB614.5010707@ti.com>
 <52BC6B16.80507@ti.com>
 <52BD856E.7010609@ti.com>
 <52C11284.2030500@ti.com>
 <20140107230733.GD5074@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140107230733.GD5074-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Cc: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [140107 15:10]:
> * Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org> [131229 22:30]:
> > On Friday 27 December 2013 07:19 PM, Sricharan R wrote:
> > > On Thursday 26 December 2013 11:14 PM, Santosh Shilimkar wrote:
> > >> On Wednesday 25 December 2013 11:52 PM, Sricharan R wrote:
> > >>> On Wednesday 18 December 2013 02:49 PM, Sricharan R wrote:
> > >>>> I have addressed all the comments on this series, can this be merged now ?
> > >>>>
> > >>>   Ping..
> > >>>
> > >> Thomas has already given his reviewed-by tag so the patches can be
> > >> taken via arm-soc tree considering OMAP and GIC changes. Can you
> > >> create a branch with all these patches applied and send it
> > >> to Tony ?
> > >>
> > > Ok, i will send out a branch for this.
> > > 
> >  
> >  I have pushed the below branch
> > 
> > git://github.com/Sricharanti/sricharan.git
> > branch: crossbar
> > 
> > This is on top of Tony's linux-omap master branch
> 
> The linux-omap master branch cannot be used as a base as it
> contains tons of commit history not in mainline. So I'll
> manually applied these patches into omap-for-v3.14/crosbar
> branch.

Oops, I noticed some errors on these:

WARNING: drivers/built-in.o(.text+0xcd0): Section mismatch in reference from the function irqcrossbar_init() to the function .init.text:crossbar_of_init()
The function irqcrossbar_init() references
the function __init crossbar_of_init().
This is often because irqcrossbar_init lacks a __init 
annotation or the annotation of crossbar_of_init is wrong.

WARNING: drivers/built-in.o(.text+0xcdc): Section mismatch in reference from the function irqcrossbar_init() to the (unknown reference) .init.rodata:(unknown)
The function irqcrossbar_init() references
the (unknown reference) __initconst (unknown).
This is often because irqcrossbar_init lacks a __initconst 
annotation or the annotation of (unknown) is wrong.

So I've dropped them for now. Care to fix up those errors and
base your patches against let's say v3.13-rc5?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
