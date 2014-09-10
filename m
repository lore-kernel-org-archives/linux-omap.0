From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/3] ARM: OMAP2+: make of_device_ids const
Date: Wed, 10 Sep 2014 10:26:17 +0200
Message-ID: <1410337579-23466-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1410337579-23466-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40842 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbaIJI1J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2014 04:27:09 -0400
In-Reply-To: <1410337579-23466-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Rajendra Nayak <rnayak@ti.com>
Cc: devicetree@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de, linux-omap@vger.kernel.org

of_device_ids (i.e. compatible strings and the respective data) are not
supposed to change at runtime. All functions working with of_device_ids
provided by <linux/of.h> work with const of_device_ids. So mark the
non-const function parameters and structs for OMAP2+ as const, too.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-omap2/board-generic.c | 2 +-
 arch/arm/mach-omap2/common.h        | 2 +-
 arch/arm/mach-omap2/gpmc.c          | 2 +-
 arch/arm/mach-omap2/irq.c           | 2 +-
 arch/arm/mach-omap2/pdata-quirks.c  | 2 +-
 arch/arm/mach-omap2/prm_common.c    | 2 +-
 arch/arm/mach-omap2/timer.c         | 6 +++---
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/=
board-generic.c
index 9480997ba616..5827abb080e4 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -27,7 +27,7 @@
 #define gic_of_init		NULL
 #endif
=20
-static struct of_device_id omap_dt_match_table[] __initdata =3D {
+static const struct of_device_id omap_dt_match_table[] __initconst =3D=
 {
 	{ .compatible =3D "simple-bus", },
 	{ .compatible =3D "ti,omap-infra", },
 	{ }
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.=
h
index dc571f1d3b8a..79664411e794 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -307,7 +307,7 @@ static inline void omap4_cpu_resume(void)
=20
 #endif
=20
-void pdata_quirks_init(struct of_device_id *);
+void pdata_quirks_init(const struct of_device_id *);
 void omap_auxdata_legacy_init(struct device *dev);
 void omap_pcs_legacy_init(int irq, void (*rearm)(void));
=20
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 2f97228f188a..a4d52c42a438 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1243,7 +1243,7 @@ int gpmc_cs_program_settings(int cs, struct gpmc_=
settings *p)
 }
=20
 #ifdef CONFIG_OF
-static struct of_device_id gpmc_dt_ids[] =3D {
+static const struct of_device_id gpmc_dt_ids[] =3D {
 	{ .compatible =3D "ti,omap2420-gpmc" },
 	{ .compatible =3D "ti,omap2430-gpmc" },
 	{ .compatible =3D "ti,omap3430-gpmc" },	/* omap3430 & omap3630 */
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 35b8590c322e..604a976abf14 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -289,7 +289,7 @@ int __init intc_of_init(struct device_node *node,
 	return 0;
 }
=20
-static struct of_device_id irq_match[] __initdata =3D {
+static const struct of_device_id irq_match[] __initconst =3D {
 	{ .compatible =3D "ti,omap2-intc", .data =3D intc_of_init, },
 	{ }
 };
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/p=
data-quirks.c
index 90c88d498485..05a8c8b07449 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -405,7 +405,7 @@ static void pdata_quirks_check(struct pdata_init *q=
uirks)
 	}
 }
=20
-void __init pdata_quirks_init(struct of_device_id *omap_dt_match_table=
)
+void __init pdata_quirks_init(const struct of_device_id *omap_dt_match=
_table)
 {
 	omap_sdrc_init(NULL, NULL);
 	pdata_quirks_check(auxdata_quirks);
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm=
_common.c
index 76ca320f007c..74054b813600 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -467,7 +467,7 @@ int prm_unregister(struct prm_ll_data *pld)
 	return 0;
 }
=20
-static struct of_device_id omap_prcm_dt_match_table[] =3D {
+static const struct of_device_id omap_prcm_dt_match_table[] =3D {
 	{ .compatible =3D "ti,am3-prcm" },
 	{ .compatible =3D "ti,am3-scrm" },
 	{ .compatible =3D "ti,am4-prcm" },
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 43d03fbf4c0b..4f61148ec168 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -141,7 +141,7 @@ static struct property device_disabled =3D {
 	.value =3D "disabled",
 };
=20
-static struct of_device_id omap_timer_match[] __initdata =3D {
+static const struct of_device_id omap_timer_match[] __initconst =3D {
 	{ .compatible =3D "ti,omap2420-timer", },
 	{ .compatible =3D "ti,omap3430-timer", },
 	{ .compatible =3D "ti,omap4430-timer", },
@@ -162,7 +162,7 @@ static struct of_device_id omap_timer_match[] __ini=
tdata =3D {
  * the timer node in device-tree as disabled, to prevent the kernel fr=
om
  * registering this timer as a platform device and so no one else can =
use it.
  */
-static struct device_node * __init omap_get_timer_dt(struct of_device_=
id *match,
+static struct device_node * __init omap_get_timer_dt(const struct of_d=
evice_id *match,
 						     const char *property)
 {
 	struct device_node *np;
@@ -388,7 +388,7 @@ static u64 notrace dmtimer_read_sched_clock(void)
 	return 0;
 }
=20
-static struct of_device_id omap_counter_match[] __initdata =3D {
+static const struct of_device_id omap_counter_match[] __initconst =3D =
{
 	{ .compatible =3D "ti,omap-counter32k", },
 	{ }
 };
--=20
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
