From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Subject: Re: [PATCHv8 04/18] I2C: OMAP: I2C register restore only if context
 is lost
Date: Wed, 18 Apr 2012 12:49:27 +0530
Message-ID: <CANQgH-aUyx97rDUUTy8L1qHSSgdC2YaP7LaQor4RAGPfb2JX=g@mail.gmail.com>
References: <1334235995-6727-1-git-send-email-shubhrajyoti@ti.com>
	<1334235995-6727-5-git-send-email-shubhrajyoti@ti.com>
	<87d376zd2v.fsf@ti.com>
	<CAM=Q2cvGFgNtvCX=TXAioAUKH9z+VzeKW2ZHhpxUC+s2_yS1QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:47363 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750769Ab2DRHT3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Apr 2012 03:19:29 -0400
Received: by qafi31 with SMTP id i31so374165qaf.1
        for <linux-omap@vger.kernel.org>; Wed, 18 Apr 2012 00:19:28 -0700 (PDT)
In-Reply-To: <CAM=Q2cvGFgNtvCX=TXAioAUKH9z+VzeKW2ZHhpxUC+s2_yS1QA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de

Hi Kevin,

> Hi Kevin,
> Thanks for your review,
>
> On Tue, Apr 17, 2012 at 7:15 PM, Kevin Hilman <khilman@ti.com> wrote:
>> Shubhrajyoti D <shubhrajyoti@ti.com> writes:
>>
>>> =A0Currently i2c register restore is done always.
>>> =A0Adding conditional restore.
>>> =A0The i2c register restore is done only if the context is lost.
>>
>> OK, minor comment below.

Thanks for the suggestion of the error case restore.
Updated the patch. Also added Tony's ack for the plat part.


=46rom 1ca222f6f50868e07d9a46575e73dd66fd2d542e Mon Sep 17 00:00:00 200=
1
=46rom: Shubhrajyoti D <shubhrajyoti@ti.com>
Date: Tue, 17 Jan 2012 16:13:03 +0530
Subject: [PATCH] I2C: OMAP: I2C register restore only if context is los=
t

 Currently i2c register restore is done always.
 Adding conditional restore.
 The i2c register restore is done only if the context is lost
 or in case of error to be on the safe side.
 Also remove the definition of SYSS_RESETDONE_MASK and use the
 one in omap_hwmod.h.

Cc: Kevin Hilman <khilman@ti.com>
[For the arch/arm/plat-omap/i2c.c part]
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 arch/arm/plat-omap/i2c.c      |    3 ++
 drivers/i2c/busses/i2c-omap.c |   53 +++++++++++++++++++++++++++------=
--------
 include/linux/i2c-omap.h      |    1 +
 3 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index db071bc..4ccab07 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -179,6 +179,9 @@ static inline int omap2_i2c_add_bus(int bus_id)
 	 */
 	if (cpu_is_omap34xx())
 		pdata->set_mpu_wkup_lat =3D omap_pm_set_max_mpu_wakeup_lat_compat;
+
+	pdata->get_context_loss_count =3D omap_pm_get_dev_context_loss_count;
+
 	pdev =3D omap_device_build(name, bus_id, oh, pdata,
 			sizeof(struct omap_i2c_bus_platform_data),
 			NULL, 0, 0);
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-oma=
p.c
index a882558..76cf066 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -43,6 +43,7 @@
 #include <linux/slab.h>
 #include <linux/i2c-omap.h>
 #include <linux/pm_runtime.h>
+#include <plat/omap_device.h>

 /* I2C controller revisions */
 #define OMAP_I2C_OMAP1_REV_2		0x20
