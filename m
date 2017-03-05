From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 0/6] Device tree changes to add more droid 4 devices
Date: Sat,  4 Mar 2017 21:43:53 -0800
Message-ID: <20170305054359.8293-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here are few more devices we can configure for droid 4.

Note that Sebastian Reichel also just posted the LCD panel changes in
thread "[PATCHv2 00/10] Nokia N950 basic display support". The last patch
in this thread contains the related LCD panel configuration.

Regards,

Tony

Tony Lindgren (6):
  ARM: dts: omap4-droid4: Add touchscreen
  ARM: dts: omap4-droid4: Add LCD backlight
  ARM: dts: omap4-droid4: Add GPIO poweroff
  ARM: dts: omap4-droid4: Add tmp105 sensor for droid 4
  ARM: dts: omap4-droid4: Add HDMI support
  ARM: dts: omap4-droid4: Add LCD

 arch/arm/boot/dts/omap4-droid4-xt894.dts | 217 +++++++++++++++++++++++++++++++
 1 file changed, 217 insertions(+)

-- 
2.11.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
