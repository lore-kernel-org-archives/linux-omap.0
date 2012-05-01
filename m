From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: [PATCH 0/2] OMAP: mailbox initial device tree support
Date: Tue,  1 May 2012 12:47:38 -0500
Message-ID: <1335894460-19941-1-git-send-email-omar.luna@linaro.org>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, devicetree-discuss@lists.ozlabs.org
Cc: Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Omar Ramirez Luna <omar.luna@linaro.org>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org
List-Id: linux-omap@vger.kernel.org

To allow mailbox driver to function with device tree.

Tested in OMAP4 and OMAP3. OMAP2 untested.

Omar Ramirez Luna (2):
  OMAP: mailbox: add device tree support
  arm/dts: OMAP2+: Add mailbox nodes

 .../devicetree/bindings/arm/omap/mailbox.txt       |    9 +++++++++
 arch/arm/boot/dts/omap2.dtsi                       |    5 +++++
 arch/arm/boot/dts/omap3.dtsi                       |    5 +++++
 arch/arm/boot/dts/omap4.dtsi                       |    5 +++++
 arch/arm/mach-omap2/devices.c                      |    3 +++
 arch/arm/mach-omap2/mailbox.c                      |   12 ++++++++++++
 6 files changed, 39 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/mailbox.txt

-- 
1.7.4.1

