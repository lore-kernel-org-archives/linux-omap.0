From: =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
Subject: [PATCH 6/8] ARM: etm: Add some missing locks and error checks
Date: Mon, 14 Feb 2011 22:11:14 -0800
Message-ID: <1297750276-12475-6-git-send-email-arve@android.com>
References: <1296701663-12168-1-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1296701663-12168-1-git-send-email-arve@android.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Russell King <linux@arm.linux.org.uk>, Alexander Shishkin <virtuoso@slind.org>, Jason Wessel <jason.wessel@windriver.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

It is not safe to call etm_lock or etb_lock without holding the
mutex since another thread may also have unlocked the registers.

Also add some missing checks for valid etb_regs in the etm sysfs
entries.

Signed-off-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
---
 arch/arm/kernel/etm.c |   57 +++++++++++++++++++++++++++++++++--------=
-------
 1 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/arch/arm/kernel/etm.c b/arch/arm/kernel/etm.c
index 96b1abb..8126beb 100644
--- a/arch/arm/kernel/etm.c
+++ b/arch/arm/kernel/etm.c
@@ -263,8 +263,13 @@ static void etm_dump(void)
=20
 static void sysrq_etm_dump(int key)
 {
+	if (!mutex_trylock(&tracer.mutex)) {
+		printk(KERN_INFO "Tracing hardware busy\n");
+		return;
+	}
 	dev_dbg(tracer.dev, "Dumping ETB buffer\n");
 	etm_dump();
+	mutex_unlock(&tracer.mutex);
 }
=20
 static struct sysrq_key_op sysrq_etm_op =3D {
@@ -373,6 +378,7 @@ static int __init etb_probe(struct amba_device *dev=
, struct amba_id *id)
 	if (ret)
 		goto out;
=20
+	mutex_lock(&t->mutex);
 	t->etb_regs =3D ioremap_nocache(dev->res.start, resource_size(&dev->r=
es));
 	if (!t->etb_regs) {
 		ret =3D -ENOMEM;
@@ -381,6 +387,16 @@ static int __init etb_probe(struct amba_device *de=
v, struct amba_id *id)
=20
 	amba_set_drvdata(dev, t);
=20
+	etb_unlock(t);
+	t->etb_bufsz =3D etb_readl(t, ETBR_DEPTH);
+	dev_dbg(&dev->dev, "Size: %x\n", t->etb_bufsz);
+
+	/* make sure trace capture is disabled */
+	etb_writel(t, 0, ETBR_CTRL);
+	etb_writel(t, 0x1000, ETBR_FORMATTERCTRL);
+	etb_lock(t);
+	mutex_unlock(&t->mutex);
+
 	etb_miscdev.parent =3D &dev->dev;
=20
 	ret =3D misc_register(&etb_miscdev);
@@ -394,25 +410,19 @@ static int __init etb_probe(struct amba_device *d=
ev, struct amba_id *id)
 	else
 		clk_enable(t->emu_clk);
=20
-	etb_unlock(t);
-	t->etb_bufsz =3D etb_readl(t, ETBR_DEPTH);
-	dev_dbg(&dev->dev, "Size: %x\n", t->etb_bufsz);
-
-	/* make sure trace capture is disabled */
-	etb_writel(t, 0, ETBR_CTRL);
-	etb_writel(t, 0x1000, ETBR_FORMATTERCTRL);
-	etb_lock(t);
-
 	dev_dbg(&dev->dev, "ETB AMBA driver initialized.\n");
=20
 out:
 	return ret;
=20
 out_unmap:
+	mutex_lock(&t->mutex);
 	amba_set_drvdata(dev, NULL);
 	iounmap(t->etb_regs);
+	t->etb_regs =3D NULL;
=20
 out_release:
+	mutex_unlock(&t->mutex);
 	amba_release_regions(dev);
=20
 	return ret;
@@ -474,7 +484,10 @@ static ssize_t trace_running_store(struct kobject =
*kobj,
 		return -EINVAL;
=20
 	mutex_lock(&tracer.mutex);
-	ret =3D value ? trace_start(&tracer) : trace_stop(&tracer);
+	if (!tracer.etb_regs)
+		ret =3D -ENODEV;
+	else
+		ret =3D value ? trace_start(&tracer) : trace_stop(&tracer);
 	mutex_unlock(&tracer.mutex);
=20
 	return ret ? : n;
@@ -490,18 +503,25 @@ static ssize_t trace_info_show(struct kobject *ko=
bj,
 	u32 etb_wa, etb_ra, etb_st, etb_fc, etm_ctrl, etm_st;
 	int datalen;
=20
-	etb_unlock(&tracer);
-	datalen =3D etb_getdatalen(&tracer);
-	etb_wa =3D etb_readl(&tracer, ETBR_WRITEADDR);
-	etb_ra =3D etb_readl(&tracer, ETBR_READADDR);
-	etb_st =3D etb_readl(&tracer, ETBR_STATUS);
-	etb_fc =3D etb_readl(&tracer, ETBR_FORMATTERCTRL);
-	etb_lock(&tracer);
+	mutex_lock(&tracer.mutex);
+	if (tracer.etb_regs) {
+		etb_unlock(&tracer);
+		datalen =3D etb_getdatalen(&tracer);
+		etb_wa =3D etb_readl(&tracer, ETBR_WRITEADDR);
+		etb_ra =3D etb_readl(&tracer, ETBR_READADDR);
+		etb_st =3D etb_readl(&tracer, ETBR_STATUS);
+		etb_fc =3D etb_readl(&tracer, ETBR_FORMATTERCTRL);
+		etb_lock(&tracer);
+	} else {
+		etb_wa =3D etb_ra =3D etb_st =3D etb_fc =3D ~0;
+		datalen =3D -1;
+	}
=20
 	etm_unlock(&tracer);
 	etm_ctrl =3D etm_readl(&tracer, ETMR_CTRL);
 	etm_st =3D etm_readl(&tracer, ETMR_STATUS);
 	etm_lock(&tracer);
+	mutex_unlock(&tracer.mutex);
=20
 	return sprintf(buf, "Trace buffer len: %d\nComparator pairs: %d\n"
 			"ETBR_WRITEADDR:\t%08x\n"
@@ -651,7 +671,6 @@ static int __init etm_probe(struct amba_device *dev=
, struct amba_id *id)
=20
 	amba_set_drvdata(dev, t);
=20
-	mutex_init(&t->mutex);
 	t->dev =3D &dev->dev;
 	t->flags =3D TRACER_CYCLE_ACC | TRACER_TRACE_DATA;
 	t->etm_portsz =3D 1;
@@ -745,6 +764,8 @@ static int __init etm_init(void)
 {
 	int retval;
=20
+	mutex_init(&tracer.mutex);
+
 	retval =3D amba_driver_register(&etb_driver);
 	if (retval) {
 		printk(KERN_ERR "Failed to register etb\n");
--=20
1.7.3.1
