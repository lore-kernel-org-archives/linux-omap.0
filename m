From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCHv2 0/3] Configure USB Ethernet mac for omap4 and 5
Date: Thu,  5 Jan 2017 08:37:00 -0800
Message-ID: <20170105163703.1982-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

Here are these patches reposted using the hub naming.

Regards,

Tony


Tony Lindgren (3):
  ARM: dts: pandaboard: Allow bootloader to configure USB Ethernet MAC
  ARM: dts: omap5-uevm: Allow bootloader to configure USB Ethernet MAC
  ARM: dts: omap5-igep0050: Allow bootloader to configure USB Ethernet
    MAC

 arch/arm/boot/dts/omap4-panda-common.dtsi | 16 ++++++++++++++++
 arch/arm/boot/dts/omap5-igep0050.dts      | 21 +++++++++++++++++++++
 arch/arm/boot/dts/omap5-uevm.dts          | 21 +++++++++++++++++++++
 3 files changed, 58 insertions(+)

-- 
2.11.0
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
