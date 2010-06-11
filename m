From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 13/14] omap: mailbox: simplify omap_mbox_register()
Date: Fri, 11 Jun 2010 18:17:51 +0300
Message-ID: <AANLkTinAKOZwGSDsQv5VKXBrr1BSQw-9w5Dcq2Z_96M0@mail.gmail.com>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
	<1274548465-20208-14-git-send-email-felipe.contreras@gmail.com>
	<20100524.174233.26958915.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f204.google.com ([209.85.211.204]:58117 "EHLO
	mail-yw0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424Ab0FKPRx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jun 2010 11:17:53 -0400
Received: by ywh42 with SMTP id 42so1204456ywh.15
        for <linux-omap@vger.kernel.org>; Fri, 11 Jun 2010 08:17:52 -0700 (PDT)
In-Reply-To: <20100524.174233.26958915.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

On Mon, May 24, 2010 at 5:42 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
> From: ext Felipe Contreras <felipe.contreras@gmail.com>
> Subject: [PATCH v3 13/14] omap: mailbox: simplify omap_mbox_register()
> Date: Sat, 22 May 2010 19:14:24 +0200
>
>> No need to dynamically register mailboxes one by one.
>
> Can you squash this into [PATCH 10/14]?
>
> I think that the "struct omap_mbox **list" would make more sense
> without those reworking of modifications in this patch.

I don't know, I'm looking at the patch and I think it's much more
difficult to figure out what's happening.

See:

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index 590ac66..3df1c28 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -142,44 +142,35 @@ struct omap_mbox mbox_dsp_info = {
 	.priv	= &omap1_mbox_dsp_priv,
 };

+struct omap_mbox *omap1_mboxes[] = { &mbox_dsp_info, NULL };
+
 static int __devinit omap1_mbox_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	int ret;
+	int i;
+	struct omap_mbox **list;

-	/* MBOX base */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (unlikely(!res)) {
-		dev_err(&pdev->dev, "invalid mem resource\n");
-		return -ENODEV;
-	}
+	list = omap1_mboxes;
+	list[0]->irq = platform_get_irq_byname(pdev, "dsp");

-	mbox_base = ioremap(res->start, resource_size(res));
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mbox_base = ioremap(res[0].start, resource_size(&res[0]));
 	if (!mbox_base)
 		return -ENOMEM;

-	/* DSP IRQ */
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (unlikely(!res)) {
-		dev_err(&pdev->dev, "invalid irq resource\n");
-		ret = -ENODEV;
-		goto err_out;
+	ret = omap_mbox_register(&pdev->dev, list);
+	if (ret) {
+		iounmap(mbox_base);
+		return ret;
 	}
-	mbox_dsp_info.irq = res->start;

-	ret = omap_mbox_register(&pdev->dev, &mbox_dsp_info);
-	if (ret)
-		goto err_out;
 	return 0;
-
-err_out:
-	iounmap(mbox_base);
-	return ret;
 }

 static int __devexit omap1_mbox_remove(struct platform_device *pdev)
 {
-	omap_mbox_unregister(&mbox_dsp_info);
+	omap_mbox_unregister();
 	iounmap(mbox_base);
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 3ff1ad5..f336515 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -307,6 +307,8 @@ struct omap_mbox mbox_dsp_info = {
 	.priv	= &omap2_mbox_dsp_priv,
 };

+struct omap_mbox *omap3_mboxes[] = { &mbox_dsp_info, NULL };
+
 #if defined(CONFIG_ARCH_OMAP2420)

 /* IVA */
@@ -331,6 +333,8 @@ static struct omap_mbox mbox_iva_info = {
 	.ops	= &omap2_mbox_ops,
 	.priv	= &omap2_mbox_iva_priv,
 };
+
+struct omap_mbox *omap2_mboxes[] = { &mbox_iva_info, &mbox_dsp_info, NULL };
 #endif

 /* OMAP4 */
@@ -378,89 +382,56 @@ struct omap_mbox mbox_2_info = {
 	.priv	= &omap2_mbox_2_priv,
 };

+struct omap_mbox *omap4_mboxes[] = { &mbox_1_info, &mbox_2_info, NULL };
+
 static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	int ret;
+	struct omap_mbox **list;

-	/* MBOX base */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (unlikely(!res)) {
-		dev_err(&pdev->dev, "invalid mem resource\n");
-		return -ENODEV;
+	if (cpu_is_omap3430()) {
+		list = omap3_mboxes;
+
+		list[0]->irq = platform_get_irq_byname(pdev, "dsp");
 	}
-	mbox_base = ioremap(res->start, resource_size(res));
-	if (!mbox_base)
-		return -ENOMEM;
+#if defined(CONFIG_ARCH_OMAP2420)
+	else if (cpu_is_omap2420()) {
+		list = omap2_mboxes;

-	/* DSP or IVA2 IRQ */
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+		list[0]->irq = platform_get_irq_byname(pdev, "dsp");
+		list[1]->irq = platform_get_irq_byname(pdev, "iva");
+	}
+#endif
+	else if (cpu_is_omap44xx()) {
+		list = omap4_mboxes;

-	if (unlikely(!res)) {
-		dev_err(&pdev->dev, "invalid irq resource\n");
-		ret = -ENODEV;
-		goto err_dsp;
+		list[0]->irq = list[1]->irq =
+			platform_get_irq_byname(pdev, "mbox");
 	}
-	if (cpu_is_omap44xx()) {
-		mbox_1_info.irq = res->start;
-		ret = omap_mbox_register(&pdev->dev, &mbox_1_info);
-	} else {
-		mbox_dsp_info.irq = res->start;
-		ret = omap_mbox_register(&pdev->dev, &mbox_dsp_info);
+	else {
+		pr_err("%s: platform not supported\n", __func__);
+		return -ENODEV;
 	}
-	if (ret)
-		goto err_dsp;

-	if (cpu_is_omap44xx()) {
-		mbox_2_info.irq = res->start;
-		ret = omap_mbox_register(&pdev->dev, &mbox_2_info);
-		if (ret) {
-			omap_mbox_unregister(&mbox_1_info);
-			goto err_dsp;
-		}
-	}
-#if defined(CONFIG_ARCH_OMAP2420) /* IVA */
-	if (cpu_is_omap2420()) {
-		/* IVA IRQ */
-		res = platform_get_resource(pdev, IORESOURCE_IRQ, 1);
-		if (unlikely(!res)) {
-			dev_err(&pdev->dev, "invalid irq resource\n");
-			ret = -ENODEV;
-			omap_mbox_unregister(&mbox_dsp_info);
-			goto err_dsp;
-		}
-		mbox_iva_info.irq = res->start;
-		ret = omap_mbox_register(&pdev->dev, &mbox_iva_info);
-		if (ret) {
-			omap_mbox_unregister(&mbox_dsp_info);
-			goto err_dsp;
-		}
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mbox_base = ioremap(res[0].start, resource_size(&res[0]));
+	if (!mbox_base)
+		return -ENOMEM;
+
+	ret = omap_mbox_register(&pdev->dev, list);
+	if (ret) {
+		iounmap(mbox_base);
+		return ret;
 	}
-#endif
 	return 0;

-#if defined(CONFIG_ARCH_OMAP2420) /* IVA */
-err_iva1:
-	omap_mbox_unregister(&mbox_dsp_info);
-#endif
-
-err_dsp:
-	iounmap(mbox_base);
 	return ret;
 }

 static int __devexit omap2_mbox_remove(struct platform_device *pdev)
 {
-#if defined(CONFIG_ARCH_OMAP2420)
-	if (cpu_is_omap2420())
-		omap_mbox_unregister(&mbox_iva_info);
-#endif
-
-	if (cpu_is_omap44xx()) {
-		omap_mbox_unregister(&mbox_2_info);
-		omap_mbox_unregister(&mbox_1_info);
-	} else
-		omap_mbox_unregister(&mbox_dsp_info);
+	omap_mbox_unregister();
 	iounmap(mbox_base);
 	return 0;
 }
diff --git a/arch/arm/plat-omap/include/plat/mailbox.h
b/arch/arm/plat-omap/include/plat/mailbox.h
index aad8bf8..c44fde3 100644
--- a/arch/arm/plat-omap/include/plat/mailbox.h
+++ b/arch/arm/plat-omap/include/plat/mailbox.h
@@ -55,7 +55,6 @@ struct omap_mbox {
 	struct omap_mbox_queue	*txq, *rxq;
 	struct omap_mbox_ops	*ops;
 	struct device		*dev;
-	struct omap_mbox	*next;
 	void			*priv;
 };

@@ -65,8 +64,8 @@ void omap_mbox_init_seq(struct omap_mbox *);
 struct omap_mbox *omap_mbox_get(const char *);
 void omap_mbox_put(struct omap_mbox *);

-int omap_mbox_register(struct device *parent, struct omap_mbox *);
-int omap_mbox_unregister(struct omap_mbox *);
+int omap_mbox_register(struct device *parent, struct omap_mbox **);
+int omap_mbox_unregister(void);

 static inline void omap_mbox_save_ctx(struct omap_mbox *mbox)
 {
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 38a6cb1..a8e22e1 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -33,8 +33,7 @@
 #include <plat/mailbox.h>

 static struct workqueue_struct *mboxd;
-static struct omap_mbox *mboxes;
-static DEFINE_SPINLOCK(mboxes_lock);
+static struct omap_mbox **mboxes;
 static bool rq_full;

 static int mbox_configured;
@@ -307,31 +306,20 @@ static void omap_mbox_fini(struct omap_mbox *mbox)
 	}
 }

-static struct omap_mbox **find_mboxes(const char *name)
-{
-	struct omap_mbox **p;
-
-	for (p = &mboxes; *p; p = &(*p)->next) {
-		if (strcmp((*p)->name, name) == 0)
-			break;
-	}
-
-	return p;
-}
-
 struct omap_mbox *omap_mbox_get(const char *name)
 {
 	struct omap_mbox *mbox;
 	int ret;

-	spin_lock(&mboxes_lock);
-	mbox = *(find_mboxes(name));
-	if (mbox == NULL) {
-		spin_unlock(&mboxes_lock);
-		return ERR_PTR(-ENOENT);
-	}
+	if (!mboxes)
+		return ERR_PTR(-EINVAL);

-	spin_unlock(&mboxes_lock);
+	for (mbox = *mboxes; mbox; mbox++)
+		if (!strcmp(mbox->name, name))
+			break;
+
+	if (!mbox)
+		return ERR_PTR(-ENOENT);

 	ret = omap_mbox_startup(mbox);
 	if (ret)
@@ -349,57 +337,44 @@ EXPORT_SYMBOL(omap_mbox_put);

 static struct class omap_mbox_class = { .name = "mbox", };

-int omap_mbox_register(struct device *parent, struct omap_mbox *mbox)
+int omap_mbox_register(struct device *parent, struct omap_mbox **list)
 {
-	int ret = 0;
-	struct omap_mbox **tmp;
+	int ret;
+	int i;

-	if (!mbox)
+	mboxes = list;
+	if (!mboxes)
 		return -EINVAL;
-	if (mbox->next)
-		return -EBUSY;
-
-	mbox->dev = device_create(&omap_mbox_class,
-				  parent, 0, mbox, "%s", mbox->name);
-	if (IS_ERR(mbox->dev))
-		return PTR_ERR(mbox->dev);
-
-	spin_lock(&mboxes_lock);
-	tmp = find_mboxes(mbox->name);
-	if (*tmp) {
-		ret = -EBUSY;
-		spin_unlock(&mboxes_lock);
-		goto err_find;
-	}
-	*tmp = mbox;
-	spin_unlock(&mboxes_lock);

+	for (i = 0; mboxes[i]; i++) {
+		struct omap_mbox *mbox = mboxes[i];
+		mbox->dev = device_create(&omap_mbox_class,
+				parent, 0, mbox, "%s", mbox->name);
+		if (IS_ERR(mbox->dev)) {
+			ret = PTR_ERR(mbox->dev);
+			goto err_out;
+		}
+	}
 	return 0;

-err_find:
+err_out:
+	while (i--)
+		device_unregister(mboxes[i]->dev);
 	return ret;
 }
 EXPORT_SYMBOL(omap_mbox_register);

-int omap_mbox_unregister(struct omap_mbox *mbox)
+int omap_mbox_unregister(void)
 {
-	struct omap_mbox **tmp;
-
-	spin_lock(&mboxes_lock);
-	tmp = &mboxes;
-	while (*tmp) {
-		if (mbox == *tmp) {
-			*tmp = mbox->next;
-			mbox->next = NULL;
-			spin_unlock(&mboxes_lock);
-			device_unregister(mbox->dev);
-			return 0;
-		}
-		tmp = &(*tmp)->next;
-	}
-	spin_unlock(&mboxes_lock);
+	int i;

-	return -EINVAL;
+	if (!mboxes)
+		return -EINVAL;
+
+	for (i = 0; mboxes[i]; i++)
+		device_unregister(mboxes[i]->dev);
+	mboxes = NULL;
+	return 0;
 }
 EXPORT_SYMBOL(omap_mbox_unregister);

-- 
Felipe Contreras
