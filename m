From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH] ARM: OMAP: Update board-n800-audio.c with fixes done after
 first release
Date: Fri, 2 Mar 2007 12:14:59 +0200
Message-ID: <20070302121459.0316dd03.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

- Update TSC2301 clock function names
- Fix calling order in n800_eac_disable_ext_clocks
- Remove needless codec PLL startup delay. Codec driver will take care of it
- Separate EAC and sys_clkout2 pin multiplexing

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/mach-omap2/board-n800-audio.c |   59 ++++++++++++++++++-------------
 1 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n800-audio.c b/arch/arm/mach-omap2/board-n800-audio.c
index 8e36691..b5b107d 100644
--- a/arch/arm/mach-omap2/board-n800-audio.c
+++ b/arch/arm/mach-omap2/board-n800-audio.c
@@ -23,7 +23,6 @@
 
 #include <linux/err.h>
 #include <linux/clk.h>
-#include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/spi/tsc2301.h>
 
@@ -44,47 +43,63 @@ static int enable_audio;
 static int audio_ok;
 static spinlock_t audio_lock;
 
-
 /*
- * Leaving EAC pins multiplexed to EAC functionality results
- * in about 2 mA extra current leaked. The workaround is to
- * multiplex the EAC pins to protected mode (with pull-ups enabled)
+ * Leaving EAC and sys_clkout2 pins multiplexed to those subsystems results
+ * in about 2 mA extra current leak when audios are powered down. The
+ * workaround is to multiplex them to protected mode (with pull-ups enabled)
  * whenever audio is not being used.
  */
-static int mux_disabled;
+static int eac_mux_disabled = 0;
+static int clkout2_mux_disabled = 0;
 static u32 saved_mux[2];
 
 static void n800_enable_eac_mux(void)
 {
-	if (!mux_disabled)
+	if (!eac_mux_disabled)
 		return;
-	__raw_writel(saved_mux[0], IO_ADDRESS(0x480000e8));
 	__raw_writel(saved_mux[1], IO_ADDRESS(0x48000124));
-	mux_disabled = 0;
+	eac_mux_disabled = 0;
 }
 
 static void n800_disable_eac_mux(void)
 {
+	if (eac_mux_disabled) {
+		WARN_ON(eac_mux_disabled);
+		return;
+	}
+	saved_mux[1] = __raw_readl(IO_ADDRESS(0x48000124));
+	__raw_writel(0x1f1f1f1f, IO_ADDRESS(0x48000124));
+	eac_mux_disabled = 1;
+}
+
+static void n800_enable_clkout2_mux(void)
+{
+	if (!clkout2_mux_disabled)
+		return;
+	__raw_writel(saved_mux[0], IO_ADDRESS(0x480000e8));
+	clkout2_mux_disabled = 0;
+}
+
+static void n800_disable_clkout2_mux(void)
+{
 	u32 l;
 
-	if (mux_disabled) {
-		WARN_ON(mux_disabled);
+	if (clkout2_mux_disabled) {
+		WARN_ON(clkout2_mux_disabled);
 		return;
 	}
 	saved_mux[0] = __raw_readl(IO_ADDRESS(0x480000e8));
-	saved_mux[1] = __raw_readl(IO_ADDRESS(0x48000124));
 	l = saved_mux[0] & ~0xff;
 	l |= 0x1f;
 	__raw_writel(l, IO_ADDRESS(0x480000e8));
-	__raw_writel(0x1f1f1f1f, IO_ADDRESS(0x48000124));
-	mux_disabled = 1;
+	clkout2_mux_disabled = 1;
 }
 
 static int n800_eac_enable_ext_clocks(struct device *dev)
 {
 	BUG_ON(tsc2301_device == NULL);
 	n800_enable_eac_mux();
-	tsc2301_enable_mclk(tsc2301_device);
+	tsc2301_mixer_enable_mclk(tsc2301_device);
 
 	return 0;
 }
@@ -92,8 +107,8 @@ static int n800_eac_enable_ext_clocks(struct device *dev)
 static void n800_eac_disable_ext_clocks(struct device *dev)
 {
 	BUG_ON(tsc2301_device == NULL);
+	tsc2301_mixer_disable_mclk(tsc2301_device);
 	n800_disable_eac_mux();
-	tsc2301_disable_mclk(tsc2301_device);
 }
 
 static int n800_audio_set_power(void *pdata, int dac, int adc)
@@ -199,20 +214,14 @@ static void n800_codec_put_clocks(struct device *dev)
 
 static int n800_codec_enable_clock(struct device *dev)
 {
-	int err;
-
-	err = clk_enable(sys_clkout2);
-	if (err)
-		return err;
-	/* TODO: 'educated' guess for audio codec's PLL startup delay */
-	mdelay(1);
-
-	return 0;
+	n800_enable_clkout2_mux();
+	return clk_enable(sys_clkout2);
 }
 
 static void n800_codec_disable_clock(struct device *dev)
 {
 	clk_disable(sys_clkout2);
+	n800_disable_clkout2_mux();
 }
 
 static int n800_codec_init(struct device *dev)
-- 
1.4.4.4
