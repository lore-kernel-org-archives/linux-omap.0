From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 5/7] ARM: dts: Add nodes for missing omap4 interconnect
 target modules
Date: Fri, 13 Oct 2017 09:46:41 -0700
Message-ID: <20171013164640.GI4394@atomide.com>
References: <20170929223411.9691-1-tony@atomide.com>
 <20170929223411.9691-6-tony@atomide.com>
 <f5c57f0b-1423-c362-0fda-4069b77a2e38@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f5c57f0b-1423-c362-0fda-4069b77a2e38-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

* Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [171011 08:56]:
> On 09/30/2017 01:34 AM, Tony Lindgren wrote:
> > +		target-module@40128000 {
> > +			compatible = "ti,sysc-mcasp";
> > +			ti,hwmods = "mcasp";
> > +			reg = <0x40128004 0x4>;
> > +			reg-names = "sysc";
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			ranges = <0x00000000 0x40128000 0x1000>, /* MPU */
> > +				 <0x49028000 0x49028000 0x1000>; /* L3 */
> > +
> > +			/*
> > +			 * Child device unsupported by davinci-mcasp. At least
> > +			 * TX path is disabled for omap4, and only DIT mode
> 
> s/TX/RX
> 
> > +			 * works with no I2S. See also old Android kernel
> > +			 * omap-mcasp driver for more information.

Below is a fix for the RX comment.

Regards,

Tony

8< ------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Date: Fri, 13 Oct 2017 09:43:22 -0700
Subject: [PATCH] ARM: dts: Fix typo for omap4 mcasp rx path

As reported by Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, the rx path on macsp
is disabled and only tx is usable if the davinci-mcasp driver is updated for
it.

Reported-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/omap4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -828,7 +828,7 @@
 
 			/*
 			 * Child device unsupported by davinci-mcasp. At least
-			 * TX path is disabled for omap4, and only DIT mode
+			 * RX path is disabled for omap4, and only DIT mode
 			 * works with no I2S. See also old Android kernel
 			 * omap-mcasp driver for more information.
 			 */
-- 
2.14.2
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
