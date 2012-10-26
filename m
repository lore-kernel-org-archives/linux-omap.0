From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/5] drivers: usb: otg: make twl6030_usb as a
 comparator driver to omap_usb2
Date: Fri, 26 Oct 2012 09:36:19 -0700
Message-ID: <20121026163619.GB11908@atomide.com>
References: <1346943430-18236-1-git-send-email-kishon@ti.com>
 <1346943430-18236-3-git-send-email-kishon@ti.com>
 <CAH+eYFAj1ecvmiJCu8QDCr3LjHT5eXjq6zsZMiVRPROoWcDuNQ@mail.gmail.com>
 <CAAe_U6K1RXA3b5u9WvE=2VoXym9Vj3KM7c0J27jKz+2KrV4tsg@mail.gmail.com>
 <CAH+eYFAhVE8cAte2PFk3jinV9n3m+eDLtE43QxzRXMScnFGcrA@mail.gmail.com>
 <508AA94B.10504@ti.com>
 <508AAA85.6070905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <508AAA85.6070905-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>, Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org> [121026 08:23]:
> Hi Roger,
> 
> On 10/26/2012 05:16 PM, Roger Quadros wrote:
> > Hi Kishon & Benoit,
> > 
> > On 09/24/2012 12:06 PM, Rabin Vincent wrote:
> >> 2012/9/24 ABRAHAM, KISHON VIJAY <kishon-l0cyMroinI0@public.gmane.org>:
> >>> On Sat, Sep 22, 2012 at 3:03 AM, Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org> wrote:
> >>>> USB doesn't work on pandaboard on linux-next, and bisection shows this
> >>>> patch.  Unfortunately, I can't provide a dmesg log because USB is the
> >>>> only way I currently have to get one out(!), but presumably it's because
> >>>> this omap-usb2 device is never registered?  Looks like this breaks
> >>>> non-dt USB on pandaboard; is that intended?
> >>>
> >>> Yes. omap-usb2 is *only* dt supported (New drivers shouldn't have the
> >>> old non-dt support).
> >>
> >> Well, USB used to work fine on Pandaboard without DT before the
> >> introduction of "omap-usb2", so one would expected it to continue
> >> working (until the board file is completely removed).
> >>
> >> Anyway, I've moved to DT now.
> >>
> >>> Some patches are queued only for 3.7.
> >>>
> >>> In case you want to use MUSB please use these patches on linux-next..
> >>> [PATCH v2] arm: omap: hwmod: make *phy_48m* as the main_clk of ocp2scp
> >>> [PATCH] ARM: OMAP2+: hwmod data: Fix ocp2scp_usb_phy and usb_host_hs
> >>> entries (from Benoit)
> >>> [PATCH 0/2] ARM: dts: Add subnode for ocp2scp (patch series)
> >>> [PATCH v3 0/3] ARM: dts: omap: add dt data for MUSB (patch series)
> >>
> >> I got these by merging in Benoit's for_3.7/dts_part2 on top of
> >> next-20120921.  Thanks.
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> >> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> > 
> > I still can't get musb to work on 3.7-rc2. Apparently it is still
> > missing the patches from Benoit's for_3.7/dts_part2.
> > 
> > Maybe I just need to wait for it to be merged?
> 
> They are now in a for_3.8/dts. Unfortunately, one patch that was adding
> ctrl_module address in the USB data was rejected and thus I'm not sure
> it will work without that.
> 
> I think Tony had an idea to map the ctrl_register to regulator fmwk or
> something like that.

For device tree, we may be eventually able to handle the ctrl_register
using pinctrl-single.c and pinconf API. It probably does not make
sense to set it up as a regulator as the comparator can trigger errors
also for the pinconf related bits at least for MMC PBIAS.
 
> > Till then, where can I get a tree where musb works on Panda?

On panda, without using device tree, use v3.7-rc2 + the following patches:

ARM: OMAP: ocp2scp: create omap device for ocp2scp
ARM: OMAP4: add _dev_attr_ to ocp2scp for representing usb_phy
drivers: bus: ocp2scp: add pdata support

Also you need to enable CONFIG_OMAP_USB2. No idea what all is needed
to use MUSB with device tree at this point.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
