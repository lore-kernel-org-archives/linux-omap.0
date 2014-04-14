From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/2] ARM: dts: DRA7/AM4372: add l3_noc information
Date: Mon, 14 Apr 2014 14:12:44 -0500
Message-ID: <1397502766-13994-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Patch series based on:
v3.15-rc1 tag.

Depends on series posted: http://marc.info/?l=linux-omap&m=139749383932575&w=2

DTS Patches is available here:
https://github.com/nmenon/linux-2.6-playground/commits/l3noc/dts-fixes

This just adds the dts information based on driver support provided.

Test log:
1: am43xx-epos:  Boot PASS: http://slexy.org/raw/s2pjavFUYd
2: DRA7xx-EVM:  Boot PASS: http://slexy.org/raw/s21pdAj0hU
3: pandaboard-es:  Boot PASS: http://slexy.org/raw/s21Hsq97mt
4:    sdp4430:  Boot PASS: http://slexy.org/raw/s2ZQJUqjrP
5: OMAP5432uEVM:  Boot PASS: http://slexy.org/raw/s2hNulLOuX

Afzal Mohammed (1):
  ARM: dts: AM4372: add l3-noc information

Rajendra Nayak (1):
  ARM: dts: DRA7: Use dra7-l3-noc instead of omap4-l3-noc

 arch/arm/boot/dts/am4372.dtsi |    6 +++++-
 arch/arm/boot/dts/dra7.dtsi   |    6 +++---
 2 files changed, 8 insertions(+), 4 deletions(-)

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
