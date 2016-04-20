From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/2] DRA7x: Increase QSPI frequency to 64MHz
Date: Wed, 20 Apr 2016 17:02:58 +0530
Message-ID: <1461151980-28139-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org



This patch series increases QSPI bus frequency to 64MHz and switch to
SPI mode 0 in order to increase read/write throughput.
First patch removes QSPI pinmux from DT as pinmux can only be done in
U-Boot(see patch commit message for more info). Second patch does the
dts changes to support 64MHz mode 0 operation.


Tested on DRA74 and DRA72 EVM with U-Boot 2016.05-rc1.


Vignesh R (2):
  ARM: dts: dra7x: Remove QSPI pinmux
  ARM: dts: dra7x: Support QSPI MODE-0 operation at 64MHz

 Documentation/devicetree/bindings/spi/ti_qspi.txt |  7 +++++++
 arch/arm/boot/dts/dra7-evm.dts                    | 23 ++---------------------
 arch/arm/boot/dts/dra72-evm-common.dtsi           | 20 ++------------------
 3 files changed, 11 insertions(+), 39 deletions(-)

-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
