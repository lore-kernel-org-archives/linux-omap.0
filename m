From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: omap5-igep0050: Correct hdmi regulator
Date: Thu, 5 May 2016 11:46:09 -0700
Message-ID: <20160505184609.GB5995@atomide.com>
References: <1461925297-9734-1-git-send-email-peter.ujfalusi@ti.com>
 <6ee9d67a-e907-715a-f3f5-d90a470314c3@ti.com>
 <20160504172634.GS5995@atomide.com>
 <572A38FD.9050801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <572A38FD.9050801-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Enric Balletbo i Serra <eballetbo-VIneJrwqLopBDgjK7y7TUQ@public.gmane.org>, =?utf-8?Q?Agust=C3=AD?= Fontquerni <af-VIneJrwqLopBDgjK7y7TUQ@public.gmane.org>, Eduard Gavin <egavin-VIneJrwqLopBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [160504 11:03]:
> On 05/04/2016 12:26 PM, Tony Lindgren wrote:
> > Hi,
> > 
> > Adding Nishanth to Cc.
> > 
> > * Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [160429 05:15]:
> >> ldo7_reg, obviously ;)
> >>
> >>> 	status = "okay";
> >>> 	regulator-min-microvolt = <1800000>;
> >>> 	regulator-max-microvolt = <1800000>;
> >>> };
> > 
> > It really seems to be ldo7, otherwise there's no HDMI output. I don't
> > have the schematics either.
> > 
> > But it seems we have at least two other regressions in Linux next that
> > prevent me from testing this properly:
> > 
> > 1. On igepv5, I get this for the MMC regulator
> > 
> > ldo9: bypassed regulator has no supply!
> > ldo9: failed to get the current voltage(-517)
> > palmas-pmic 48070000.i2c:palmas@48:palmas_pmic: failed to register 48070000.i2c:palmar

The patch I posted fixes this. Then for the HDMI see below.
I've kept it at 2V like we have in omap5-board-common.dtsi,
I wonder if it really should be 1.8V though for ldo7 in this
case?

Regards,

Tony
8< -----------------
From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Date: Thu, 5 May 2016 11:29:23 -0700
Subject: [PATCH] ARM: dts: Fix ldo7 source for HDMI on igepv5

Fix ldo7 source for HDMI on igepv5.

Suggested-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

diff --git a/arch/arm/boot/dts/omap5-igep0050.dts b/arch/arm/boot/dts/omap5-igep0050.dts
index 46ecb1d..72ff6a4 100644
--- a/arch/arm/boot/dts/omap5-igep0050.dts
+++ b/arch/arm/boot/dts/omap5-igep0050.dts
@@ -35,6 +35,12 @@
 	};
 };
 
+&ldo7_reg {
+	status = "okay";
+	regulator-min-microvolt = <2000000>;
+	regulator-max-microvolt = <2000000>;
+};
+
 &omap5_pmx_core {
 	i2c4_pins: pinmux_i2c4_pins {
 		pinctrl-single,pins = <
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
