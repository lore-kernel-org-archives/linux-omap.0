From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 00/11] AM43xx EPOS EVM sleep pinmux
Date: Fri, 29 Sep 2017 11:44:18 -0500
Message-ID: <20170929164429.780-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello all,

This series adds pinmux settings useful for DeepSleep modes. This
brings the EPOS EVM more inline with the GP EVM in terms of DS0
DT support.

Thanks,
Andrew

Andrew F. Davis (10):
  ARM: dts: am43xx: Introduce additional pinmux definitions for DS0
  ARM: dts: am43xx-epos-evm: Add sleep pinmux for spi0 and spi1
  ARM: dts: am43xx-epos-evm: Add sleep pinmux for qspi1
  ARM: dts: am43xx-epos-evm: Add sleep pinmux for ecap0
  ARM: dts: am43xx-epos-evm: Add sleep pinmux for gpmc
  ARM: dts: am43xx-epos-evm: Add sleep pinmux for pixcir_ts
  ARM: dts: am43xx-epos-evm: Add sleep pinmux for mmc1
  ARM: dts: am43xx-epos-evm: Add default and sleep pinmux for uart0
  ARM: dts: am43xx-epos-evm: Add default and sleep pinmux for usb2_phy1
    and usb2_phy2
  ARM: dts: am43xx-epos-evm: Add default pinmux for unused pins

Kabir Sahane (1):
  ARM: dts: am43xx-epos-evm: Add default and sleep pinmux for
    matrix_keypad0

 arch/arm/boot/dts/am43x-epos-evm.dts | 239 ++++++++++++++++++++++++++++++++---
 include/dt-bindings/pinctrl/am43xx.h |  12 ++
 2 files changed, 230 insertions(+), 21 deletions(-)

-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