@@ -157,9 +158,6 @@ enum {
 #define OMAP_I2C_SYSTEST_SDA_I		(1 << 1)	/* SDA line sense in */
 #define OMAP_I2C_SYSTEST_SDA_O		(1 << 0)	/* SDA line drive out */

-/* OCP_SYSSTATUS bit definitions */
-#define SYSS_RESETDONE_MASK		(1 << 0)
-
 /* OCP_SYSCONFIG bit definitions */
 #define SYSC_CLOCKACTIVITY_MASK		(0x3 << 8)
 #define SYSC_SIDLEMODE_MASK		(0x3 << 3)
@@ -184,6 +182,7 @@ struct omap_i2c_dev {
 	u32			latency;	/* maximum mpu wkup latency */
 	void			(*set_mpu_wkup_lat)(struct device *dev,
 						    long latency);
+	int			(*get_context_loss_count)(struct device *dev);
 	u32			speed;		/* Speed of bus in kHz */
 	u32			dtrev;		/* extra revision from DT */
 	u32			flags;
@@ -206,6 +205,7 @@ struct omap_i2c_dev {
 	u16			syscstate;
 	u16			westate;
 	u16			errata;
+	int			dev_lost_count;
 };

 static const u8 reg_map_ip_v1[] =3D {
@@ -1025,6 +1025,7 @@ omap_i2c_probe(struct platform_device *pdev)
 		dev->speed =3D pdata->clkrate;
 		dev->flags =3D pdata->flags;
 		dev->set_mpu_wkup_lat =3D pdata->set_mpu_wkup_lat;
+		dev->get_context_loss_count =3D pdata->get_context_loss_count;
 		dev->dtrev =3D pdata->rev;
 	}

@@ -1151,12 +1152,32 @@ omap_i2c_remove(struct platform_device *pdev)
 }

 #ifdef CONFIG_PM_RUNTIME
+static void omap_i2c_restore(struct omap_i2c_dev *dev)
+{
+	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
+	omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, dev->pscstate);
+	omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, dev->scllstate);
+	omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->sclhstate);
+	omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, dev->bufstate);
+	omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
+	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
+	/*
+	 * Don't write to this register if the IE state is 0 as it can
+	 * cause deadlock.
+	 */
+	if (dev->iestate)
+		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
+
+}
 static int omap_i2c_runtime_suspend(struct device *dev)
 {
 	struct platform_device *pdev =3D to_platform_device(dev);
 	struct omap_i2c_dev *_dev =3D platform_get_drvdata(pdev);
 	u16 iv;

+	if (_dev->get_context_loss_count)
+		_dev->dev_lost_count =3D _dev->get_context_loss_count(dev);
+
 	_dev->iestate =3D omap_i2c_read_reg(_dev, OMAP_I2C_IE_REG);
 	if (_dev->dtrev =3D=3D OMAP_I2C_IP_VERSION_2)
 		omap_i2c_write_reg(_dev, OMAP_I2C_IP_V2_IRQENABLE_CLR, 1);
@@ -1179,24 +1200,20 @@ static int omap_i2c_runtime_resume(struct devic=
e *dev)
 {
 	struct platform_device *pdev =3D to_platform_device(dev);
 	struct omap_i2c_dev *_dev =3D platform_get_drvdata(pdev);
+	int loss_cnt;

-	if (_dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
-		omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG, 0);
-		omap_i2c_write_reg(_dev, OMAP_I2C_PSC_REG, _dev->pscstate);
-		omap_i2c_write_reg(_dev, OMAP_I2C_SCLL_REG, _dev->scllstate);
-		omap_i2c_write_reg(_dev, OMAP_I2C_SCLH_REG, _dev->sclhstate);
-		omap_i2c_write_reg(_dev, OMAP_I2C_BUF_REG, _dev->bufstate);
-		omap_i2c_write_reg(_dev, OMAP_I2C_SYSC_REG, _dev->syscstate);
-		omap_i2c_write_reg(_dev, OMAP_I2C_WE_REG, _dev->westate);
-		omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
+	if (_dev->get_context_loss_count) {
+		loss_cnt =3D _dev->get_context_loss_count(dev);
+		if (loss_cnt < 0) {
+			omap_i2c_restore(_dev);
+			return 0;
+		}
+		if (_dev->dev_lost_count =3D=3D loss_cnt && _dev->dev_lost_count)
+			return 0;
 	}

-	/*
-	 * Don't write to this register if the IE state is 0 as it can
-	 * cause deadlock.
-	 */
-	if (_dev->iestate)
-		omap_i2c_write_reg(_dev, OMAP_I2C_IE_REG, _dev->iestate);
+	if (_dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE)
+		omap_i2c_restore(_dev);

 	return 0;
 }
diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
index 92a0dc7..c76cbc0 100644
--- a/include/linux/i2c-omap.h
+++ b/include/linux/i2c-omap.h
@@ -35,6 +35,7 @@ struct omap_i2c_bus_platform_data {
 	u32		rev;
 	u32		flags;
 	void		(*set_mpu_wkup_lat)(struct device *dev, long set);
+	int		(*get_context_loss_count)(struct device *dev);
 };

 #endif
--=20
1.7.5.4
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
