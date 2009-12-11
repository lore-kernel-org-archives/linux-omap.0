From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 03/10 V4] omap3: pm: use opp accessor functions for
 omap34xx
Date: Fri, 11 Dec 2009 12:29:21 +0200
Message-ID: <20091211102921.GD8299@esdhcp037198.research.nokia.com>
References: <1260339435-20294-1-git-send-email-nm@ti.com>
 <1260339435-20294-2-git-send-email-nm@ti.com>
 <1260339435-20294-3-git-send-email-nm@ti.com>
 <1260339435-20294-4-git-send-email-nm@ti.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:45244 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757501AbZLKKaF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 05:30:05 -0500
Content-Disposition: inline
In-Reply-To: <1260339435-20294-4-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>, Benoit Cousson <b-cousson@ti.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, Romit Dasgupta <romit@ti.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>, Thara Gopinath <thara@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

Hello Nishanth,

You might have missed last tero's comment. But I'm adding those again here.

On Wed, Dec 09, 2009 at 07:17:08AM +0100, ext Nishanth Menon wrote:
> Move the definitions from omap3-opp.h to pm34xx.c. The definitions
> are now based on omap_opp_def instead of omap_opp itself.
> Since the opp.h has the omap_opp definition, omap-pm.h conflicts and
> has been removed in favor of opp.h.
> 
> omap3_pm_init_opp_table is used to initialize the OPP table and
> relevant board files which have omap2_init_common_hw called with opp
> arrays have been updated with omap3_pm_init_opp_table.
> 
> This change now allows us to dynamically register OPPs to the system
> based on silicon type we detect.
> 
> NOTE: This introduces the following warnings highlighting areas we
> need to cleanup:
> arch/arm/mach-omap2/smartreflex.c: In function 'get_opp':
> arch/arm/mach-omap2/smartreflex.c:161: warning: 'opp_id' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:33)
> arch/arm/mach-omap2/smartreflex.c:164: warning: 'opp_id' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:33)
> arch/arm/mach-omap2/smartreflex.c:166: warning: 'opp_id' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:33)
> arch/arm/mach-omap2/smartreflex.c:168: warning: 'opp_id' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:33)
> arch/arm/mach-omap2/resource34xx.c: In function 'get_opp':
> arch/arm/mach-omap2/resource34xx.c:165: warning: 'opp_id' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:33)
> arch/arm/mach-omap2/resource34xx.c:168: warning: 'opp_id' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:33)
> arch/arm/mach-omap2/resource34xx.c:170: warning: 'opp_id' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:33)
> arch/arm/mach-omap2/resource34xx.c:172: warning: 'opp_id' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:33)
> arch/arm/mach-omap2/resource34xx.c: In function 'program_opp':
> arch/arm/mach-omap2/resource34xx.c:284: warning: 'opp_id' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:33)
> arch/arm/mach-omap2/resource34xx.c:285: warning: 'opp_id' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:33)
> 
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Romit Dasgupta <romit@ti.com>
> Cc: Sanjeev Premi <premi@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>
> Cc: Tero Kristo <Tero.Kristo@nokia.com>
> Cc: Thara Gopinath <thara@ti.com>
> Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/mach-omap2/board-3430sdp.c       |    1 +
>  arch/arm/mach-omap2/board-omap3beagle.c   |    1 +
>  arch/arm/mach-omap2/board-omap3evm.c      |    1 +
>  arch/arm/mach-omap2/board-rx51.c          |    1 +
>  arch/arm/mach-omap2/board-zoom2.c         |    2 +
>  arch/arm/mach-omap2/omap3-opp.h           |   58 +------------------------
>  arch/arm/mach-omap2/pm.h                  |    6 +++
>  arch/arm/mach-omap2/pm34xx.c              |   65 +++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/omap-pm.h |   17 +-------
>  9 files changed, 81 insertions(+), 71 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
> index eac529f..0ec8327 100644
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -220,6 +220,7 @@ static void __init omap_3430sdp_init_irq(void)
>  {
>         omap_board_config = sdp3430_config;
>         omap_board_config_size = ARRAY_SIZE(sdp3430_config);
> +       omap3_pm_init_opp_table();
>         omap3_pm_init_vc(&omap3_setuptime_table);
>         omap3_pm_init_cpuidle(omap3_cpuidle_params_table);
>         omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL, omap3_mpu_rate_table,
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index 2ec3520..a937238 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -361,6 +361,7 @@ static void __init omap3_beagle_init_irq(void)
>  {
>         omap_board_config = omap3_beagle_config;
>         omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
> +       omap3_pm_init_opp_table();
>         omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
>                              mt46h32m32lf6_sdrc_params, omap3_mpu_rate_table,
>                              omap3_dsp_rate_table, omap3_l3_rate_table);
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> index 8130eca..44a5861 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -404,6 +404,7 @@ static void __init omap3_evm_init_irq(void)
>  {
>         omap_board_config = omap3_evm_config;
>         omap_board_config_size = ARRAY_SIZE(omap3_evm_config);
> +       omap3_pm_init_opp_table();
>         omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL, omap3_mpu_rate_table,
>                              omap3_dsp_rate_table, omap3_l3_rate_table);
>         omap_init_irq();
> diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
> index 2f1c2be..997fd1c 100644
> --- a/arch/arm/mach-omap2/board-rx51.c
> +++ b/arch/arm/mach-omap2/board-rx51.c
> @@ -103,6 +103,7 @@ static void __init rx51_init_irq(void)
> 
>         omap_board_config = rx51_config;
>         omap_board_config_size = ARRAY_SIZE(rx51_config);
> +       omap3_pm_init_opp_table();
>         omap3_pm_init_cpuidle(rx51_cpuidle_params);
>         sdrc_params = rx51_get_sdram_timings();
>         omap2_init_common_hw(sdrc_params, sdrc_params,


Add the following in order to do not break compilation:
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 527f0c6..1f24933 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -31,6 +31,7 @@
 #include <plat/gpmc.h>
 #include <plat/usb.h>
 
+#include "pm.h"
 #include "omap3-opp.h"
 
 #define RX51_GPIO_SLEEP_IND 162


> diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
> index dcc5fb8..9d5b078 100644
> --- a/arch/arm/mach-omap2/board-zoom2.c
> +++ b/arch/arm/mach-omap2/board-zoom2.c
> @@ -24,10 +24,12 @@
>  #include <mach/board-zoom.h>
> 
>  #include "sdram-micron-mt46h32m32lf-6.h"
> +#include "pm.h"
>  #include "omap3-opp.h"
> 
>  static void __init omap_zoom2_init_irq(void)
>  {
> +       omap3_pm_init_opp_table();
>         omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
>                                  mt46h32m32lf6_sdrc_params, omap3_mpu_rate_table,
>                                  omap3_dsp_rate_table, omap3_l3_rate_table);
> diff --git a/arch/arm/mach-omap2/omap3-opp.h b/arch/arm/mach-omap2/omap3-opp.h
> index 42557e1..994d8d4 100644
> --- a/arch/arm/mach-omap2/omap3-opp.h
> +++ b/arch/arm/mach-omap2/omap3-opp.h
> @@ -3,60 +3,8 @@
> 
>  #include <plat/omap-pm.h>
> 
> -/* MPU speeds */
> -#define S600M   600000000
> -#define S550M   550000000
> -#define S500M   500000000
> -#define S250M   250000000
> -#define S125M   125000000
> -
> -/* DSP speeds */
> -#define S430M   430000000
> -#define S400M   400000000
> -#define S360M   360000000
> -#define S180M   180000000
> -#define S90M    90000000
> -
> -/* L3 speeds */
> -#define S83M    83000000
> -#define S166M   166000000
> -
> -static struct omap_opp omap3_mpu_rate_table[] = {
> -       {0, 0, 0, 0},
> -       /*OPP1*/
> -       {true, S125M, VDD1_OPP1, 0x1E},
> -       /*OPP2*/
> -       {true, S250M, VDD1_OPP2, 0x26},
> -       /*OPP3*/
> -       {true, S500M, VDD1_OPP3, 0x30},
> -       /*OPP4*/
> -       {true, S550M, VDD1_OPP4, 0x36},
> -       /*OPP5*/
> -       {true, S600M, VDD1_OPP5, 0x3C},
> -};
> -
> -static struct omap_opp omap3_l3_rate_table[] = {
> -       {0, 0, 0, 0},
> -       /*OPP1*/
> -       {false, 0, VDD2_OPP1, 0x1E},
> -       /*OPP2*/
> -       {true, S83M, VDD2_OPP2, 0x24},
> -       /*OPP3*/
> -       {true, S166M, VDD2_OPP3, 0x2C},
> -};
> -
> -static struct omap_opp omap3_dsp_rate_table[] = {
> -       {0, 0, 0, 0},
> -       /*OPP1*/
> -       {true, S90M, VDD1_OPP1, 0x1E},
> -       /*OPP2*/
> -       {true, S180M, VDD1_OPP2, 0x26},
> -       /*OPP3*/
> -       {true, S360M, VDD1_OPP3, 0x30},
> -       /*OPP4*/
> -       {true, S400M, VDD1_OPP4, 0x36},
> -       /*OPP5*/
> -       {true, S430M, VDD1_OPP5, 0x3C},
> -};
> +extern struct omap_opp *omap3_mpu_rate_table;
> +extern struct omap_opp *omap3_dsp_rate_table;
> +extern struct omap_opp *omap3_l3_rate_table;
> 
>  #endif
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 7bc86b6..80a1c1d 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -58,6 +58,12 @@ static inline void omap3_pm_init_cpuidle(
>  {
>  }
>  #endif
> +/**
> + * omap3_pm_init_opp_table - OMAP opp table lookup called after cpu is detected.
> + * Initialize the basic opp table here, board files could choose to modify opp
> + * table after the basic initialization
> + */
> +extern void omap3_pm_init_opp_table(void);
> 
>  extern int resource_set_opp_level(int res, u32 target_level, int flags);
>  extern int resource_access_opp_lock(int res, int delta);
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 627a509..e40a036 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -40,6 +40,7 @@
>  #include <plat/dmtimer.h>
>  #include <plat/usb.h>
> 
> +#include <plat/opp.h>
>  #include <plat/resource.h>
> 
>  #include <asm/tlbflush.h>
> @@ -52,6 +53,7 @@
>  #include "prm.h"
>  #include "pm.h"
>  #include "sdrc.h"
> +#include "omap3-opp.h"
> 
>  static int regset_save_on_suspend;
> 
> @@ -100,6 +102,49 @@ static struct prm_setup_vc prm_setup = {
>         .vdd1_off = 0x00,       /* 0.6v */
>  };
> 
> +static struct omap_opp_def __initdata omap34xx_mpu_rate_table[] = {
> +       /* OPP1 */
> +       OMAP_OPP_DEF(true, 125000000, 975000),
> +       /* OPP2 */
> +       OMAP_OPP_DEF(true, 250000000, 1075000),
> +       /* OPP3 */
> +       OMAP_OPP_DEF(true, 500000000, 1200000),
> +       /* OPP4 */
> +       OMAP_OPP_DEF(true, 550000000, 1270000),
> +       /* OPP5 */
> +       OMAP_OPP_DEF(true, 600000000, 1350000),
> +       OMAP_OPP_DEF_TERMINATOR
> +};
> +
> +static struct omap_opp_def __initdata omap34xx_l3_rate_table[] = {
> +       /* OPP1 */
> +       OMAP_OPP_DEF(false, 0, 975000),
> +       /* OPP2 */
> +       OMAP_OPP_DEF(true, 83000000, 1050000),
> +       /* OPP3 */
> +       OMAP_OPP_DEF(true, 166000000, 1150000),
> +       OMAP_OPP_DEF_TERMINATOR
> +};
> +
> +static struct omap_opp_def __initdata omap34xx_dsp_rate_table[] = {
> +       /* OPP1 */
> +       OMAP_OPP_DEF(true, 90000000, 975000),
> +       /* OPP2 */
> +       OMAP_OPP_DEF(true, 180000000, 1075000),
> +       /* OPP3 */
> +       OMAP_OPP_DEF(true, 360000000, 1200000),
> +       /* OPP4 */
> +       OMAP_OPP_DEF(true, 400000000, 1270000),
> +       /* OPP5 */
> +       OMAP_OPP_DEF(true, 430000000, 1350000),
> +       OMAP_OPP_DEF_TERMINATOR
> +};
> +
> +/* OMAP3 Rate Table */
> +struct omap_opp *omap3_mpu_rate_table;
> +struct omap_opp *omap3_dsp_rate_table;
> +struct omap_opp *omap3_l3_rate_table;
> +
>  static inline void omap3_per_save_context(void)
>  {
>         omap_gpio_save_context();
> @@ -1248,6 +1293,26 @@ static void __init configure_vc(void)
>         pm_dbg_regset_init(2);
>  }
> 
> +void __init omap3_pm_init_opp_table(void)
> +{
> +       int i;
> +       struct omap_opp_def *omap34xx_opp_def_list[] = {
> +               omap34xx_mpu_rate_table,
> +               omap34xx_l3_rate_table,
> +               omap34xx_dsp_rate_table
> +       };
> +       struct omap_opp **omap3_rate_tables[] = {
> +               &omap3_mpu_rate_table,
> +               &omap3_l3_rate_table,
> +               &omap3_dsp_rate_table
> +       };
> +       for (i = 0; i < ARRAY_SIZE(omap3_rate_tables); i++) {
> +               *omap3_rate_tables[i] = opp_init_list(omap34xx_opp_def_list[i]);
> +               /* We dont want half configured system at the moment */
> +               BUG_ON(IS_ERR(omap3_rate_tables[i]));
> +       }
> +}
> +
>  static int __init omap3_pm_early_init(void)
>  {
>         prm_clear_mod_reg_bits(OMAP3430_OFFMODE_POL, OMAP3430_GR_MOD,
> diff --git a/arch/arm/plat-omap/include/plat/omap-pm.h b/arch/arm/plat-omap/include/plat/omap-pm.h
> index 5dc2048..aa36339 100644
> --- a/arch/arm/plat-omap/include/plat/omap-pm.h
> +++ b/arch/arm/plat-omap/include/plat/omap-pm.h
> @@ -18,22 +18,7 @@
>  #include <linux/cpufreq.h>
> 
>  #include "powerdomain.h"
> -
> -/**
> - * struct omap_opp - clock frequency-to-OPP ID table for DSP, MPU
> - * @enabled: enabled if true, disabled if false
> - * @rate: target clock rate
> - * @opp_id: OPP ID
> - * @min_vdd: minimum VDD1 voltage (in millivolts) for this OPP
> - *
> - * Operating performance point data.  Can vary by OMAP chip and board.
> - */
> -struct omap_opp {
> -       bool enabled;
> -       unsigned long rate;
> -       u8 opp_id;
> -       u16 vsel;
> -};
> +#include <plat/opp.h>
> 
>  extern struct omap_opp *mpu_opps;
>  extern struct omap_opp *dsp_opps;
> --
> 1.6.3.3

-- 
Eduardo Valentin
