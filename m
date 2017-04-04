From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: am57xx-idk: Add DCAN support
Date: Tue, 4 Apr 2017 08:56:26 -0700
Message-ID: <20170404155624.GQ10760@atomide.com>
References: <8981d49e7011a7246ff7dc6a9a9da0a56dfe5621.1487670384.git.nsekhar@ti.com>
 <f8862417-e9e0-e2ac-865a-9684f96a5128@ti.com>
 <20170306184113.GN20572@atomide.com>
 <042d52f4-3148-0564-a41a-5212ede042d5@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <042d52f4-3148-0564-a41a-5212ede042d5-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Schuyler Patton <spatton-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>, "Quadros, Roger" <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org> [170330 07:26]:
> Hi Tony,
> 
> On Tuesday 07 March 2017 12:11 AM, Tony Lindgren wrote:
> > * Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org> [170221 02:13]:
> >> On Tuesday 21 February 2017 03:30 PM, Sekhar Nori wrote:
> >>> From: Schuyler Patton <spatton-l0cyMroinI0@public.gmane.org>
> >>>
> >>> AM571x IDK and the AM572x IDK use CAN1 interface.
> >>> This patch enables it for both boards.
> >>>
> >>> Tested on AM572x IDK using cansequence.
> >>>
> >>> Signed-off-by: Schuyler Patton <spatton-l0cyMroinI0@public.gmane.org>
> >>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> >>> Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
> >>> [nsekhar-l0cyMroinI0@public.gmane.org: move to use DRA7XX_CORE_IOPAD())
> >>> Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> >>
> >> I should have noted that although CAN does function on the IDK with this
> >> patch, there are "omap_hwmod: dcan1: _wait_target_disable failed"
> >> messages that come up due to lack of workaround for errata i893[1]
> >>
> >> Roger does have some patches to workaround that errata. If you want to
> >> wait for those patches to be submitted and accepted first, it should be
> >> fine as well.
> > 
> > OK let's wait a bit on this then to avoid introducing extra warnings.
> 
> Now that Roger's hwmod patches for the DCAN errata are in linux-next,
> this patch can be applied safely. Let me know if you need me to resend it.

No need to resend, applying into omap-for-v4.12/dt-v2.

Thanks,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
