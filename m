From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v2 3/3] ARM: dts: dra72-evm: drop NAND support
Date: Tue, 13 Dec 2016 16:59:47 +0530
Message-ID: <a2d251a432c5c8519dd31441a6427a261b16ca79.1481628266.git.nsekhar@ti.com>
References: <cover.1481628266.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1481628266.git.nsekhar@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

For the existing IOdelay configuration via U-Boot, NAND is
not supported on dra72-evm (both Rev B and Rev C).

Disable it. Commit 46cfc8945887 ("ARM: dts: dra72-evm: Remove
pinmux configurations for erratum i869") has already removed
pinmuxing for NAND making it unusable.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/dra72-evm-common.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra72-evm-common.dtsi b/arch/arm/boot/dts/dra72-evm-common.dtsi
index e50fbeea96e0..64553476c678 100644
--- a/arch/arm/boot/dts/dra72-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra72-evm-common.dtsi
@@ -280,7 +280,12 @@
 };
 
 &gpmc {
-	status = "okay";
+	/*
+	 * For the existing IOdelay configuration via U-Boot we don't
+	 * support NAND on dra72-evm. Keep it disabled. Enabling it
+	 * requires a different configuration by U-Boot.
+	 */
+	status = "disabled";
 	ranges = <0 0 0x08000000 0x01000000>;	/* minimum GPMC partition = 16MB */
 	nand@0,0 {
 		/* To use NAND, DIP switch SW5 must be set like so:
-- 
2.9.0
