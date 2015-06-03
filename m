From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv4 10/10] arm/dts: am57xx-beagle-x15.dts: add HDMI
Date: Wed, 3 Jun 2015 09:10:08 -0700
Message-ID: <20150603161008.GT30984@atomide.com>
References: <1433139798-23450-1-git-send-email-tomi.valkeinen@ti.com>
 <1433139798-23450-11-git-send-email-tomi.valkeinen@ti.com>
 <20150601215115.GH30984@atomide.com>
 <556EE463.6000502@ti.com>
 <20150603154438.GS30984@atomide.com>
 <556F24E6.7040003@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <556F24E6.7040003-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org> [150603 09:03]:
> 
> 
> On 03/06/15 18:44, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org> [150603 04:28]:
> >>
> >>
> >> On 02/06/15 00:51, Tony Lindgren wrote:
> >>> * Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org> [150531 23:25]:
> >>>> AM57xx Beagle X15 has a HDMI output. This patch adds the device tree
> >>>> nodes required for HDMI.
> >>>
> >>> This one does not seem to apply to linux next, did not look
> >>> further where it conflicts.
> >>
> >> Looks like the change was also in -rc6. I've rebased my patches on -rc6,
> >> and added the acks:
> >>
> >> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git dra7-dss-arch
> > 
> > OK, since there are no other merge conflicts that I'm aware of,
> > it's best that you merge the whole branch. I've acked the patches,
> > so for this one too:
> 
> Ok, I can do that, but isn't this more linux-arm stuff? All the driver
> side code is already in the mainline.

Yes but we're getting so late into merge window that I'd rather not
take it for v4.2 at this point. And it's all DSS related.

Please make sure you get an ack for the drivers/clk/omap change from
Mike or Stephen though.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
