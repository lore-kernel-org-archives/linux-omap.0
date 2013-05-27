From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v2 05/14] ARM: OMAP2+: AM437x: SoC revision detection
Date: Mon, 27 May 2013 20:06:01 +0530
Message-ID: <1aa201188d55a4fb5b4d039bff379207321de144.1369658705.git.afzal@ti.com>
References: <cover.1369658705.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1369658705.git.afzal@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Benoit Cousson <benoit.cousson@linaro.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>
List-Id: linux-omap@vger.kernel.org

Detect 437x SoC revision.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/id.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 44be835..c9c3f7d 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -209,6 +209,8 @@ static void __init omap3_cpuinfo(void)
 		cpu_name = "TI816X";
 	} else if (soc_is_am335x()) {
 		cpu_name =  "AM335X";
+	} else if (soc_is_am437x()) {
+		cpu_name =  "AM437x";
 	} else if (cpu_is_ti814x()) {
 		cpu_name = "TI814X";
 	} else if (omap3_has_iva() && omap3_has_sgx()) {
@@ -443,6 +445,10 @@ void __init omap3xxx_check_revision(void)
 			break;
 		}
 		break;
+	case 0xb98c:
+		omap_revision = AM437X_REV_ES1_0;
+		cpu_rev = "1.0";
+		break;
 	case 0xb8f2:
 		switch (rev) {
 		case 0:
-- 
1.7.12
