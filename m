From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] urgent onenand file system corruption fix for n900
Date: Fri, 8 Jan 2016 08:32:50 -0800
Message-ID: <20160108163250.GT12777@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 0b4d6972d7b052b23d33ff9bdbb52958664fbb26:

  ARM: dts: Fix UART wakeirq for omap4 duovero parlor (2015-12-18 16:43:22 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.4/onenand-corruption

for you to fetch changes up to e7b11dc7b77bfce0a351230a5feeadc1d0bba997:

  ARM: OMAP2+: Fix onenand rate detection to avoid filesystem corruption (2016-01-06 09:21:09 -0800)

----------------------------------------------------------------
Last minute urgent pull request to prevent file system corruption
on Nokia N900.

Looks like we have a GPMC bus timing bug that has gone unnoticed
because of bootloader configured registers until few days ago. We
are not detecting the onenand clock rate properly unless we have
CONFIG_OMAP_GPMC_DEBUG set and this causes onenand corruption
that can be easily be reproduced.

There seems to be also an additional bug still lurking around for
onenand corruption. But that is still being investigated and
it does not seem to be GPMC timings related.

Meanwhile, it would be good to get this fix into v4.4 to prevent
wrong timings from corrupting onenand.

----------------------------------------------------------------
Tony Lindgren (1):
      ARM: OMAP2+: Fix onenand rate detection to avoid filesystem corruption

 arch/arm/mach-omap2/gpmc-onenand.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -149,8 +149,8 @@ static int omap2_onenand_get_freq(struct omap_onenand_platform_data *cfg,
 		freq = 104;
 		break;
 	default:
-		freq = 54;
-		break;
+		pr_err("onenand rate not detected, bad GPMC async timings?\n");
+		freq = 0;
 	}
 
 	return freq;
@@ -271,6 +271,11 @@ static int omap2_onenand_setup_async(void __iomem *onenand_base)
 	struct gpmc_timings t;
 	int ret;
 
+	/*
+	 * Note that we need to keep sync_write set for the call to
+	 * omap2_onenand_set_async_mode() to work to detect the onenand
+	 * supported clock rate for the sync timings.
+	 */
 	if (gpmc_onenand_data->of_node) {
 		gpmc_read_settings_dt(gpmc_onenand_data->of_node,
 				      &onenand_async);
@@ -281,12 +286,9 @@ static int omap2_onenand_setup_async(void __iomem *onenand_base)
 			else
 				gpmc_onenand_data->flags |= ONENAND_SYNC_READ;
 			onenand_async.sync_read = false;
-			onenand_async.sync_write = false;
 		}
 	}
 
-	omap2_onenand_set_async_mode(onenand_base);
-
 	omap2_onenand_calc_async_timings(&t);
 
 	ret = gpmc_cs_program_settings(gpmc_onenand_data->cs, &onenand_async);
@@ -310,6 +312,8 @@ static int omap2_onenand_setup_sync(void __iomem *onenand_base, int *freq_ptr)
 	if (!freq) {
 		/* Very first call freq is not known */
 		freq = omap2_onenand_get_freq(gpmc_onenand_data, onenand_base);
+		if (!freq)
+			return -ENODEV;
 		set_onenand_cfg(onenand_base);
 	}
