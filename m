From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 0/5] regulator/OMAP: Support TI Adaptive Body Bias(ABB)
 on-chip LDO driver
Date: Thu, 2 May 2013 12:20:09 -0500
Message-ID: <1367515215-30753-1-git-send-email-nm@ti.com>
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
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Adaptive Body Biasing (ABB) modulates transistor bias voltages
dynamically in order to optimize switching speed versus leakage.

Texas Instruments' SoC processors have an on chip LDO subsystem which
is part of the SmartReflex 2 technology and provides support for this
power management technique with Forward Body Biasing (FBB) and Reverse
Body Biasing (RBB). These modulate the body voltage of transistor
cells or blocks dynamically to gain performance and reduce leakage.

This series introduces ABB regulator and associated data for
controlling ABB module on OMAP3630+ TI SoCs. Usage of ABB LDO is part
of SoC's OPP voltage transition sequence. We just introduce the
regulator in this series for LDO control, however, the actual sequence
of control of this regulator is left to the implementation of SoC OPP
voltage transition of the appropriate domain.

Note: We only support device tree supported boot in this series.

Testing and Caveats:
	- Sanity tested on OMAP3,4,5 platforms - verified with omapconf.
	- Testing performed with regulator virtual consumer:
		http://pastebin.com/Knp1fSxA
	- OMAP5 clock nodes are introduced, but clock data is missing in
		upstream - tested with private tree with requisite clock nodes
		introduced. Clock node has been commented out in this series.

V3 of this series also available (with testing patch):
http link: https://github.com/nmenon/linux-2.6-playground/commits/devel/abb-regulator-v3
git link: git://github.com/nmenon/linux-2.6-playground.git
branch: devel/abb-regulator-v3

Changes in V3:
	- Regulator is purely meant to control ABB LDO.
	- The "regulator chaining" for doing voltage scale for entire
	  SoC voltage domain has been dropped.
	- Debugfs entries meant to expose ABB registers has been dropped as
	  the same functionality can be achieved with readmem like omapconf
	  application.
	- Re-factored regulator logic to make it simpler using the existing
	  voltage indexing support of regulator framework.
	- Implemented efuse based detection strategy and provided requisite
	  data to cover all existing OMAPs using ABB.
	- Depends on OMAP clock driver introduced in:
		http://marc.info/?t=136580758500001&r=1&w=2

V2: http://marc.info/?t=136603261400007&r=1&w=2&n=3
V1/RFC: http://marc.info/?l=linux-omap&m=136449099409794&w=2

Andrii.Tseglytskyi (5):
  regulator: Introduce TI Adaptive Body Bias(ABB) on-chip LDO driver
  ARM: dts: OMAP36xx: Add device node for ABB
  ARM: dts: OMAP443x: Add device nodes for ABB
  ARM: dts: OMAP4460: Add device nodes for ABB
  ARM: dts: OMAP5: Add device nodes for ABB

 .../bindings/regulator/ti-abb-regulator.txt        |  128 +++
 arch/arm/boot/dts/omap3.dtsi                       |    5 +
 arch/arm/boot/dts/omap36xx.dtsi                    |   20 +
 arch/arm/boot/dts/omap4.dtsi                       |   32 +
 arch/arm/boot/dts/omap443x.dtsi                    |   26 +
 arch/arm/boot/dts/omap4460.dtsi                    |   38 +
 arch/arm/boot/dts/omap5.dtsi                       |   67 ++
 drivers/regulator/Kconfig                          |   10 +
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/ti-abb-regulator.c               |  912 ++++++++++++++++++++
 10 files changed, 1239 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/ti-abb-regulator.txt
 create mode 100644 drivers/regulator/ti-abb-regulator.c

-- 
1.7.9.5
