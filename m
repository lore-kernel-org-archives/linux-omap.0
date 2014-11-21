From: Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 00/11] Exynos7: Adding USB 3.0 support
Date: Fri, 21 Nov 2014 19:05:43 +0530
Message-ID: <1416576954-11997-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The series has dependency on
a) "[PATCH v7 0/7] Enable support for Samsung Exynos7 SoC"
   http://www.spinics.net/lists/linux-samsung-soc/msg38734.html
b) "[GIT PULL] Samsung clock changes for 3.19" - specifically the clock dt
   bindings header.
   http://comments.gmane.org/gmane.linux.kernel.samsung-soc/39142
c) "tty: serial: samsung: Clean-up selection of number of available UARTs"
   http://www.spinics.net/lists/linux-samsung-soc/msg37418.html
d) "dts, kbuild: Implement support for dtb vendor subdirs"(merged in linux-next)
   https://lkml.org/lkml/2014/10/21/654
e) "Samsung pinctrl patches for v3.19"
   http://www.spinics.net/lists/linux-samsung-soc/msg38744.html

Tested on Exynos7-espresso board with 3.18-rc5 and above dependencies.

Clubbing the pinctrl, clk, and usb driver changes alongwith the dt changes
together in this series only so as to avoid having 'n' number of dependencies.

The USB driver patches in this series were part of [1] sent earlier.
[1] [PATCH v2 0/4] usb: dwc3/phy-exynos5-usbdrd: Extend support to Exynos7
    https://lkml.org/lkml/2014/10/7/191

Vivek Gautam (11):
  pinctrl: exynos: Add BUS1 pin controller for exynos7
  dwc3: exynos: Remove local variable for clock from probe
  dwc3: exynos: Add provision for suspend clock
  dwc3: exynos: Add provision for AXI UpScaler clock on exynos7
  phy: exynos5-usbdrd: Add pipe-clk, utmi-clk and itp-clk support
  phy: exynos5-usbdrd: Add facility for VBUS-BOOST-5V supply
  phy: exynos7-usbdrd: Update dependency for ARCH_EXYNOS
  clk: exynos7: Add required clock tree for USB
  arm64: exynos: Add bus1 pinctrl node on exynos7
  arm64: dts: Enable USB 3.0 controller on exynos7
  arm64: dts: exynos7-espresso: Add regulators for Vbus and Vbus-Boost

 .../devicetree/bindings/phy/samsung-phy.txt        |    6 +
 .../devicetree/bindings/usb/exynos-usb.txt         |    6 +-
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts    |   43 +++++++
 arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi    |   26 ++++
 arch/arm64/boot/dts/exynos/exynos7.dtsi            |   42 ++++++
 drivers/clk/samsung/clk-exynos7.c                  |   64 +++++++++
 drivers/phy/Kconfig                                |    2 +-
 drivers/phy/phy-exynos5-usbdrd.c                   |  136 +++++++++++++++++---
 drivers/pinctrl/samsung/pinctrl-exynos.c           |   12 ++
 drivers/usb/dwc3/dwc3-exynos.c                     |   39 +++++-
 include/dt-bindings/clock/exynos7-clk.h            |    9 +-
 11 files changed, 354 insertions(+), 31 deletions(-)

-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
