From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 1/2] ARM: dts: am335x: Add initial support for ICEv2
 board
Date: Tue, 12 Apr 2016 14:10:46 -0700
Message-ID: <20160412211045.GD5995@atomide.com>
References: <1458704054-18152-1-git-send-email-lokeshvutla@ti.com>
 <1458704054-18152-2-git-send-email-lokeshvutla@ti.com>
 <56F265EC.5050208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56F265EC.5050208-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, nm-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> [160323 02:47]:
> On 03/23/2016 05:34 AM, Lokesh Vutla wrote:
> >TI's Industrial Communication Engine EVM is a low cost hardware mainly
> >developed for industrial communication type applications using serial
> >or Ethernet based interfaces. This platform features TI's AM3359 with
> >800MHz single core Cortex-A8 processor, 256MB DDR3, 64MB SPI flash,
> >8MB NOR Flash, mmc, usb, can, dual Ethernet ports.
> >
> >For more information, look at HW user guide[1], Data manual[2].
> >
> >Just add basic support for the moment.
> >
> >[1] http://processors.wiki.ti.com/index.php/AM335x_Industrial_Communication_Engine_EVM_Rev2_1_HW_User_Guide
> >[2] http://www.ti.com/lit/ds/symlink/am3359.pdf
> >
> >Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
> 
> Reviewed-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>

Applying this patch into omap-for-v4.7/dt thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
