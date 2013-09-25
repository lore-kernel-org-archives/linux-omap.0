From: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/9] ARM: dts: DT data for OMAP platforms for v3.13
Date: Wed, 25 Sep 2013 17:01:00 -0500
Message-ID: <1380146469-29496-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Koen Kooi <koen-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
Cc: Devicetree Discuss <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Following series is a collection of dts patches for the below features:
crypto:
 aes, sha on am335x
 aes, des on am437x
 aes, des on omap4
display:
  beaglebone black HDMI
  am335x-evm panel

Series is based on Benoit Cousson's for_3.13/dts branch (commit sha 45646cd)
Available at: git-9UaJU3cA/F/QT0dZR+AlfA@public.gmane.org:joelagnel/linux-kernel.git (branch for-benoit)

Benoit Parrot (1):
  ARM: dts: AM33XX: Add LCDC info into am335x-evm

Darren Etheridge (1):
  dts: boneblack: add pinmux and hdmi node to enable display

Joel Fernandes (5):
  omap4: dts: Add node for AES
  omap4: dts: Add node for DES3DES module
  am33xx: dts: Fix AES interrupt number
  ARM: am437x: dts: Add AES node for am437x
  ARM: am437x: dts: Add DES node for am437x

Mark A. Greer (2):
  ARM: dts: Add SHAM data and documentation for AM33XX
  ARM: dts: Add AES data and documentation for AM33XX

 .../devicetree/bindings/crypto/omap-aes.txt        | 34 ++++++++++
 .../devicetree/bindings/crypto/omap-sham.txt       | 31 +++++++++
 arch/arm/boot/dts/am335x-bone.dts                  |  8 +++
 arch/arm/boot/dts/am335x-boneblack.dts             | 48 +++++++++++++
 arch/arm/boot/dts/am335x-evm.dts                   | 79 ++++++++++++++++++++++
 arch/arm/boot/dts/am335x-evmsk.dts                 |  8 +++
 arch/arm/boot/dts/am33xx.dtsi                      | 30 ++++++++
 arch/arm/boot/dts/am4372.dtsi                      | 16 +++++
 arch/arm/boot/dts/omap4.dtsi                       | 20 ++++++
 9 files changed, 274 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/omap-aes.txt
 create mode 100644 Documentation/devicetree/bindings/crypto/omap-sham.txt

-- 
1.8.1.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
