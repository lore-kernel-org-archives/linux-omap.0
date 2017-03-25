From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2] phy: cpcap-usb: Add CPCAP PMIC USB support
Date: Sat, 25 Mar 2017 15:10:29 -0700
Message-ID: <20170325221029.GF10760@atomide.com>
References: <20170322234602.5888-1-tony@atomide.com>
 <201703260432.1EcS6tcy%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201703260432.1EcS6tcy%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org

* kbuild test robot <lkp@intel.com> [170325 13:45]:
> Hi Tony,
> 
> [auto build test ERROR on phy/next]
> [also build test ERROR on v4.11-rc3 next-20170324]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Tony-Lindgren/phy-cpcap-usb-Add-CPCAP-PMIC-USB-support/20170324-061112
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git next
> config: x86_64-randconfig-a0-03260238 (attached as .config)
> compiler: gcc-4.4 (Debian 4.4.7-8) 4.4.7
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/built-in.o: In function `cpcap_usb_detect':
> >> phy-cpcap-usb.c:(.text+0x18ad): undefined reference to `iio_read_channel_processed'
>    drivers/built-in.o: In function `cpcap_usb_phy_probe':
> >> phy-cpcap-usb.c:(.text+0x1c5e): undefined reference to `devm_iio_channel_get'
> >> phy-cpcap-usb.c:(.text+0x1c92): undefined reference to `iio_get_channel_type'

OK thanks for the report, we need IIO for VBUS level, here's
a patch to fix it.

Regards,

Tony

8< -----------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Sat, 25 Mar 2017 15:04:37 -0700
Subject: [PATCH] phy: cpcap-usb: Fix build by adding a dependency to
 CONFIG_IIO

We need the ADC output provided by IIO to detect VBUS level.
Otherwise we can get:

drivers/built-in.o: In function `cpcap_usb_detect':
phy-cpcap-usb.c:(.text+0x18ad): undefined reference to
`iio_read_channel_processed'
drivers/built-in.o: In function `cpcap_usb_phy_probe':
phy-cpcap-usb.c:(.text+0x1c5e): undefined reference to
`devm_iio_channel_get'
phy-cpcap-usb.c:(.text+0x1c92): undefined reference to`iio_get_channel_type'

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/phy/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -49,7 +49,7 @@ config PHY_BERLIN_SATA
 
 config PHY_CPCAP_USB
 	tristate "CPCAP USB PHY driver"
-	depends on USB_SUPPORT
+	depends on USB_SUPPORT && IIO
 	select GENERIC_PHY
 	select USB_PHY
 	help
-- 
2.12.1
