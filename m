From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 0/4] omap hsmmc device tree support
Date: Mon, 12 Mar 2012 20:32:36 +0530
Message-ID: <1331564560-23276-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
To: robherring2@gmail.com, grant.likely@secretlab.ca, cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balajitk@ti.com, svenkatr@ti.com, linaro-dev@lists.linaro.org, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

The series adds device tree support for OMAP hsmmc
driver.

Changes in V2:
-1- Minor fixes based on comments from Grant.
-2- Added a seperate compatible for omap3.
-3- Added a new binding "ti,needs-special-reset"
to handle some mmc modules which need special
softreset sequence.
-4- Updated board dts files with "status = disable;"
for unused mmc modules.

Rob,
I retained your ack on patch 1 despite the additional
binding that I added to handle the special softreset
sequence. Let me know if you have any issues with it.

Chris.
Patch 1 and Patch 2 apply cleanly on mmc-next and can
be taken in from the mmc tree after relevent acks from
DT folks.
Patch 3 and Patch 4 which update dts files, I plan to
push via linux-omap/Tony's tree.

The series is tested on omap4sdp (both external and emmc),
omap4panda amd omap3beagle boards.

Things to do:
-1- Card detect isn't functional and needs twl4030 gpio
to be DT converted.
-2- pbias cell programming is missing and needs an OMAP
control module driver.

Rajendra Nayak (4):
  mmc: omap_hsmmc: Convert hsmmc driver to use device tree
  mmc: omap_hsmmc: Avoid a regulator voltage change with dt
  arm/dts: OMAP4: Add mmc controller nodes and board data
  arm/dts: OMAP3: Add mmc controller nodes and board data

 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   33 +++++++
 arch/arm/boot/dts/omap3-beagle.dts                 |   14 +++
 arch/arm/boot/dts/omap3.dtsi                       |   16 ++++
 arch/arm/boot/dts/omap4-panda.dts                  |   22 +++++
 arch/arm/boot/dts/omap4-sdp.dts                    |   24 ++++++
 arch/arm/boot/dts/omap4.dtsi                       |   31 +++++++
 drivers/mmc/host/omap_hsmmc.c                      |   88 +++++++++++++++++++-
 7 files changed, 227 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt

