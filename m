From: "Gutierrez, Juan" <jgutierrez@ti.com>
Subject: [PATCH 3/3] omap: remoteproc: add support for a boot register
Date: Fri, 13 Apr 2012 16:53:30 -0500
Message-ID: <CADVn9RH8ZYvM79ghWGe4UP6CA20WcX46S43Bgn_mOSeyqyVkPg@mail.gmail.com>
References: <1334352255-48584-1-git-send-email-jgutierrez@ti.com> <1334352255-48584-4-git-send-email-jgutierrez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:36334 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932217Ab2DMVxw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Apr 2012 17:53:52 -0400
Received: by yhjj52 with SMTP id j52so2314363yhj.22
        for <linux-omap@vger.kernel.org>; Fri, 13 Apr 2012 14:53:50 -0700 (PDT)
In-Reply-To: <1334352255-48584-4-git-send-email-jgutierrez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ohad@wizery.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: jgutierrez@ti.com, s-anna@ti.com

Some remote processors (like Omap4's DSP) need to explicitly
configure a boot address in a special register or memory
location, and this is the address from which they start
executing code when taken out of reset.

Support for this infrastructure has been added to remoteproc
code. The memory or register address where the boot address
is to be stored is supplied through the boot_reg field of the
platform data in the remoteproc. The omap_rproc_start function
will fetch the boot address from the image, and write this
address into the boot register, if provided, before taking the
processor out of reset.

Signed-off-by: Juan Gutierrez <jgutierrez@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
=C2=A0arch/arm/plat-omap/include/plat/remoteproc.h | =C2=A0 =C2=A02 ++
=C2=A0drivers/remoteproc/omap_remoteproc.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
| =C2=A0 19 +++++++++++++++++++
=C2=A02 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/remoteproc.h
b/arch/arm/plat-omap/include/plat/remoteproc.h
index b10eac8..2066a14 100644
--- a/arch/arm/plat-omap/include/plat/remoteproc.h
+++ b/arch/arm/plat-omap/include/plat/remoteproc.h
@@ -30,6 +30,7 @@ struct platform_device;
=C2=A0* @ops: start/stop rproc handlers
=C2=A0* @device_enable: omap-specific handler for enabling a device
=C2=A0* @device_shutdown: omap-specific handler for shutting down a dev=
ice
+ * @boot_reg: physical address of the control register for storing boo=
t address
=C2=A0*/
=C2=A0struct omap_rproc_pdata {
=C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name;
@@ -40,6 +41,7 @@ struct omap_rproc_pdata {
=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct rproc_ops *ops;
=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*device_enable) (struct platform_device=
 *pdev);
=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*device_shutdown) (struct platform_devi=
ce *pdev);
+ =C2=A0 =C2=A0 =C2=A0 u32 boot_reg;
=C2=A0};

=C2=A0#if defined(CONFIG_OMAP_REMOTEPROC) || defined(CONFIG_OMAP_REMOTE=
PROC_MODULE)
diff --git a/drivers/remoteproc/omap_remoteproc.c
b/drivers/remoteproc/omap_remoteproc.c
index 69425c4..e9b2f85 100644
--- a/drivers/remoteproc/omap_remoteproc.c
+++ b/drivers/remoteproc/omap_remoteproc.c
@@ -39,11 +39,13 @@
=C2=A0* @mbox: omap mailbox handle
=C2=A0* @nb: notifier block that will be invoked on inbound mailbox mes=
sages
=C2=A0* @rproc: rproc handle
+ * @boot_reg: virtual address of the register where the bootaddr is st=
ored
=C2=A0*/
=C2=A0struct omap_rproc {
=C2=A0 =C2=A0 =C2=A0 =C2=A0struct omap_mbox *mbox;
=C2=A0 =C2=A0 =C2=A0 =C2=A0struct notifier_block nb;
=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rproc *rproc;
+ =C2=A0 =C2=A0 =C2=A0 void __iomem *boot_reg;
=C2=A0};

=C2=A0/**
@@ -114,6 +116,10 @@ static int omap_rproc_start(struct rproc *rproc)
=C2=A0 =C2=A0 =C2=A0 =C2=A0struct omap_rproc_pdata *pdata =3D pdev->dev=
=2Eplatform_data;
=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;

+ =C2=A0 =C2=A0 =C2=A0 /* load remote processor boot address if needed.=
 */
+ =C2=A0 =C2=A0 =C2=A0 if (oproc->boot_reg)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 writel(rproc->bootad=
dr, oproc->boot_reg);
+
=C2=A0 =C2=A0 =C2=A0 =C2=A0oproc->nb.notifier_call =3D omap_rproc_mbox_=
callback;

=C2=A0 =C2=A0 =C2=A0 =C2=A0/* every omap rproc is assigned a mailbox in=
stance for messaging */
@@ -194,6 +200,12 @@ static int __devinit omap_rproc_probe(struct
platform_device *pdev)
=C2=A0 =C2=A0 =C2=A0 =C2=A0oproc =3D rproc->priv;
=C2=A0 =C2=A0 =C2=A0 =C2=A0oproc->rproc =3D rproc;

+ =C2=A0 =C2=A0 =C2=A0 if (pdata->boot_reg) {
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 oproc->boot_reg =3D =
ioremap(pdata->boot_reg, sizeof(u32));
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!oproc->boot_reg=
)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 goto err_ioremap;
+ =C2=A0 =C2=A0 =C2=A0 }
+
=C2=A0 =C2=A0 =C2=A0 =C2=A0platform_set_drvdata(pdev, rproc);

=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rproc_register(rproc);
@@ -203,6 +215,9 @@ static int __devinit omap_rproc_probe(struct
platform_device *pdev)
=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;

=C2=A0free_rproc:
+ =C2=A0 =C2=A0 =C2=A0 if (oproc->boot_reg)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iounmap(oproc->boot_=
reg);
+err_ioremap:
=C2=A0 =C2=A0 =C2=A0 =C2=A0rproc_free(rproc);
=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
=C2=A0}
@@ -210,6 +225,10 @@ free_rproc:
=C2=A0static int __devexit omap_rproc_remove(struct platform_device *pd=
ev)
=C2=A0{
=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rproc *rproc =3D platform_get_drvdata=
(pdev);
+ =C2=A0 =C2=A0 =C2=A0 struct omap_rproc *oproc =3D rproc->priv;
+
+ =C2=A0 =C2=A0 =C2=A0 if (oproc->boot_reg)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iounmap(oproc->boot_=
reg);

=C2=A0 =C2=A0 =C2=A0 =C2=A0return rproc_unregister(rproc);
=C2=A0}
--
1.7.5.4
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
