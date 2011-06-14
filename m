From: Tasslehoff Kjappfot <tasskjapp@gmail.com>
Subject: [PATCH] Fix wrong OMAP_ES_x_y defines that make omap_rev_lt_x_y and
 friends misbehave
Date: Tue, 14 Jun 2011 12:39:26 +0200
Message-ID: <BANLkTi=75up6OQwRzGJ586eVLorEdpCa7w@mail.gmail.com>
References: <BANLkTinWdQsjttt0m1h9KbVPjb6rWXNpvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37224 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755914Ab1FNKj2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jun 2011 06:39:28 -0400
Received: by fxm17 with SMTP id 17so3511331fxm.19
        for <linux-omap@vger.kernel.org>; Tue, 14 Jun 2011 03:39:27 -0700 (PDT)
In-Reply-To: <BANLkTinWdQsjttt0m1h9KbVPjb6rWXNpvA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

=46rom 620fa271b32f8bdd8f06954c0a2c96af6ed1dc7b Mon Sep 17 00:00:00 200=
1
=46rom: Tasslehoff Kjappfot <tasskjapp@gmail.com>
Date: Tue, 14 Jun 2011 12:06:09 +0200
Subject: [PATCH] Fix wrong OMAP_ES_x_y defines that make
omap_rev_lt_x_y and friends misbehave
---
=A0arch/arm/plat-omap/include/plat/cpu.h | =A0 =A08 ++++----
=A01 files changed, 4 insertions(+), 4 deletions(-)
diff --git a/arch/arm/plat-omap/include/plat/cpu.h
b/arch/arm/plat-omap/include/plat/cpu.h
index 7d24faa..ec63575 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -397,10 +397,10 @@ IS_OMAP_TYPE(3517, 0x3517)
=A0 * Silicon revisions
=A0 */
=A0#define OMAP_ES_1_0 0x00
-#define OMAP_ES_2_0 0x10
-#define OMAP_ES_2_1 0x20
-#define OMAP_ES_3_0 0x30
-#define OMAP_ES_3_1 0x40
+#define OMAP_ES_2_0 0x01
+#define OMAP_ES_2_1 0x02
+#define OMAP_ES_3_0 0x03
+#define OMAP_ES_3_1 0x04

=A0#define OMAP_REV_MASK 0x0000ff00
=A0#define OMAP_REV_BITS ((omap_rev() & OMAP_REV_MASK) >> 8)
--
1.7.1
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
