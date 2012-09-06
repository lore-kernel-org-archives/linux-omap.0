From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/5] usb: phy/otg: add dt support
Date: Thu, 6 Sep 2012 20:27:05 +0530
Message-ID: <1346943430-18236-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This patch series adds device tree support for phy's (twl4030 and twl6030).

A new omap-usb2 phy driver has been added (with only dt suppport)
to perform phy configurations. Previously this configuration was
performed by twl6030, using pdata function pointers.

With the addition of omap-usb2 to perform phy configurations,
twl6030 is made as a comparator driver to detect VBUS and ID events
and notify it to the glue layer.

Previously these patches were part of
[PATCH v7 0/7] omap: musb: Add device tree support

This patch series was developed on
git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git xceiv

Kishon Vijay Abraham I (5):
  drivers: usb: phy: add a new driver for omap usb2 phy
  drivers: usb: otg: make twl6030_usb as a comparator driver to
    omap_usb2
  drivers: usb: twl6030: Add dt support for twl6030 usb
  drivers: usb: twl4030: Add device tree support for twl4030 usb
  arm: omap: phy: remove unused functions from omap-phy-internal.c

 .../devicetree/bindings/usb/twlxxxx-usb.txt        |   40 +++
 Documentation/devicetree/bindings/usb/usb-phy.txt  |   17 ++
 arch/arm/mach-omap2/omap_phy_internal.c            |  138 ----------
 arch/arm/mach-omap2/twl-common.c                   |    5 -
 arch/arm/mach-omap2/usb-musb.c                     |    3 -
 drivers/usb/otg/Kconfig                            |    2 +-
 drivers/usb/otg/twl4030-usb.c                      |   26 +-
 drivers/usb/otg/twl6030-usb.c                      |  157 ++++--------
 drivers/usb/phy/Kconfig                            |    9 +
 drivers/usb/phy/Makefile                           |    1 +
 drivers/usb/phy/omap-usb2.c                        |  271 ++++++++++++++++++++
 include/linux/usb/omap_usb.h                       |   46 ++++
 include/linux/usb/phy_companion.h                  |   34 +++
 13 files changed, 483 insertions(+), 266 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/twlxxxx-usb.txt
 create mode 100644 Documentation/devicetree/bindings/usb/usb-phy.txt
 create mode 100644 drivers/usb/phy/omap-usb2.c
 create mode 100644 include/linux/usb/omap_usb.h
 create mode 100644 include/linux/usb/phy_companion.h

-- 
1.7.9.5
