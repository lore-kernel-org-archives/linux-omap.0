From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: OMAP3: clockdomain: fix accidental duplicate
 registration
Date: Thu, 12 Jul 2012 04:54:49 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207120448120.25585@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39954 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933711Ab2GLKyu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Jul 2012 06:54:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Commit 3dd50d0545bd5a8ad83d4339f07935cd3e883271 ("Merge tag 
'omap-cleanup-for-v3.6' into tmp-merge") inadvertently caused a 
clockdomain to be registered twice on OMAP3 boards.  This causes warnings 
on boot, wild pointer dereferences, and PM regressions.  Fix the double 
registration and add some clockdomain code to prevent this from happening 
again.

Reported-by: Joe Woodward <jw@terrafix.co.uk>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
Intended for v3.6 merge window.  Applies on linux-omap commit 
3dd50d0545bd5a8ad83d4339f07935cd3e883271.  Boot-tested on 2430 SDP, 
3517 EVM, 37xx EVM, 5912 OSK, and CM-T 3517.

 arch/arm/mach-omap2/clockdomain.c           |   19 ++++++++++++++-----
 arch/arm/mach-omap2/clockdomain.h           |    1 +
 arch/arm/mach-omap2/clockdomains3xxx_data.c |    1 -
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 8664f5a..b851ba4 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -63,9 +63,10 @@ static struct clockdomain *_clkdm_lookup(const char *name)
  * _clkdm_register - register a clockdomain
  * @clkdm: struct clockdomain * to register
  *
- * Adds a clockdomain to the internal clockdomain list.
- * Returns -EINVAL if given a null pointer, -EEXIST if a clockdomain is
- * already registered by the provided name, or 0 upon success.
+ * Adds a clockdomain to the internal clockdomain list.  Returns
+ * -EINVAL if given a null pointer, -EEXIST if a clockdomain is
+ * already registered by the provided name or if @clkdm has already
+ * been registered, or 0 upon success.
  */
 static int _clkdm_register(struct clockdomain *clkdm)
 {
@@ -74,6 +75,11 @@ static int _clkdm_register(struct clockdomain *clkdm)
 	if (!clkdm || !clkdm->name)
 		return -EINVAL;
 
+	if (clkdm->_flags & _CLKDM_FLAG_REGISTERED) {
+		pr_err("clockdomain: %s: already registered\n", clkdm->name);
+		return -EEXIST;
+	}
+
 	pwrdm = pwrdm_lookup(clkdm->pwrdm.name);
 	if (!pwrdm) {
 		pr_err("clockdomain: %s: powerdomain %s does not exist\n",
@@ -82,15 +88,18 @@ static int _clkdm_register(struct clockdomain *clkdm)
 	}
 	clkdm->pwrdm.ptr = pwrdm;
 
-	/* Verify that the clockdomain is not already registered */
-	if (_clkdm_lookup(clkdm->name))
+	if (_clkdm_lookup(clkdm->name)) {
+		pr_err("clockdomain: %s: name already registered\n",
+		       clkdm->name);
 		return -EEXIST;
+	}
 
 	list_add(&clkdm->node, &clkdm_list);
 
 	pwrdm_add_clkdm(pwrdm, clkdm);
 
 	spin_lock_init(&clkdm->lock);
+	clkdm->_flags |= _CLKDM_FLAG_REGISTERED;
 
 	pr_debug("clockdomain: registered %s\n", clkdm->name);
 
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index 5601dc1..7b3c1d2 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -86,6 +86,7 @@ struct clkdm_dep {
 
 /* Possible flags for struct clockdomain._flags */
 #define _CLKDM_FLAG_HWSUP_ENABLED		BIT(0)
+#define _CLKDM_FLAG_REGISTERED			BIT(1)
 
 /**
  * struct clockdomain - OMAP clockdomain
diff --git a/arch/arm/mach-omap2/clockdomains3xxx_data.c b/arch/arm/mach-omap2/clockdomains3xxx_data.c
index d625844..56089c4 100644
--- a/arch/arm/mach-omap2/clockdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains3xxx_data.c
@@ -454,7 +454,6 @@ static struct clkdm_autodep clkdm_am35x_autodeps[] = {
 
 static struct clockdomain *clockdomains_common[] __initdata = {
 	&wkup_common_clkdm,
-	&mpu_3xxx_clkdm,
 	&neon_clkdm,
 	&core_l3_3xxx_clkdm,
 	&core_l4_3xxx_clkdm,
-- 
1.7.10

