From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc3-git 1/2] regulator: twl4030 regulators
Date: Mon, 23 Feb 2009 23:25:10 -0800
Message-ID: <200902232325.10447.david-b@pacbell.net>
References: <200902081037.06645.david-b@pacbell.net> <20090224005536.GC3601@sirena.org.uk> <200902231822.27422.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:45950 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751852AbZBXHZO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Feb 2009 02:25:14 -0500
In-Reply-To: <200902231822.27422.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>, Pierre Ossman <drzeus-mmc@drzeus.cx>

On Monday 23 February 2009, David Brownell wrote:
> > There's also fun and games to be had with accuracy once you=20
> > start looking too closely at the discrete voltages.
>=20
> Yes; the patch I sent is explicitly making those available.
>=20
> But I ignored issues like "+/- 3% accurate output" for LDOs
> (or switchers) ... if anyone really needs to address them,
> patches will be needed. =A0For now I only care that a 3.1 Volt
> output can match both MMC_VDD_30_31 and MMC_VDD_31_32! ;)

And -- for kicks -- here's one notion of what it might look
like to have the MMC stack support the regulator framework.

- Dave


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Prototype glue between MMC and regulator stacks ... compiles,
and mmc_regulator_get_ocrmask() passed sanity testing.

NOTES:

 - The MMC core does't call mmc_regulator_set_ocr() because hosts
   may need to do that in conjunction with updating I/O voltage.

   Case in point, MMC1 on omap_hsmmc ... where the host driver
   must update MMC1_HCTL.SDVS and PBIAS registers in addition to
   the regulator, supporting 1.8V or 3.0V voltage ranges.  (MMC2
   and MMC3 use external level shifting for Vdd !=3D 1.8V.)

   Likewise, using eMMC "managed NAND" solutions, powerup includes
   not both Vcc ("vdd" to Linux, e.g. 3.0V) and an I/O interface
   rail VccQ (e.g. 1.8V).  The JEDEC spec for eMMC requires VccQ
   powerup after Vcc, and powerdown before it.

 - The "vdd" supply name isn't fixed, since platforms may need
   to use more than one I/O supply.

   Case in point, MMC1 on omap_hsmmc (again) ... where a second
   supply is needed to kick in 8-bit I/O using DAT4..DAT7 signals.
   That would not be handled quite like VccQ, since it's only
   used for 8-bit I/O widths (MMCplus cards, some eMMC, etc).
=20
---
 drivers/mmc/core/Kconfig |    8 +++
 drivers/mmc/core/core.c  |   98 ++++++++++++++++++++++++++++++++++++++=
+++++++
 include/linux/mmc/host.h |    3 +
 3 files changed, 109 insertions(+)

--- a/drivers/mmc/core/Kconfig
+++ b/drivers/mmc/core/Kconfig
@@ -14,3 +14,11 @@ config MMC_UNSAFE_RESUME
 	  This option is usually just for embedded systems which use
 	  a MMC/SD card for rootfs. Most people should say N here.
=20
+config MMC_REGULATOR
+	bool
+	depends on REGULATOR
+	default y
+	help
+	  Select this to provide some helper utilities to access the
+	  "vdd" (card) voltage supply associated with an MMC/SD slot.
+
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -21,6 +21,7 @@
 #include <linux/leds.h>
 #include <linux/scatterlist.h>
 #include <linux/log2.h>
+#include <linux/regulator/consumer.h>
=20
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -523,6 +524,103 @@ u32 mmc_vddrange_to_ocrmask(int vdd_min,
 }
 EXPORT_SYMBOL(mmc_vddrange_to_ocrmask);
=20
+#ifdef CONFIG_MMC_REGULATOR
+
+/**
+ * mmc_regulator_get_ocrmask - return mask of supported voltages
+ * @host: mmc host whose supply will be consulted
+ * @supply: supply voltage to use; "vdd" if NULL
+ *
+ * This returns either a negative errno, or a mask of voltages
+ * that can be provided to MMC/SD/SDIO devices using the specified
+ * host's "vdd" supply.
+ */
+int mmc_regulator_get_ocrmask(struct mmc_host *host, const char *suppl=
y)
+{
+	int			result =3D 0;
+	struct regulator	*reg;
+	int			count;
+	int			i;
+
+	reg =3D regulator_get(host->parent, supply ? : "vdd");
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+
+	count =3D regulator_count_voltages(reg);
+	if (count < 0) {
+		result =3D count;
+		goto done;
+	}
+
+	for (i =3D 0; i < count; i++) {
+		int		vdd_uV;
+		int		vdd_mV;
+
+		vdd_uV =3D regulator_list_voltage(reg, i);
+		if (vdd_uV <=3D 0)
+			continue;
+
+		vdd_mV =3D vdd_uV / 1000;
+		result |=3D mmc_vddrange_to_ocrmask(vdd_mV, vdd_mV);
+	}
+
+done:
+	regulator_put(reg);
+	return result;
+}
+EXPORT_SYMBOL(mmc_regulator_get_ocrmask);
+
+/**
+ * mmc_regulator_set_ocr - set regulator to match host->ios voltage
+ * @host: mmc host whose supply voltage will be changed
+ * @supply: supply voltage to use; "vdd" if NULL
+ *
+ * MMC host drivers may use this to enable or disable a regulator
+ * using a particular supply voltage.  This would normally be
+ * called from the set_ios() method, possibly as part of updating
+ * digital interfaces to support that voltage.
+ */
+int mmc_regulator_set_ocr(struct mmc_host *host, const char *supply)
+{
+	int			result =3D 0;
+	struct regulator	*reg;
+	int			min_mV, max_mV;
+	int			enabled;
+
+	reg =3D regulator_get(host->parent, supply ? : "vdd");
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+	enabled =3D regulator_is_enabled(reg);
+	if (WARN(enabled < 0, "%s: regulator_is_enabled --> %d\n",
+			mmc_hostname(host), enabled))
+		enabled =3D !host->ios.vdd;
+
+	if (host->ios.vdd) {
+		int		tmp;
+
+		tmp =3D host->ios.vdd - ilog2(MMC_VDD_165_195);
+		if (tmp =3D=3D 0) {
+			min_mV =3D 1650;
+			max_mV =3D 1950;
+		} else {
+			min_mV =3D 2000 + tmp * 100;
+			max_mV =3D min_mV + 100;
+		}
+
+		result =3D regulator_set_voltage(reg, min_mV * 1000, max_mV * 1000);
+		if (result =3D=3D 0 && !enabled)
+			result =3D regulator_enable(reg);
+	} else if (enabled) {
+		result =3D regulator_disable(reg);
+	}
+
+	regulator_put(reg);
+	return result;
+}
+EXPORT_SYMBOL(mmc_regulator_set_ocr);
+
+#endif
+
 /*
  * Mask off any voltages we don't support and select
  * the lowest voltage
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -192,5 +192,8 @@ static inline void mmc_signal_sdio_irq(s
 	wake_up_process(host->sdio_irq_thread);
 }
=20
+int mmc_regulator_get_ocrmask(struct mmc_host *host, const char *suppl=
y);
+int mmc_regulator_set_ocr(struct mmc_host *host, const char *supply);
+
 #endif
=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
