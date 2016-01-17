From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/5] Nokia N950 modem support
Date: Sun, 17 Jan 2016 16:49:04 +0100
Message-ID: <1453045749-22642-1-git-send-email-sre@kernel.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

This patchset adds support for the N950 modem. Afterwards it can be
used with ofono in the same way, that the N900's modem can be used [0].

In addition to the kernel patchset, ofono must be modified slightly, though.
The cbs interface from the N950 modem seems to be broken resulting in modem
reset. The below ofono patch is enough to get it running for the N950.

[0] https://lkml.org/lkml/2014/5/10/167

-- Sebastian

diff --git a/plugins/n900.c b/plugins/n900.c
index 44e2e75df3d9..1454d010cb2c 100644
--- a/plugins/n900.c
+++ b/plugins/n900.c
@@ -507,7 +507,7 @@ static void n900_post_online(struct ofono_modem *modem)
 
 	ofono_netreg_create(modem, 0, "isimodem", isi->modem);
 	ofono_sms_create(modem, 0, "isimodem", isi->modem);
-	ofono_cbs_create(modem, 0, "isimodem", isi->modem);
+	//ofono_cbs_create(modem, 0, "isimodem", isi->modem);
 	ofono_ussd_create(modem, 0, "isimodem", isi->modem);
 	ofono_call_settings_create(modem, 0, "isimodem", isi->modem);
 	ofono_call_barring_create(modem, 0, "isimodem", isi->modem);
---

Sebastian Reichel (5):
  ARM: OMAP2+: hwmod data: Add SSI data for omap36xx
  ARM: dts: OMAP3-N950-N9: Enable SSI module
  HSI: nokia-modem: add n950 and n9 support
  HSI: ssi-protocol: Use handshake logic from n950
  ARM: dts: OMAP3-N950-N9: Enable modem

 .../devicetree/bindings/hsi/nokia-modem.txt        | 12 ++--
 arch/arm/boot/dts/omap3-n9.dts                     |  4 ++
 arch/arm/boot/dts/omap3-n950-n9.dtsi               | 64 ++++++++++++++++++++++
 arch/arm/boot/dts/omap3-n950.dts                   |  4 ++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         | 13 +++--
 drivers/hsi/clients/nokia-modem.c                  |  2 +
 drivers/hsi/clients/ssi_protocol.c                 | 16 ++----
 7 files changed, 93 insertions(+), 22 deletions(-)

-- 
2.7.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
