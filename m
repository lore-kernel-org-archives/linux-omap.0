From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/1] usb: Include generic_interrupt for OMAP2_PLUS
Date: Mon, 24 Sep 2012 09:09:14 -0700
Message-ID: <20120924160914.GB28835@atomide.com>
References: <1348487604-7202-1-git-send-email-philippe.deswert@jollamobile.com>
 <20120924121538.GH2892@arwen.pp.htv.fi>
 <CAPsFW+RTLpgXFOOh9fD=K1wCPMpBe4MummhWoqEBEEYYzMay=Q@mail.gmail.com>
 <20120924130216.GA5603@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120924130216.GA5603-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Philippe De Swert <philippedeswert-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Philippe De Swert <philippe.deswert-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [120924 06:08]:
> Hi,
> 
> On Mon, Sep 24, 2012 at 03:54:22PM +0300, Philippe De Swert wrote:
> > Hi,
> > 
> > On 24/09/2012, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> > > SoB's mail doesn't From mail.
> > 
> > Well still in the progress of migrating of my personal to work laptop.
> > Since the patch does not seem correct the replacement will have
> > matching addresses.
> > 
> > >> /*-------------------------------------------------------------------------*/
> > >>
> > >>  #if defined(CONFIG_SOC_OMAP2430) || defined(CONFIG_SOC_OMAP3430) || \
> > >> -	defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_ARCH_U8500)
> > >> +	defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_ARCH_U8500) || \
> > >> +	defined(CONFIG_ARCH_OMAP2PLUS)
> > >
> > > Weird, how can you build OMAP2PLUS without SOC_OMAPXXXX ??
> > 
> > It seems entirely possible. I quickly tried to look if it got defined
> > somewhere and it does not seem to be set anywhere.  That is why I got
> > the impression it was replaced by CONFIG_ARCH_OMAP2PLUS. I'll dig
> > deeper to find out why SOC_OMAPXXXX is not set if it should be.
> > 
> > From the .config I got (used menuconfig)
> > 
> > #
> > # TI OMAP2/3/4 Specific Features
> > #
> > CONFIG_ARCH_OMAP2PLUS_TYPICAL=y
> > CONFIG_SOC_HAS_OMAP2_SDRC=y
> > # CONFIG_ARCH_OMAP2 is not set
> > CONFIG_ARCH_OMAP3=y
> > # CONFIG_ARCH_OMAP4 is not set
> > # CONFIG_SOC_OMAP5 is not set
> > # CONFIG_SOC_OMAP3430 is not set
> > # CONFIG_SOC_TI81XX is not set
> > # CONFIG_SOC_AM33XX is not set
> > CONFIG_OMAP_PACKAGE_CBB=y
> > 
> > Not a mention of CONFIG_SOC_OMAP2430 and  CONFIG_SOC_OMAP3430 did not
> > get set (while it is not a 3430 but a 3630 I am using). Maybe
> > CONFIG_ARCH_OMAP3 would have been a better choice then?
> 
> that's quite f**ked up. Tony, why doesn't SOC_OMAP3430 get set for all
> OMAP3 boards ? And another question: why don't we have a matching
> SOC_OMAP3530, SOC_OMAP3630 and so on ?

ARCH_OMAP3 will probably eventually just disappear and
be replaced with ARCH_OMAP2PLUS + SOC_XXXX. But there's
no need to do it right now as most of that should be
internal to arch/arm/mach-omap2 anyways. I would just
set the driver to depend on ARCH_OMAP2PLUS, and rely on
the platform_data and DT to do something if specified.
That means that on 2420 musb should not probe unless
tusb6010 in specified.

It seems that things like fifo_mode and generic_interrupt
can all be set during the probe based on the platform_data
or DT passed information?
 
Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
