From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v4 5/5] ARM: multi_v7_defconfig: Enable LP872x regulator
 support
Date: Mon, 29 Feb 2016 14:57:06 -0800
Message-ID: <20160229225705.GS13417@atomide.com>
References: <1456663185-14170-1-git-send-email-contact@paulk.fr>
 <1456663185-14170-6-git-send-email-contact@paulk.fr>
 <20160229215446.GP13417@atomide.com>
 <3559918.7gA8u2p4Bl@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3559918.7gA8u2p4Bl@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> [160229 13:59]:
> On Monday 29 February 2016 13:54:46 Tony Lindgren wrote:
> > * Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org> [160228 04:40]:
> > > The LP872x regulator is used in the LG Optimus Black codename sniper to supply
> > > the external mmc card.
> > 
> > This patch needs to be sent directly to arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org to avoid
> > merge conflicts. I've picked the omap2plus_defconfig related change
> > into omap-for-v4.6/defconfig.
> 
> I'd actually prefer it as part of the omap-for-v4.6/defconfig branch.
> Taking care of merge conflicts is easy.

OK will apply then.

Thanks,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
