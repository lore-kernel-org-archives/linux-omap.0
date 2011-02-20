From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH resend] omap: Fix linker error in
	drivers/video/omap/lcd_2430sdp.c
Date: Sun, 20 Feb 2011 22:04:08 +0200
Message-ID: <1298232248-347-1-git-send-email-jhnikula@gmail.com>
References: <1298193466-29534-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1298193466-29534-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

There is a linker error from lcd_2430sdp.c if CONFIG_TWL4030_CORE is not
set. This can be triggered on OMAP2 builds where OMAP3 or OMAP4 are not set.

drivers/built-in.o: In function `sdp2430_panel_disable':
drivers/video/omap/lcd_2430sdp.c:123: undefined reference to `twl_i2c_write_u8'
drivers/video/omap/lcd_2430sdp.c:124: undefined reference to `twl_i2c_write_u8'
drivers/built-in.o: In function `sdp2430_panel_enable':
drivers/video/omap/lcd_2430sdp.c:110: undefined reference to `twl_i2c_write_u8'
drivers/video/omap/lcd_2430sdp.c:112: undefined reference to `twl_i2c_write_u8'

Fix this by adding TWL4030_CORE dependency to CONFIG_MACH_OMAP_2430SDP as
there is no own entry in drivers/video/omap/Kconfig.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
Resend = forgot to cc LAKML.
Quite old issue most probably. Can be triggered in mainline anyway.
---
 arch/arm/mach-omap2/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index b9d8a7b..bfdf240 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -132,6 +132,7 @@ config MACH_OMAP_2430SDP
 	depends on SOC_OMAP2430
 	default y
 	select OMAP_PACKAGE_ZAC
+	select TWL4030_CORE
 
 config MACH_OMAP3_BEAGLE
 	bool "OMAP3 BEAGLE board"
-- 
1.7.0.4
