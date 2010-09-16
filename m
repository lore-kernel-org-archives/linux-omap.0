From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/4] OMAP: introduce OPP layer for device-specific OPPs
Date: Thu, 16 Sep 2010 08:08:41 -0700
Message-ID: <87sk19eneu.fsf@deeprootsystems.com>
References: <1284587799-9637-1-git-send-email-khilman@deeprootsystems.com>
	<1284587799-9637-2-git-send-email-khilman@deeprootsystems.com>
	<AANLkTimC9NOJ5TSqkb1ekBQ_ei2-Ci2ewL66+4aCnyk=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:42547 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753469Ab0IPPIr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 11:08:47 -0400
Received: by pzk34 with SMTP id 34so361107pzk.19
        for <linux-omap@vger.kernel.org>; Thu, 16 Sep 2010 08:08:46 -0700 (PDT)
In-Reply-To: <AANLkTimC9NOJ5TSqkb1ekBQ_ei2-Ci2ewL66+4aCnyk=@mail.gmail.com>
	(Linus Walleij's message of "Thu, 16 Sep 2010 14:19:59 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>, Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Linus,

Linus Walleij <linus.walleij@stericsson.com> writes:

> 2010/9/15 Kevin Hilman <khilman@deeprootsystems.com>:
>
>> OMAP SOCs have a standard set of tuples consisting of frequency and
>> voltage pairs that the device will support per voltage domain. =A0Th=
ese
>> are called Operating Performance Points or OPPs.
>> (...)
>> This introduces a common handling OPP mechanism accross all OMAPs.
>> As a start this is used for OMAP3.
>
> OPPs are a generic concept, it's in silicon construction textbooks an=
d all.
> Should this code not be made generic instead? You wouldn't make
> regulators or even DMA platform-specific these days, so why should
> OPPs be?

You're right.

> What in this code is actually OMAP-specific

Only the users.  ;)

We currently register OPPs using an OMAP hwmod name, but we could easil=
y
change that to use a struct device instead which would make this
much more generic (note we manage OPPs per-device, not just for the CPU=
)

The patch below[1] demonstrates quickly how easily we could remove all =
OMAP
specific stuff from opp.[ch], and move it to the OMAP-specific code tha=
t
does the opp_add()

> more than that you name
> some functions omap_*, and how hard would it be to put it under
> arch/arm/common/*.c
> arch/arm/include/asm/*.h
>
> Possible even higher up in the directory hiearchy in include/linux/op=
p.h
> for the header and drivers/opp/*.c, because I think SuperH and power
> are not that different in this respect.

Yeah, I guess this isn't ARM specific either, so should be at a higher
level.=20

Nishanth, can take my hack below and continue this evolution?  As I
demonstrate with this hack, this won't really change anything for us.

Kevin

=46rom 96c4e27ba0cb3d9a056693340c6221bc093bce2c Mon Sep 17 00:00:00 200=
1
=46rom: Kevin Hilman <khilman@deeprootsystems.com>
Date: Thu, 16 Sep 2010 07:58:16 -0700
Subject: [PATCH] OPP: remove OMAP specifics to make more generic

Internal OPP management is based on 'struct device *', so
we don't need to have omap_hwmod specific knowledge in this layer.

Change opp_add() to take a 'struct device *' instead of using
the OMAP hwmod in the opp_def to lookup the struct device.

Move OMAP-specific hwmod lookups into the OMAP specific layer
which adds OPPs to the database.

Quickly tested on OMAP3 to see that all OPPs are still registered
correctly with CPUfreq

---
 arch/arm/mach-omap2/opp3xxx_data.c    |   18 +++++++++++++++++-
 arch/arm/plat-omap/include/plat/opp.h |    2 +-
 arch/arm/plat-omap/opp.c              |   24 ++----------------------
 3 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/opp3xxx_data.c b/arch/arm/mach-omap2/o=
pp3xxx_data.c
index e337aeb..f3f9ae4 100644
--- a/arch/arm/mach-omap2/opp3xxx_data.c
+++ b/arch/arm/mach-omap2/opp3xxx_data.c
@@ -23,6 +23,7 @@
=20
 #include <plat/opp.h>
 #include <plat/cpu.h>
+#include <plat/omap_device.h>
=20
 static struct omap_opp_def __initdata omap34xx_opp_def_list[] =3D {
 	/* MPU OPP1 */
