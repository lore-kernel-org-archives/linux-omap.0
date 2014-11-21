From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 0/2] Add support for ADC on am437x-gp and am43x-epos-evm
Date: Fri, 21 Nov 2014 15:44:20 +0530
Message-ID: <1416564862-23056-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This series of patches enable ADC on am437x-gp-evm and am43x-epos-evm.
tscadc DT node has been added to am437x-gp and am43x-epos DT files.
With these patches, ADC functionalities are now available on am43xx.

Change log:

v3:
Add ADC hwmod data to AM43xx hwmod file instead
of sharing hwmod structures betweem AM33xx and
AM43xx.

v2:
Removed phy addresses in hwmod. Using DT instead.
Removed unused "ti,am4372" compatible string.
Use macro to set clk domain name.
Fixed subject format of all patches


Vignesh R (2):
  ARM: OMAP2+: hwmod: AM43x: add hwmod support for ADC on AM43xx
  ARM: dts: AM43xx: add tscadc DT entries for am437x-evm and
    am43x-epos-evm

 arch/arm/boot/dts/am4372.dtsi              | 20 +++++++++++++++
 arch/arm/boot/dts/am437x-gp-evm.dts        |  8 ++++++
 arch/arm/boot/dts/am43x-epos-evm.dts       |  8 ++++++
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 39 ++++++++++++++++++++++++++++++
 4 files changed, 75 insertions(+)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
