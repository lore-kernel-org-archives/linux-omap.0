From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [RESEND] [PATCH v2 1/2] arm: devtree: Set system_rev from DT revision
Date: Wed,  6 May 2015 10:49:01 +0200
Message-ID: <1430902142-17035-2-git-send-email-pali.rohar@gmail.com>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:34524 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753495AbbEFItW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 May 2015 04:49:22 -0400
In-Reply-To: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>, Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc: linux-omap@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

With this patch "revision" DT string entry is used to set global system=
_rev
variable. DT "revision" is expected to be string with one hexadecimal n=
umber.
So "Revision" line in /proc/cpuinfo will be same as "revision" DT value=
=2E

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 arch/arm/kernel/devtree.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 11c54de..7e13e27 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -19,6 +19,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/smp.h>
+#include <linux/libfdt_env.h>
=20
 #include <asm/cputype.h>
 #include <asm/setup.h>
@@ -26,6 +27,7 @@
 #include <asm/smp_plat.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
+#include <asm/system_info.h>
=20
=20
 #ifdef CONFIG_SMP
@@ -204,6 +206,9 @@ static const void * __init arch_get_next_mach(const=
 char *const **match)
 const struct machine_desc * __init setup_machine_fdt(unsigned int dt_p=
hys)
 {
 	const struct machine_desc *mdesc, *mdesc_best =3D NULL;
+	unsigned long dt_root;
+	const char *prop;
+	int size;
=20
 #ifdef CONFIG_ARCH_MULTIPLATFORM
 	DT_MACHINE_START(GENERIC_DT, "Generic DT based system")
@@ -215,17 +220,13 @@ const struct machine_desc * __init setup_machine_=
fdt(unsigned int dt_phys)
 	if (!dt_phys || !early_init_dt_verify(phys_to_virt(dt_phys)))
 		return NULL;
=20
+	dt_root =3D of_get_flat_dt_root();
 	mdesc =3D of_flat_dt_match_machine(mdesc_best, arch_get_next_mach);
=20
 	if (!mdesc) {
-		const char *prop;
-		int size;
-		unsigned long dt_root;
-
 		early_print("\nError: unrecognized/unsupported "
 			    "device tree compatible list:\n[ ");
=20
-		dt_root =3D of_get_flat_dt_root();
 		prop =3D of_get_flat_dt_prop(dt_root, "compatible", &size);
 		while (size > 0) {
 			early_print("'%s' ", prop);
@@ -246,5 +247,14 @@ const struct machine_desc * __init setup_machine_f=
dt(unsigned int dt_phys)
 	/* Change machine number to match the mdesc we're using */
 	__machine_arch_type =3D mdesc->nr;
=20
+	/* Set system revision from DT */
+	prop =3D of_get_flat_dt_prop(dt_root, "revision", &size);
+	if (prop && size > 0) {
+		char revision[11];
+		strlcpy(revision, prop, min(size, (int)sizeof(revision)));
+		if (kstrtouint(revision, 16, &system_rev) !=3D 0)
+			system_rev =3D 0;
+	}
+
 	return mdesc;
 }
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