@@ -114,7 +115,22 @@ int __init omap3_pm_init_opp_table(void)
=20
 	opp_def =3D omap3_opp_def_list;
 	for (i =3D 0; i < omap3_opp_def_size; i++) {
-		r =3D opp_add(opp_def++);
+		struct omap_hwmod *oh;
+		struct device *dev;
+
+		if (!opp_def->hwmod_name) {
+			pr_err("%s: missing name of omap_hwmod, ignoring.\n", __func__);
+			return -EINVAL;
+		}
+		oh =3D omap_hwmod_lookup(opp_def->hwmod_name);
+		if (!oh || !oh->od) {
+			pr_warn("%s: no hwmod or odev for %s, cannot add OPPs.\n",
+				__func__, opp_def->hwmod_name);
+			return -EINVAL;
+		}
+		dev =3D &oh->od->pdev.dev;
+
+		r =3D opp_add(dev, opp_def++);
 		if (r)
 			pr_err("unable to add OPP %ld Hz for %s\n",
 			       opp_def->freq, opp_def->hwmod_name);
diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap=
/include/plat/opp.h
index 9af8c83..82cfdd6 100644
--- a/arch/arm/plat-omap/include/plat/opp.h
+++ b/arch/arm/plat-omap/include/plat/opp.h
@@ -75,7 +75,7 @@ struct omap_opp *opp_find_freq_floor(struct device *d=
ev, unsigned long *freq);
=20
 struct omap_opp *opp_find_freq_ceil(struct device *dev, unsigned long =
*freq);
=20
-int opp_add(const struct omap_opp_def *opp_def);
+int opp_add(struct device *dev, const struct omap_opp_def *opp_def);
=20
 int opp_enable(struct omap_opp *opp);
=20
diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
index b26326b..f5295ca 100644
--- a/arch/arm/plat-omap/opp.c
+++ b/arch/arm/plat-omap/opp.c
@@ -21,7 +21,6 @@
 #include <linux/list.h>
=20
 #include <plat/opp.h>
-#include <plat/omap_device.h>
=20
 /**
  * struct omap_opp - OMAP OPP description structure
@@ -58,7 +57,6 @@ struct omap_opp {
 struct device_opp {
 	struct list_head node;
=20
-	struct omap_hwmod *oh;
 	struct device *dev;
=20
 	struct list_head opp_list;
@@ -291,29 +289,12 @@ static void omap_opp_populate(struct omap_opp *op=
p,
  *
  * This function adds an opp definition to the opp list and returns st=
atus.
  */
-int opp_add(const struct omap_opp_def *opp_def)
+int opp_add(struct device *dev, const struct omap_opp_def *opp_def)
 {
-	struct omap_hwmod *oh;
-	struct device *dev =3D NULL;
 	struct device_opp *tmp_dev_opp, *dev_opp =3D NULL;
 	struct omap_opp *opp, *new_opp;
-	struct platform_device *pdev;
 	struct list_head *head;
=20
-	/* find the correct hwmod, and device */
-	if (!opp_def->hwmod_name) {
-		pr_err("%s: missing name of omap_hwmod, ignoring.\n", __func__);
-		return -EINVAL;
-	}
-	oh =3D omap_hwmod_lookup(opp_def->hwmod_name);
-	if (!oh || !oh->od) {
-		pr_warn("%s: no hwmod or odev for %s, cannot add OPPs.\n",
-			__func__, opp_def->hwmod_name);
-		return -EINVAL;
-	}
-	pdev =3D &oh->od->pdev;
-	dev =3D &oh->od->pdev.dev;
-
 	/* Check for existing list for 'dev' */
 	list_for_each_entry(tmp_dev_opp, &dev_opp_list, node) {
 		if (dev =3D=3D tmp_dev_opp->dev) {
@@ -331,8 +312,7 @@ int opp_add(const struct omap_opp_def *opp_def)
 			return -ENOMEM;
 		}
=20
-		dev_opp->oh =3D oh;
-		dev_opp->dev =3D &oh->od->pdev.dev;
+		dev_opp->dev =3D dev;
 		INIT_LIST_HEAD(&dev_opp->opp_list);
=20
 		list_add(&dev_opp->node, &dev_opp_list);
--=20
1.7.2.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
