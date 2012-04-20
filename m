From: "Datta, Shubhrajyoti" <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv8 04/18] I2C: OMAP: I2C register restore only if context
 is lost
Date: Fri, 20 Apr 2012 19:47:44 +0530
Message-ID: <CANQgH-Y9hNgHsuD6s+DHDC7ff+V1efawXvfceyC_q+N92w1PVw@mail.gmail.com>
References: <1334235995-6727-1-git-send-email-shubhrajyoti@ti.com>
	<1334235995-6727-5-git-send-email-shubhrajyoti@ti.com>
	<87d376zd2v.fsf@ti.com>
	<CAM=Q2cvGFgNtvCX=TXAioAUKH9z+VzeKW2ZHhpxUC+s2_yS1QA@mail.gmail.com>
	<CANQgH-aUyx97rDUUTy8L1qHSSgdC2YaP7LaQor4RAGPfb2JX=g@mail.gmail.com>
	<87wr5dnndj.fsf@ti.com>
	<CANQgH-af1VCutKqpq8jK1yTPHybgvnUNA3zdfQq4AYcWcJRtvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CANQgH-af1VCutKqpq8jK1yTPHybgvnUNA3zdfQq4AYcWcJRtvA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Apr 20, 2012 at 7:43 PM, Datta, Shubhrajyoti
<shubhrajyoti-l0cyMroinI0@public.gmane.org> wrote:
>
>
>
> On Wed, Apr 18, 2012 at 7:38 PM, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org> wrote:
>>
>> "
>
>
>> > =A0#define OMAP_I2C_SYSTEST_SDA_O =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 <=
< 0) =A0 =A0 =A0 =A0/* SDA
>> > line drive out */
>> >
>> > -/* OCP_SYSSTATUS bit definitions */
>> > -#define SYSS_RESETDONE_MASK =A0 =A0 =A0 =A0 =A0(1 << 0)
>> > -
>>
>> Unrelated to this patch.
>
>
Actually if this is not removed we get a warn as the header file gets
added when I add omap_device.h and the compiler sees a redefinition. Ho=
wever
I agree that it can be a seperate patch.

 Here is the updated patch with your comments.
 Thanks.
=46rom c5efbe2bb050c113a1cb1b959a8890578ba9b237 Mon Sep 17 00:00:00 200=
1
=46rom: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Date: Fri, 20 Apr 2012 11:15:28 +0530
Subject: [PATCH] I2C: OMAP: I2C register restore only if context is los=
t

 Currently i2c register restore is done always.
 Adding conditional restore.
 The i2c register restore is done only if the context is lost
 or in case of error to be on the safe side.

Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 arch/arm/plat-omap/i2c.c      |    3 +++
 drivers/i2c/busses/i2c-omap.c |   35 ++++++++++++++++++++++++++-------=
--
 include/linux/i2c-omap.h      |    1 +
 3 files changed, 30 insertions(+), 9 deletions(-)

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
index f5094b1..d95b01b 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -43,6 +43,7 @@
 #include <linux/slab.h>
 #include <linux/i2c-omap.h>
 #include <linux/pm_runtime.h>
+#include <plat/omap_device.h>

 /* I2C controller revisions */
 #define OMAP_I2C_OMAP1_REV_2		0x20
@@ -185,6 +186,7 @@ struct omap_i2c_dev {
 	u32			latency;	/* maximum mpu wkup latency */
 	void			(*set_mpu_wkup_lat)(struct device *dev,
 						    long latency);
+	int			(*get_context_loss_count)(struct device *dev);
 	u32			speed;		/* Speed of bus in kHz */
 	u32			dtrev;		/* extra revision from DT */
 	u32			flags;
@@ -207,6 +209,7 @@ struct omap_i2c_dev {
 	u16			syscstate;
 	u16			westate;
 	u16			errata;
+	int			dev_lost_count;
 };

 static const u8 reg_map_ip_v1[] =3D {
@@ -989,6 +992,7 @@ omap_i2c_probe(struct platform_device *pdev)
 		dev->speed =3D pdata->clkrate;
 		dev->flags =3D pdata->flags;
 		dev->set_mpu_wkup_lat =3D pdata->set_mpu_wkup_lat;
+		dev->get_context_loss_count =3D pdata->get_context_loss_count;
 		dev->dtrev =3D pdata->rev;
 	}

@@ -1133,12 +1137,26 @@ omap_i2c_remove(struct platform_device *pdev)
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

 	omap_i2c_write_reg(_dev, OMAP_I2C_IE_REG, 0);
@@ -1159,16 +1177,15 @@ static int omap_i2c_runtime_resume(struct devic=
e *dev)
 {
 	struct platform_device *pdev =3D to_platform_device(dev);
 	struct omap_i2c_dev *_dev =3D platform_get_drvdata(pdev);
+	int loss_cnt;
+
+	if (!(_dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE))
+		return 0;

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
+		if (_dev->dev_lost_count !=3D loss_cnt)
+			omap_i2c_restore(_dev);
 	}

 	/*
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
