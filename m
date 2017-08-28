From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 00/17] Fix missing device tree hwmods and IO ranges omap variants
Date: Mon, 28 Aug 2017 14:19:01 -0700
Message-ID: <20170828211918.11573-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi all,

While cleaning up legacy platform data I noticed to my horror that we
are in a "half-chicken, half-egg" state with with the legacy booting
vs device tree booting instead of dealing with just the traditional
"chicken or the egg" problem.

Basically we are missing some critical dts data for "ti,hwmods" and
IO ranges for example. This data is needed by the SoC interconnect
code and things just happen to work now with the legacy platform
data still around.

Mostly this is a problem on omap4, the other SoCs only have few
nodes and properties missing.

For the missing nodes and properties, I've also updated or added the
binding documentation. For some devices, there is currently no driver
available like is the case for face detect and GPU modules for
example.

Regards,

Tony


Tony Lindgren (17):
  ARM: dts: Add missing dma hwmods property for omap3
  ARM: dts: Configure pmu without interrupt for omap4430
  ARM: dts: Add missing properties for omap4 control modules
  ARM: dts: Add missing hwmods property for omap4 dma
  ARM: dts: Add missing smartreflex node and binding for omap4
  ARM: dts: Add missing slimbus node and binding for omap4
  ARM: dts: Add missing onewire node for omap4
  ARM: dts: Add missing hsi node for omap4
  ARM: dts: Add missing iss node and binding for omap4
  ARM: dts: Add missing wdt3 node for omap4
  ARM: dts: Add missing mcasp node for omap4
  ARM: dts: Add missing aess node and binding for omap4
  ARM: dts: Add missing fdif node and binding for omap4
  ARM: dts: Add missing gpu node and binding for omap4
  ARM: dts: Add missing dma hwmod property for omap5
  ARM: dts: Add missing hwmod related nodes for am33xx
  ARM: dts: Add missing hwmod related properties for dra7

 .../devicetree/bindings/arm/omap/ctrl.txt          |   2 +
 .../devicetree/bindings/gpu/ti-powervr-sgx.txt     |  34 +++++
 Documentation/devicetree/bindings/hsi/omap-ssi.txt |   6 +-
 .../devicetree/bindings/media/ti-fdif.txt          |  37 +++++
 Documentation/devicetree/bindings/media/ti-iss.txt |  32 +++++
 .../bindings/memory-controllers/ti/emif.txt        |   6 +-
 .../devicetree/bindings/power/ti-smartreflex.txt   |  49 +++++++
 .../bindings/sound/davinci-mcasp-audio.txt         |   1 +
 .../devicetree/bindings/sound/ti-aess.txt          |  33 +++++
 .../devicetree/bindings/sound/ti-slimbus.txt       |  34 +++++
 arch/arm/boot/dts/am33xx.dtsi                      |  10 +-
 arch/arm/boot/dts/dra7.dtsi                        |  20 +++
 arch/arm/boot/dts/omap3.dtsi                       |   1 +
 arch/arm/boot/dts/omap4.dtsi                       | 151 +++++++++++++++++++--
 arch/arm/boot/dts/omap5.dtsi                       |   1 +
 15 files changed, 403 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpu/ti-powervr-sgx.txt
 create mode 100644 Documentation/devicetree/bindings/media/ti-fdif.txt
 create mode 100644 Documentation/devicetree/bindings/media/ti-iss.txt
 create mode 100644 Documentation/devicetree/bindings/power/ti-smartreflex.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ti-aess.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ti-slimbus.txt

-- 
2.14.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
