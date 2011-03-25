From: Michael Jones <michael.jones@matrix-vision.de>
Subject: [PATCH] omap: fix compiler warning
Date: Fri, 25 Mar 2011 17:21:41 +0100
Message-ID: <1301070101-12631-1-git-send-email-michael.jones@matrix-vision.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail1.matrix-vision.com ([78.47.19.71]:39464 "EHLO
	mail1.matrix-vision.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753998Ab1CYQXM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 12:23:12 -0400
Received: from mail1.matrix-vision.com (localhost [127.0.0.1])
	by mail1.matrix-vision.com (Postfix) with ESMTP id AEEB8721AD
	for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 17:23:11 +0100 (CET)
Received: from erinome (g2.matrix-vision.com [80.152.136.245])
	by mail1.matrix-vision.com (Postfix) with ESMTPA id 851047213E
	for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 17:23:11 +0100 (CET)
Received: from erinome (localhost [127.0.0.1])
	by erinome (Postfix) with ESMTP id DA12D6F8A
	for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 17:23:10 +0100 (CET)
Received: from ap437-joe.intern.matrix-vision.de (host65-46.intern.matrix-vision.de [192.168.65.46])
	by erinome (Postfix) with ESMTPA id AD3C16F8A
	for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 17:23:10 +0100 (CET)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

  CC      arch/arm/plat-omap/gpio.o
arch/arm/plat-omap/gpio.c: In function =E2=80=98omap_gpio_chip_init=E2=80=
=99:
arch/arm/plat-omap/gpio.c:1675: warning: unused variable =E2=80=98d=E2=80=
=99

Signed-off-by: Michael Jones <michael.jones@matrix-vision.de>
---
 arch/arm/plat-omap/gpio.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 971d186..a1d4d1b 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1672,7 +1672,9 @@ static void __init omap_gpio_chip_init(struct gpi=
o_bank *bank)
=20
 	for (j =3D bank->virtual_irq_start;
 		     j < bank->virtual_irq_start + bank_width; j++) {
+#ifdef CONFIG_LOCKDEP
 		struct irq_desc *d =3D irq_to_desc(j);
+#endif
=20
 		lockdep_set_class(&d->lock, &gpio_lock_class);
 		set_irq_chip_data(j, bank);
--=20
1.7.4.1


MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
