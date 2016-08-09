From: Wolfram Sang <wsa-dev-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
Subject: [PATCH] i2c: don't print error when adding adapter fails
Date: Tue,  9 Aug 2016 13:36:16 +0200
Message-ID: <1470742581-12971-1-git-send-email-wsa-dev@sang-engineering.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-dev-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, adi-buildroot-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Since v4.8-rc1, the I2C core will print detailed information when adding an I2C
adapter fails. So, drivers can skip this now.

I am still undecided if I apply this as a single patch or break it out. But for
reviewing, avoiding the patch bomb is probably a good thing.

Should go via subsystem tree, I'd think.

Wolfram Sang (1):
  i2c: don't print error when adding adapter fails

 drivers/i2c/busses/i2c-amd756.c         | 5 +----
 drivers/i2c/busses/i2c-at91.c           | 2 --
 drivers/i2c/busses/i2c-axxia.c          | 8 +-------
 drivers/i2c/busses/i2c-bcm-iproc.c      | 8 +-------
 drivers/i2c/busses/i2c-bcm-kona.c       | 4 +---
 drivers/i2c/busses/i2c-bfin-twi.c       | 4 +---
 drivers/i2c/busses/i2c-brcmstb.c        | 4 +---
 drivers/i2c/busses/i2c-cadence.c        | 4 +---
 drivers/i2c/busses/i2c-cpm.c            | 4 +---
 drivers/i2c/busses/i2c-cros-ec-tunnel.c | 4 +---
 drivers/i2c/busses/i2c-davinci.c        | 4 +---
 drivers/i2c/busses/i2c-diolan-u2c.c     | 4 +---
 drivers/i2c/busses/i2c-dln2.c           | 4 +---
 drivers/i2c/busses/i2c-efm32.c          | 1 -
 drivers/i2c/busses/i2c-exynos5.c        | 4 +---
 drivers/i2c/busses/i2c-hix5hd2.c        | 4 +---
 drivers/i2c/busses/i2c-i801.c           | 1 -
 drivers/i2c/busses/i2c-ibm_iic.c        | 4 +---
 drivers/i2c/busses/i2c-img-scb.c        | 4 +---
 drivers/i2c/busses/i2c-imx.c            | 4 +---
 drivers/i2c/busses/i2c-isch.c           | 4 +---
 drivers/i2c/busses/i2c-ismt.c           | 4 +---
 drivers/i2c/busses/i2c-jz4780.c         | 4 +---
 drivers/i2c/busses/i2c-lpc2k.c          | 4 +---
 drivers/i2c/busses/i2c-meson.c          | 1 -
 drivers/i2c/busses/i2c-mpc.c            | 4 +---
 drivers/i2c/busses/i2c-mt65xx.c         | 4 +---
 drivers/i2c/busses/i2c-mxs.c            | 1 -
 drivers/i2c/busses/i2c-nforce2.c        | 1 -
 drivers/i2c/busses/i2c-nomadik.c        | 4 +---
 drivers/i2c/busses/i2c-ocores.c         | 4 +---
 drivers/i2c/busses/i2c-octeon.c         | 4 +---
 drivers/i2c/busses/i2c-omap.c           | 4 +---
 drivers/i2c/busses/i2c-piix4.c          | 1 -
 drivers/i2c/busses/i2c-pmcmsp.c         | 4 +---
 drivers/i2c/busses/i2c-pnx.c            | 4 +---
 drivers/i2c/busses/i2c-puv3.c           | 5 +----
 drivers/i2c/busses/i2c-pxa.c            | 4 +---
 drivers/i2c/busses/i2c-rcar.c           | 4 +---
 drivers/i2c/busses/i2c-riic.c           | 4 +---
 drivers/i2c/busses/i2c-rk3x.c           | 4 +---
 drivers/i2c/busses/i2c-s3c2410.c        | 1 -
 drivers/i2c/busses/i2c-sh7760.c         | 4 +---
 drivers/i2c/busses/i2c-sh_mobile.c      | 1 -
 drivers/i2c/busses/i2c-sirf.c           | 4 +---
 drivers/i2c/busses/i2c-st.c             | 4 +---
 drivers/i2c/busses/i2c-stu300.c         | 5 +----
 drivers/i2c/busses/i2c-tegra.c          | 4 +---
 drivers/i2c/busses/i2c-uniphier-f.c     | 7 +------
 drivers/i2c/busses/i2c-uniphier.c       | 7 +------
 drivers/i2c/busses/i2c-wmt.c            | 4 +---
 drivers/i2c/busses/i2c-xgene-slimpro.c  | 1 -
 drivers/i2c/busses/i2c-xiic.c           | 1 -
 drivers/i2c/busses/i2c-xlp9xx.c         | 4 +---
 drivers/i2c/busses/i2c-xlr.c            | 4 +---
 55 files changed, 44 insertions(+), 161 deletions(-)

-- 
2.8.1
