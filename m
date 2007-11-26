From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: [RFC][PATCH] ARM: OMAP: Always enable the R/W access to all
	initiators in sram
Date: Mon, 26 Nov 2007 11:07:38 +0900
Message-ID: <20071126020738.GA32424@party>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

With recent runtime constatns patches, we can't boot the board if the sram is locked.
I'm not sure it's the proper patch enables R/W access to all omap242x.
But without this patch, it gives the following messages and abort on linefecth

sram: patching 0xd7000fec with 0xd8008544
sram: will not patch address 0xd7000fec (0xd7001000): no magic
srcd 0xc0029494, srcfn 0xc00293b4, offs 0xe0, sramfn 0xd7000f10
sram: patching 0xd7000ff0 with 0xf8009060
sram: will not patch address 0xd7000ff0 (0xd7001000): no magic
srcd 0xc0029498, srcfn 0xc00293b4, offs 0xe4, sramfn 0xd7000f10
sram: patching 0xd7000ff4 with 0xd8008050
sram: will not patch address 0xd7000ff4 (0xd7001000): no magic
srcd 0xc00294a0, srcfn 0xc00293b4, offs 0xec, sramfn 0xd7000f10
sram: patching 0xd7000ffc with 0xd8004010
sram: will not patch address 0xd7000ffc (0xd7001000): no magic
srcd 0xc002958c, srcfn 0xc00294a8, offs 0xe4, sramfn 0xd7000e14
sram: patching 0xd7000ef8 with 0xd8008544
sram: will not patch address 0xd7000ef8 (0xd7001000): no magic
srcd 0xc0029590, srcfn 0xc00294a8, offs 0xe8, sramfn 0xd7000e14
sram: patching 0xd7000efc with 0xf8009060
sram: will not patch address 0xd7000efc (0xd7001000): no magic
srcd 0xc0029594, srcfn 0xc00294a8, offs 0xec, sramfn 0xd7000e14
sram: patching 0xd7000f00 with 0xf80090a4
sram: will not patch address 0xd7000f00 (0xd7001000): no magic
...
Unhandled fault: external abort on linefetch (0x806) at 0x00000000

Also we get the 'type' from CONTROL_STATUS(0x2F0) instead previous (0x2F8).

Please let me know what is the right way.

Any comments are welcome.

Thank you,
Kyungmin Park
---
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index dd8dc04..f1e0af3 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -97,15 +97,16 @@ static int is_sram_locked(void)
 		type = ctrl_read_reg(CONTROL_STATUS) & TYPE_MASK;
 #endif
 
-	if (type == GP_DEVICE) {
-		/* RAMFW: R/W access to all initiators for all qualifier sets */
-		if (cpu_is_omap242x()) {
-			__raw_writel(0xFF, VA_REQINFOPERM0); /* all q-vects */
-			__raw_writel(0xCFDE, VA_READPERM0);  /* all i-read */
-			__raw_writel(0xCFDE, VA_WRITEPERM0); /* all i-write */
-		}
+	/* RAMFW: R/W access to all initiators for all qualifier sets */
+	if (cpu_is_omap242x()) {
+		__raw_writel(0xFF, VA_REQINFOPERM0); /* all q-vects */
+		__raw_writel(0xCFDE, VA_READPERM0);  /* all i-read */
+		__raw_writel(0xCFDE, VA_WRITEPERM0); /* all i-write */
+	}
+
+	if (type == GP_DEVICE)
 		return 0;
-	} else
+	else
 		return 1; /* assume locked with no PPA or security driver */
 }
 
diff --git a/include/asm-arm/arch-omap/control.h b/include/asm-arm/arch-omap/control.h
index 5f42725..9f9075e 100644
--- a/include/asm-arm/arch-omap/control.h
+++ b/include/asm-arm/arch-omap/control.h
@@ -38,6 +38,7 @@
 #define CONTROL_DEVCONF0		(CONTROL_GENERAL + 0x04)
 #define CONTROL_DEVCONF1		(CONTROL_GENERAL + 0x68) /* > 242x */
 #define CONTROL_STATUS			(CONTROL_GENERAL + 0x80)
+#define CONTROL_STAT			(CONTROL_GENERAL + 0x88)
 
 
 /*
