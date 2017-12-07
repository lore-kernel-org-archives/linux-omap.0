From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 00/20] ARM: dts: add omap clkctrl support
Date: Thu, 7 Dec 2017 10:46:33 +0200
Message-ID: <1512636413-25243-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

This series adds the clkctrl support for omap2 family SoCs for am33xx,
am43xx, omap4, omap5, dra7 and dm81xx. This series depends on the
previously posted drivers/clk [1] + mach-omap2 [2] series for the same.

Branch pushed to my public tree:
tree: https://github.com/t-kristo/linux-pm.git
branch: 4.15-rc1-clkctrl-dts

-Tero

[1] https://www.spinics.net/lists/linux-omap/msg140587.html
[2] https://www.spinics.net/lists/linux-omap/msg140588.html

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
