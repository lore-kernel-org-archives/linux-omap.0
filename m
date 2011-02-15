From: =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
Subject: [PATCH 8/8] ARM: etm: Support multiple ETMs/PTMs.
Date: Mon, 14 Feb 2011 22:11:16 -0800
Message-ID: <1297750276-12475-8-git-send-email-arve@android.com>
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

If more than one ETM or PTM are present, configure all of them
and enable the formatter in the ETB. This allows tracing on dual
core systems (e.g. omap4).

Signed-off-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
---
 arch/arm/include/asm/hardware/coresight.h |   16 ++-
 arch/arm/kernel/etm.c                     |  234 +++++++++++++++++++--=
--------
 2 files changed, 166 insertions(+), 84 deletions(-)

diff --git a/arch/arm/include/asm/hardware/coresight.h b/arch/arm/inclu=
de/asm/hardware/coresight.h
index 6ea507f..6643d6c 100644
--- a/arch/arm/include/asm/hardware/coresight.h
+++ b/arch/arm/include/asm/hardware/coresight.h
@@ -25,9 +25,9 @@
=20
 #define TRACER_TIMEOUT 10000
=20
-#define etm_writel(t, v, x) \
-	(__raw_writel((v), (t)->etm_regs + (x)))
-#define etm_readl(t, x) (__raw_readl((t)->etm_regs + (x)))
+#define etm_writel(t, id, v, x) \
+	(__raw_writel((v), (t)->etm_regs[(id)] + (x)))
+#define etm_readl(t, id, x) (__raw_readl((t)->etm_regs[(id)] + (x)))
=20
 /* CoreSight Management Registers */
 #define CSMR_LOCKACCESS 0xfb0
@@ -126,6 +126,8 @@
 				ETMCTRL_BRANCH_OUTPUT | \
 				ETMCTRL_DO_CONTEXTID)
=20
+#define ETMR_TRACEIDR		0x200
+
 /* ETM management registers, "ETM Architecture", 3.5.24 */
 #define ETMMR_OSLAR	0x300
 #define ETMMR_OSLSR	0x304
@@ -148,14 +150,16 @@
 #define ETBFF_TRIGIN		BIT(8)
 #define ETBFF_TRIGEVT		BIT(9)
 #define ETBFF_TRIGFL		BIT(10)
+#define ETBFF_STOPFL		BIT(12)
=20
 #define etb_writel(t, v, x) \
 	(__raw_writel((v), (t)->etb_regs + (x)))
 #define etb_readl(t, x) (__raw_readl((t)->etb_regs + (x)))
=20
-#define etm_lock(t) do { etm_writel((t), 0, CSMR_LOCKACCESS); } while =
(0)
-#define etm_unlock(t) \
-	do { etm_writel((t), UNLOCK_MAGIC, CSMR_LOCKACCESS); } while (0)
+#define etm_lock(t, id) \
+	do { etm_writel((t), (id), 0, CSMR_LOCKACCESS); } while (0)
+#define etm_unlock(t, id) \
+	do { etm_writel((t), (id), UNLOCK_MAGIC, CSMR_LOCKACCESS); } while (0=
)
=20
 #define etb_lock(t) do { etb_writel((t), 0, CSMR_LOCKACCESS); } while =
(0)
 #define etb_unlock(t) \
diff --git a/arch/arm/kernel/etm.c b/arch/arm/kernel/etm.c
index 4ad1257..48de5a4 100644
--- a/arch/arm/kernel/etm.c
+++ b/arch/arm/kernel/etm.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/io.h>
+#include <linux/slab.h>
 #include <linux/sysrq.h>
 #include <linux/device.h>
 #include <linux/clk.h>
@@ -36,10 +37,12 @@ MODULE_AUTHOR("Alexander Shishkin");
 struct tracectx {
 	unsigned int	etb_bufsz;
 	void __iomem	*etb_regs;
-	void __iomem	*etm_regs;
+	void __iomem	**etm_regs;
+	int		etm_regs_count;
 	unsigned long	flags;
 	int		ncmppairs;
 	int		etm_portsz;
+	u32		etb_fc;
 	unsigned long	range_start;
 	unsigned long	range_end;
 	unsigned long	data_range_start;
@@ -60,7 +63,7 @@ static inline bool trace_isrunning(struct tracectx *t=
)
 	return !!(t->flags & TRACER_RUNNING);
 }
