From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] pinctrl: dra: dt-bindings: Fix pull enable/disable
Date: Wed, 23 Jul 2014 01:46:57 -0700
Message-ID: <20140723084657.GA22006@atomide.com>
References: <1406043594-14181-1-git-send-email-nm@ti.com>
 <20140722164752.GJ20588@saruman.home>
 <53CEAE0F.9080901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53CEAE0F.9080901-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [140722 11:34]:
> On 07/22/2014 11:47 AM, Felipe Balbi wrote:
> > On Tue, Jul 22, 2014 at 10:39:54AM -0500, Nishanth Menon wrote:
> >> The DRA74/72 control module pins have a weak pull up and pull down.
> >> This is configured by bit offset 17. if BIT(17) is 1, a pull up is
> >> selected, else a pull down is selected.
> >>
> >> However, this pull resisstor is applied based on BIT(16) -
> >> PULLUDENABLE - if BIT(18) is *0*, then pull as defined in BIT(17) is
> >> applied, else no weak pulls are applied. We defined this in reverse.
> >>
> >> Reference: Table 18-5 (Description of the pad configuration register
> >> bits) in Technical Reference Manual Revision (DRA74x revision Q:
> >> SPRUHI2Q Revised June 2014 and DRA72x revision F: SPRUHP2F - Revised
> >> June 2014)
> >>
> >> Fixes: 6e58b8f1daaf1a ("ARM: dts: DRA7: Add the dts files for dra7 SoC and dra7-evm board")
> >> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> >> ---
> > 
> > Tested on an upcoming board.
> > 
> > Tested-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> > Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> > 
> > 
> Felipe,
> Thanks.
> 
> Tony,
> 
> If you could consider this for the rc cycle it might be great(as well
> as for stable). The pull direction error can cause all kinds of
> Pull-down Vs Pull-Up contention with severe risk for certain IP
> reliability.

Yes this is a good one for the -rc cycle, applying into
omap-for-v3.16/fixes.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
