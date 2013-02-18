From: Afzal Mohammed <afzal@ti.com>
Subject: [RFC 4/8] ARM: am33xx: ll debug config help
Date: Mon, 18 Feb 2013 12:00:27 +0530
Message-ID: <bfe941adb98a5000c2817f9fd6160070e59e53c9.1361166003.git.afzal@ti.com>
References: <cover.1361166003.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1361166003.git.afzal@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Marc Zyngier <marc.zyngier@arm.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Will Deacon <will.deacon@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, Sekhar Nori <nsekhar@ti.com>, Syed Mohammed Khasim <khasim@ti.com>
List-Id: linux-omap@vger.kernel.org

Selecting DEBUG_AM33XXUART1 routes low level debug messages to first
UART instance of AM335x based SoC's. This selection is valid for
upcoming AM43 based SoC's too. Make this information available upon
configuring.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/Kconfig.debug | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index acdddda..b717b78 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -542,6 +542,9 @@ choice
 
 	config DEBUG_AM33XXUART1
 		bool "AM33XX UART1"
+		help
+		  Route low level debug messages to first uart instance
+		  for boards based on am335 and am43 family of SoC's
 
 	config DEBUG_ZOOM_UART
 		bool "Zoom2/3 UART"
-- 
1.7.12
