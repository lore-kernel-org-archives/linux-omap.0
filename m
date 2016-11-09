From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 4/9] regulator: lp873x: Add support for populating
 input supply
Date: Wed, 9 Nov 2016 14:50:13 -0700
Message-ID: <20161109215013.GF2428@atomide.com>
References: <20161021103841.8044-1-lokeshvutla@ti.com>
 <20161021103841.8044-5-lokeshvutla@ti.com>
 <20161030204118.ojeetnxl5qsi6lp7@rob-hp-laptop>
 <e5619d78-5752-c8fb-8a11-6629c4b7c3f6@ti.com>
 <20161109182618.ajqhtffure76zfnf@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161109182618.ajqhtffure76zfnf@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161109 11:26]:
> On Wed, Nov 02, 2016 at 10:58:40AM +0530, Lokesh Vutla wrote:
> > On Monday 31 October 2016 02:11 AM, Rob Herring wrote:
> > > On Fri, Oct 21, 2016 at 04:08:36PM +0530, Lokesh Vutla wrote:
> > >> In order to have a proper topology of regulators for a platform, each
> > >> registering regulator needs to populate supply_name field for identifying
> > >> its supply's name. Add supply_name field for lp873x regulators.
> > >>
> > >> Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > >> Cc: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> > >> Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
> > >> ---
> > >>  Documentation/devicetree/bindings/mfd/lp873x.txt | 8 ++++++++
> > >>  drivers/regulator/lp873x-regulator.c             | 1 +
...

> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Please send this patch separately to the regulator maintainer.

Thanks,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