=20
-static int etm_setup_address_range(struct tracectx *t, int n,
+static int etm_setup_address_range(struct tracectx *t, int id, int n,
 		unsigned long start, unsigned long end, int exclude, int data)
 {
 	u32 flags =3D ETMAAT_ARM | ETMAAT_IGNCONTEXTID | ETMAAT_IGNSECURITY |
@@ -79,41 +82,31 @@ static int etm_setup_address_range(struct tracectx =
*t, int n,
 		flags |=3D ETMAAT_IEXEC;
=20
 	/* first comparator for the range */
-	etm_writel(t, flags, ETMR_COMP_ACC_TYPE(n * 2));
-	etm_writel(t, start, ETMR_COMP_VAL(n * 2));
+	etm_writel(t, id, flags, ETMR_COMP_ACC_TYPE(n * 2));
+	etm_writel(t, id, start, ETMR_COMP_VAL(n * 2));
=20
 	/* second comparator is right next to it */
-	etm_writel(t, flags, ETMR_COMP_ACC_TYPE(n * 2 + 1));
-	etm_writel(t, end, ETMR_COMP_VAL(n * 2 + 1));
+	etm_writel(t, id, flags, ETMR_COMP_ACC_TYPE(n * 2 + 1));
+	etm_writel(t, id, end, ETMR_COMP_VAL(n * 2 + 1));
=20
 	if (data) {
 		flags =3D exclude ? ETMVDC3_EXCLONLY : 0;
 		if (exclude)
 			n +=3D 8;
-		etm_writel(t, flags | BIT(n), ETMR_VIEWDATACTRL3);
+		etm_writel(t, id, flags | BIT(n), ETMR_VIEWDATACTRL3);
 	} else {
 		flags =3D exclude ? ETMTE_INCLEXCL : 0;
-		etm_writel(t, flags | (1 << n), ETMR_TRACEENCTRL);
+		etm_writel(t, id, flags | (1 << n), ETMR_TRACEENCTRL);
 	}
=20
 	return 0;
 }
=20
-static int trace_start(struct tracectx *t)
+static int trace_start_etm(struct tracectx *t, int id)
 {
 	u32 v;
 	unsigned long timeout =3D TRACER_TIMEOUT;
=20
-	etb_unlock(t);
-
-	t->dump_initial_etb =3D false;
-	etb_writel(t, 0, ETBR_WRITEADDR);
-	etb_writel(t, 0, ETBR_FORMATTERCTRL);
-	etb_writel(t, 1, ETBR_CTRL);
-
-	etb_lock(t);
-
-	/* configure etm */
 	v =3D ETMCTRL_OPTS | ETMCTRL_PROGRAM | ETMCTRL_PORTSIZE(t->etm_portsz=
);
=20
 	if (t->flags & TRACER_CYCLE_ACC)
@@ -122,79 +115,122 @@ static int trace_start(struct tracectx *t)
 	if (t->flags & TRACER_TRACE_DATA)
 		v |=3D ETMCTRL_DATA_DO_ADDR;
=20
-	etm_unlock(t);
+	etm_unlock(t, id);
=20
-	etm_writel(t, v, ETMR_CTRL);
+	etm_writel(t, id, v, ETMR_CTRL);
=20
-	while (!(etm_readl(t, ETMR_CTRL) & ETMCTRL_PROGRAM) && --timeout)
+	while (!(etm_readl(t, id, ETMR_CTRL) & ETMCTRL_PROGRAM) && --timeout)
 		;
 	if (!timeout) {
 		dev_dbg(t->dev, "Waiting for progbit to assert timed out\n");
-		etm_lock(t);
+		etm_lock(t, id);
 		return -EFAULT;
 	}
=20
 	if (t->range_start || t->range_end)
-		etm_setup_address_range(t, 1,
+		etm_setup_address_range(t, id, 1,
 					t->range_start, t->range_end, 0, 0);
 	else
-		etm_writel(t, ETMTE_INCLEXCL, ETMR_TRACEENCTRL);
+		etm_writel(t, id, ETMTE_INCLEXCL, ETMR_TRACEENCTRL);
=20
-	etm_writel(t, 0, ETMR_TRACEENCTRL2);
-	etm_writel(t, 0, ETMR_TRACESSCTRL);
-	etm_writel(t, 0x6f, ETMR_TRACEENEVT);
+	etm_writel(t, id, 0, ETMR_TRACEENCTRL2);
+	etm_writel(t, id, 0, ETMR_TRACESSCTRL);
+	etm_writel(t, id, 0x6f, ETMR_TRACEENEVT);
=20
-	etm_writel(t, 0, ETMR_VIEWDATACTRL1);
-	etm_writel(t, 0, ETMR_VIEWDATACTRL2);
+	etm_writel(t, id, 0, ETMR_VIEWDATACTRL1);
+	etm_writel(t, id, 0, ETMR_VIEWDATACTRL2);
=20
 	if (t->data_range_start || t->data_range_end)
-		etm_setup_address_range(t, 2, t->data_range_start,
+		etm_setup_address_range(t, id, 2, t->data_range_start,
 					t->data_range_end, 0, 1);
 	else
-		etm_writel(t, ETMVDC3_EXCLONLY, ETMR_VIEWDATACTRL3);
+		etm_writel(t, id, ETMVDC3_EXCLONLY, ETMR_VIEWDATACTRL3);
=20
-	etm_writel(t, 0x6f, ETMR_VIEWDATAEVT);
+	etm_writel(t, id, 0x6f, ETMR_VIEWDATAEVT);
=20
 	v &=3D ~ETMCTRL_PROGRAM;
 	v |=3D ETMCTRL_PORTSEL;
=20
-	etm_writel(t, v, ETMR_CTRL);
+	etm_writel(t, id, v, ETMR_CTRL);
=20
 	timeout =3D TRACER_TIMEOUT;
-	while (etm_readl(t, ETMR_CTRL) & ETMCTRL_PROGRAM && --timeout)
+	while (etm_readl(t, id, ETMR_CTRL) & ETMCTRL_PROGRAM && --timeout)
 		;
 	if (!timeout) {
 		dev_dbg(t->dev, "Waiting for progbit to deassert timed out\n");
-		etm_lock(t);
+		etm_lock(t, id);
 		return -EFAULT;
 	}
=20
-	etm_lock(t);
+	etm_lock(t, id);
+	return 0;
+}
+
+static int trace_start(struct tracectx *t)
+{
+	int ret;
+	int id;
+	u32 etb_fc =3D t->etb_fc;
+
+	etb_unlock(t);
+
+	t->dump_initial_etb =3D false;
+	etb_writel(t, 0, ETBR_WRITEADDR);
+	etb_writel(t, etb_fc, ETBR_FORMATTERCTRL);
+	etb_writel(t, 1, ETBR_CTRL);
+
+	etb_lock(t);
+
+	/* configure etm(s) */
+	for (id =3D 0; id < t->etm_regs_count; id++) {
+		ret =3D trace_start_etm(t, id);
+		if (ret)
+			return ret;
+	}
=20
 	t->flags |=3D TRACER_RUNNING;
=20
 	return 0;
 }
=20
-static int trace_stop(struct tracectx *t)
+static int trace_stop_etm(struct tracectx *t, int id)
 {
 	unsigned long timeout =3D TRACER_TIMEOUT;
=20
-	etm_unlock(t);
+	etm_unlock(t, id);
=20
-	etm_writel(t, 0x440, ETMR_CTRL);
-	while (!(etm_readl(t, ETMR_CTRL) & ETMCTRL_PROGRAM) && --timeout)
+	etm_writel(t, id, 0x440, ETMR_CTRL);
+	while (!(etm_readl(t, id, ETMR_CTRL) & ETMCTRL_PROGRAM) && --timeout)
 		;
 	if (!timeout) {
 		dev_dbg(t->dev, "Waiting for progbit to assert timed out\n");
-		etm_lock(t);
+		etm_lock(t, id);
 		return -EFAULT;
 	}
=20
-	etm_lock(t);
+	etm_lock(t, id);
+	return 0;
+}
+
+static int trace_stop(struct tracectx *t)
+{
+	int id;
+	int ret;
+	unsigned long timeout =3D TRACER_TIMEOUT;
+	u32 etb_fc =3D t->etb_fc;
+
+	for (id =3D 0; id < t->etm_regs_count; id++) {
+		ret =3D trace_stop_etm(t, id);
+		if (ret)
+			return ret;
+	}
=20
 	etb_unlock(t);
-	etb_writel(t, ETBFF_MANUAL_FLUSH, ETBR_FORMATTERCTRL);
+	if (etb_fc) {
+		etb_fc |=3D ETBFF_STOPFL;
+		etb_writel(t, t->etb_fc, ETBR_FORMATTERCTRL);
+	}
+	etb_writel(t, etb_fc | ETBFF_MANUAL_FLUSH, ETBR_FORMATTERCTRL);
=20
 	timeout =3D TRACER_TIMEOUT;
 	while (etb_readl(t, ETBR_FORMATTERCTRL) &
@@ -389,6 +425,7 @@ static int __init etb_probe(struct amba_device *dev=
, struct amba_id *id)
 		goto out_release;
 	}
=20
+	t->dev =3D &dev->dev;
 	t->dump_initial_etb =3D true;
 	amba_set_drvdata(dev, t);
=20
@@ -507,6 +544,8 @@ static ssize_t trace_info_show(struct kobject *kobj=
,
 {
 	u32 etb_wa, etb_ra, etb_st, etb_fc, etm_ctrl, etm_st;
 	int datalen;
+	int id;
+	int ret;
=20
 	mutex_lock(&tracer.mutex);
 	if (tracer.etb_regs) {
@@ -522,28 +561,33 @@ static ssize_t trace_info_show(struct kobject *ko=
bj,
 		datalen =3D -1;
 	}
=20
-	etm_unlock(&tracer);
-	etm_ctrl =3D etm_readl(&tracer, ETMR_CTRL);
-	etm_st =3D etm_readl(&tracer, ETMR_STATUS);
-	etm_lock(&tracer);
-	mutex_unlock(&tracer.mutex);
-
-	return sprintf(buf, "Trace buffer len: %d\nComparator pairs: %d\n"
+	ret =3D sprintf(buf, "Trace buffer len: %d\nComparator pairs: %d\n"
 			"ETBR_WRITEADDR:\t%08x\n"
 			"ETBR_READADDR:\t%08x\n"
 			"ETBR_STATUS:\t%08x\n"
-			"ETBR_FORMATTERCTRL:\t%08x\n"
-			"ETMR_CTRL:\t%08x\n"
-			"ETMR_STATUS:\t%08x\n",
+			"ETBR_FORMATTERCTRL:\t%08x\n",
 			datalen,
 			tracer.ncmppairs,
 			etb_wa,
 			etb_ra,
 			etb_st,
-			etb_fc,
+			etb_fc
+			);
+
+	for (id =3D 0; id < tracer.etm_regs_count; id++) {
+		etm_unlock(&tracer, id);
+		etm_ctrl =3D etm_readl(&tracer, id, ETMR_CTRL);
+		etm_st =3D etm_readl(&tracer, id, ETMR_STATUS);
+		etm_lock(&tracer, id);
+		ret +=3D sprintf(buf + ret, "ETMR_CTRL:\t%08x\n"
+			"ETMR_STATUS:\t%08x\n",
 			etm_ctrl,
 			etm_st
 			);
+	}
+	mutex_unlock(&tracer.mutex);
+
+	return ret;
 }
=20
 static struct kobj_attribute trace_info_attr =3D
@@ -657,37 +701,46 @@ static int __init etm_probe(struct amba_device *d=
ev, struct amba_id *id)
 {
 	struct tracectx *t =3D &tracer;
 	int ret =3D 0;
+	void __iomem **new_regs;
+	int new_count;
=20
-	if (t->etm_regs) {
-		dev_dbg(&dev->dev, "ETM already initialized\n");
-		ret =3D -EBUSY;
+	mutex_lock(&t->mutex);
+	new_count =3D t->etm_regs_count + 1;
+	new_regs =3D krealloc(t->etm_regs,
+				sizeof(t->etm_regs[0]) * new_count, GFP_KERNEL);
+
+	if (!new_regs) {
+		dev_dbg(&dev->dev, "Failed to allocate ETM register array\n");
+		ret =3D -ENOMEM;
 		goto out;
 	}
+	t->etm_regs =3D new_regs;
=20
 	ret =3D amba_request_regions(dev, NULL);
 	if (ret)
 		goto out;
=20
-	t->etm_regs =3D ioremap_nocache(dev->res.start, resource_size(&dev->r=
es));
-	if (!t->etm_regs) {
+	t->etm_regs[t->etm_regs_count] =3D
+		ioremap_nocache(dev->res.start, resource_size(&dev->res));
+	if (!t->etm_regs[t->etm_regs_count]) {
 		ret =3D -ENOMEM;
 		goto out_release;
 	}
=20
-	amba_set_drvdata(dev, t);
+	amba_set_drvdata(dev, t->etm_regs[t->etm_regs_count]);
=20
-	t->dev =3D &dev->dev;
 	t->flags =3D TRACER_CYCLE_ACC | TRACER_TRACE_DATA;
 	t->etm_portsz =3D 1;
=20
-	etm_unlock(t);
-	(void)etm_readl(t, ETMMR_PDSR);
+	etm_unlock(t, t->etm_regs_count);
+	(void)etm_readl(t, t->etm_regs_count, ETMMR_PDSR);
 	/* dummy first read */
-	(void)etm_readl(&tracer, ETMMR_OSSRR);
+	(void)etm_readl(&tracer, t->etm_regs_count, ETMMR_OSSRR);
=20
-	t->ncmppairs =3D etm_readl(t, ETMR_CONFCODE) & 0xf;
-	etm_writel(t, 0x440, ETMR_CTRL);
-	etm_lock(t);
+	t->ncmppairs =3D etm_readl(t, t->etm_regs_count, ETMR_CONFCODE) & 0xf=
;
+	etm_writel(t, t->etm_regs_count, 0x440, ETMR_CTRL);
+	etm_writel(t, t->etm_regs_count, new_count, ETMR_TRACEIDR);
+	etm_lock(t, t->etm_regs_count);
=20
 	ret =3D sysfs_create_file(&dev->dev.kobj,
 			&trace_running_attr.attr);
@@ -712,31 +765,34 @@ static int __init etm_probe(struct amba_device *d=
ev, struct amba_id *id)
 		dev_dbg(&dev->dev,
 			"Failed to create trace_data_range in sysfs\n");
=20
-	dev_dbg(t->dev, "ETM AMBA driver initialized.\n");
+	dev_dbg(&dev->dev, "ETM AMBA driver initialized.\n");
+
+	/* Enable formatter if there are multiple trace sources */
+	if (new_count > 1)
+		t->etb_fc =3D ETBFF_ENFCONT | ETBFF_ENFTC;
+
+	t->etm_regs_count =3D new_count;
=20
 out:
+	mutex_unlock(&t->mutex);
 	return ret;
=20
 out_unmap:
 	amba_set_drvdata(dev, NULL);
-	iounmap(t->etm_regs);
+	iounmap(t->etm_regs[t->etm_regs_count]);
=20
 out_release:
 	amba_release_regions(dev);
=20
+	mutex_unlock(&t->mutex);
 	return ret;
 }
=20
 static int etm_remove(struct amba_device *dev)
 {
-	struct tracectx *t =3D amba_get_drvdata(dev);
-
-	amba_set_drvdata(dev, NULL);
-
-	iounmap(t->etm_regs);
-	t->etm_regs =3D NULL;
-
-	amba_release_regions(dev);
+	int i;
+	struct tracectx *t =3D &tracer;
+	void __iomem	*etm_regs =3D amba_get_drvdata(dev);
=20
 	sysfs_remove_file(&dev->dev.kobj, &trace_running_attr.attr);
 	sysfs_remove_file(&dev->dev.kobj, &trace_info_attr.attr);
@@ -744,6 +800,24 @@ static int etm_remove(struct amba_device *dev)
 	sysfs_remove_file(&dev->dev.kobj, &trace_range_attr.attr);
 	sysfs_remove_file(&dev->dev.kobj, &trace_data_range_attr.attr);
=20
+	amba_set_drvdata(dev, NULL);
+
+	mutex_lock(&t->mutex);
+	for (i =3D 0; i < t->etm_regs_count; i++)
+		if (t->etm_regs[i] =3D=3D etm_regs)
+			break;
+	for (; i < t->etm_regs_count - 1; i++)
+		t->etm_regs[i] =3D t->etm_regs[i + 1];
+	t->etm_regs_count--;
+	if (!t->etm_regs_count) {
+		kfree(t->etm_regs);
+		t->etm_regs =3D NULL;
+	}
+	mutex_unlock(&t->mutex);
+
+	iounmap(etm_regs);
+	amba_release_regions(dev);
+
 	return 0;
 }
=20
@@ -752,6 +826,10 @@ static struct amba_id etm_ids[] =3D {
 		.id	=3D 0x0003b921,
 		.mask	=3D 0x0007ffff,
 	},
+	{
+		.id	=3D 0x0003b950,
+		.mask	=3D 0x0007ffff,
+	},
 	{ 0, 0 },
 };
=20
--=20
1.7.3.1
