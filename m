From: Ruslan Bilovol <ruslan.bilovol@ti.com>
Subject: [PATCH RESEND 0/1] ARM: DTS: OMAP4: Add OMAP4 Blaze Tablet support
Date: Wed, 27 Feb 2013 13:43:41 +0200
Message-ID: <1361965422-28057-1-git-send-email-ruslan.bilovol@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@arm.linux.org.uk, b-cousson@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
List-Id: linux-omap@vger.kernel.org

Hi,

This patch is a second attempt to add basic support of OMAP4 Blaze Tablet
software development platform - in this case using only Device Tree.

Additional information about this platform can be found here:
http://www.svtronics.com/omap?product_id=15

Ruslan Bilovol (1):
  ARM: DTS: OMAP4: Add OMAP4 Blaze Tablet support

 arch/arm/boot/dts/Makefile              |    1 +
 arch/arm/boot/dts/omap4-blazetablet.dts |  390 +++++++++++++++++++++++++++++++
 2 files changed, 391 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap4-blazetablet.dts

-- 
1.7.9.5
