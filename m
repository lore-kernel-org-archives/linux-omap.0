From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 16/19] ARM: OMAP4 clock domain: Add check for avoiding
	dependency related update.
Date: Mon, 15 Feb 2010 18:25:00 -0700
Message-ID: <20100216012459.1101.19902.stgit@localhost.localdomain>
References: <20100216011942.1101.14348.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57443 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932501Ab0BPB1A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Feb 2010 20:27:00 -0500
In-Reply-To: <20100216011942.1101.14348.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Abhijit Pagare <abhijitpagare@ti.com>

=46rom: Abhijit Pagare <abhijitpagare@ti.com>

A check is added for avoiding the sleep/wakeup dependency updates
for OMAP4 as the structures for the dependencies are currently absent.

Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
[paul@pwsan.com: added warnings, explanatory comment, copyright update]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clockdomain.c |   30 ++++++++++++++++++++++++-----=
-
 1 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/cl=
ockdomain.c
index a38a615..de4278c 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -1,8 +1,8 @@
 /*
  * OMAP2/3/4 clockdomain framework functions
  *
- * Copyright (C) 2008-2009 Texas Instruments, Inc.
- * Copyright (C) 2008-2009 Nokia Corporation
+ * Copyright (C) 2008-2010 Texas Instruments, Inc.
+ * Copyright (C) 2008-2010 Nokia Corporation
  *
  * Written by Paul Walmsley and Jouni H=C3=B6gander
  * Added OMAP4 specific support by Abhijit Pagare <abhijitpagare@ti.co=
m>
@@ -891,8 +891,17 @@ void omap2_clkdm_allow_idle(struct clockdomain *cl=
kdm)
 	pr_debug("clockdomain: enabling automatic idle transitions for %s\n",
 		 clkdm->name);
=20
-	if (atomic_read(&clkdm->usecount) > 0)
-		_clkdm_add_autodeps(clkdm);
+	/*
+	 * XXX This should be removed once TI adds wakeup/sleep
+	 * dependency code and data for OMAP4.
+	 */
+	if (cpu_is_omap44xx()) {
+		WARN_ONCE(1, "clockdomain: OMAP4 wakeup/sleep dependency "
+			  "support is not yet implemented\n");
+	} else {
+		if (atomic_read(&clkdm->usecount) > 0)
+			_clkdm_add_autodeps(clkdm);
+	}
=20
 	_omap2_clkdm_set_hwsup(clkdm, 1);
=20
@@ -924,8 +933,17 @@ void omap2_clkdm_deny_idle(struct clockdomain *clk=
dm)
=20
 	_omap2_clkdm_set_hwsup(clkdm, 0);
=20
-	if (atomic_read(&clkdm->usecount) > 0)
-		_clkdm_del_autodeps(clkdm);
+	/*
+	 * XXX This should be removed once TI adds wakeup/sleep
+	 * dependency code and data for OMAP4.
+	 */
+	if (cpu_is_omap44xx()) {
+		WARN_ONCE(1, "clockdomain: OMAP4 wakeup/sleep dependency "
+			  "support is not yet implemented\n");
+	} else {
+		if (atomic_read(&clkdm->usecount) > 0)
+			_clkdm_del_autodeps(clkdm);
+	}
 }
=20
=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
