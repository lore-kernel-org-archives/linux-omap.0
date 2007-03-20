From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix warnings in devices.c for 2430sdp config
Date: Tue, 20 Mar 2007 14:04:56 -0400
Message-ID: <20070320180454.GE8596@atomide.com>
References: <20070320160540.GB8596@atomide.com>
	<9C23CDD79DA20A479D4615857B2E2C47833739@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5I6of5zJg18YgZEa"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47833739@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Syed Mohammed, Khasim <x0khasim@ti.com> [070320 12:42]:
> Tony,
> 
> Keypad and MMC are different from that on 2420 SDP as such. Keypad is
> based on TWL4030 Keypad controller and MMC is HSMMC controller. It might
> take some time to send a patch. 
> 
> I am actually working on the Keypad one, will post a patch soon.

OK, how about this patch instead then? It assumes that wdt and rng
are the same.

Regards,

Tony

--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch-fix-2430-warnings

ARM:OMAP: Fix compile warnings for 2430

Some 2430 devices are different and not yet done.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -157,6 +157,10 @@ static inline void omap_init_i2c(void) {}
 
 static void omap_init_kp(void)
 {
+	/* REVISIT: 2430 keypad is on TWL4030 */
+	if (cpu_is_omap2430())
+		return;
+
 	if (machine_is_omap_h2() || machine_is_omap_h3()) {
 		omap_cfg_reg(F18_1610_KBC0);
 		omap_cfg_reg(D20_1610_KBC1);
@@ -283,6 +287,10 @@ static void __init omap_init_mmc(void)
 	const struct omap_mmc_config	*mmc_conf;
 	const struct omap_mmc_conf	*mmc;
 
+	/* REVISIT: 2430 has HS MMC */
+	if (cpu_is_omap2430())
+		return;
+
 	/* NOTE:  assumes MMC was never (wrongly) enabled */
 	mmc_conf = omap_get_config(OMAP_TAG_MMC, struct omap_mmc_config);
 	if (!mmc_conf)
@@ -495,10 +503,6 @@ static inline void omap_init_rng(void) {}
  */
 static int __init omap_init_devices(void)
 {
-/*
- * Need to enable relevant once for 2430 SDP
- */
-#ifndef CONFIG_MACH_OMAP_2430SDP
 	/* please keep these calls, and their implementations above,
 	 * in alphabetical order so they're easier to sort through.
 	 */
@@ -508,7 +512,6 @@ static int __init omap_init_devices(void)
 	omap_init_uwire();
 	omap_init_wdt();
 	omap_init_rng();
-#endif
 	omap_init_i2c();
 	return 0;
 }

--5I6of5zJg18YgZEa
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--5I6of5zJg18YgZEa--
