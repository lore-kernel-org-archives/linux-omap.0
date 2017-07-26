From: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/3] ARM: dts: am335x-evm: am437xx: dra7xx: Enable NAND DMA prefetch by default
Date: Tue, 25 Jul 2017 21:15:49 -0500
Message-ID: <20170726021552.19880-1-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Enable NAND DMA prefetch by default for AM335x, AM437x and DRA7x evms that
include NAND.

The below commit went into additional details regarding performance numbers
seen between the two modes.

commit aa7abd312c11 ("mtd: nand: omap2: Support parsing dma channel information from DT")

Franklin S Cooper Jr (3):
  ARM: dts: am335x-evm: Enable NAND dma prefetch by default
  ARM: dts: am437xx: Enable NAND dma prefetch by default
  ARM: dts: dra7xx: Enable NAND dma prefetch by default

 arch/arm/boot/dts/am335x-evm.dts        | 1 +
 arch/arm/boot/dts/am437x-gp-evm.dts     | 1 +
 arch/arm/boot/dts/am43x-epos-evm.dts    | 1 +
 arch/arm/boot/dts/dra7-evm.dts          | 1 +
 arch/arm/boot/dts/dra72-evm-common.dtsi | 1 +
 5 files changed, 5 insertions(+)

-- 
2.10.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
