From: Jonathan McDowell <noodles@earth.li>
Subject: [PATCH] Fix omap-gpio warnings when compiling for ARCH_OMAP15XX
Date: Tue, 11 Nov 2008 22:53:48 +0000
Message-ID: <20081111225348.GZ3162@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from the.earth.li ([217.147.81.2]:45578 "EHLO the.earth.li"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752111AbYKKXnN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Nov 2008 18:43:13 -0500
Received: from noodles by the.earth.li with local (Exim 4.63)
	(envelope-from <noodles@earth.li>)
	id 1L027I-0003O9-Fh
	for linux-omap@vger.kernel.org; Tue, 11 Nov 2008 22:53:48 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

When compiling for ARCH_OMAP15XX I get the following compiler warning i=
n
gpio.c:

arch/arm/plat-omap/gpio.c: In function =E2=80=98_set_gpio_wakeup=E2=80=99=
:
arch/arm/plat-omap/gpio.c:848: warning: unused variable =E2=80=98flags=E2=
=80=99

Simple patch below fixes this.

Signed-off-by: Jonathan McDowell <noodles@earth.li>

-----
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 8bb4542..bfbe366 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -845,7 +845,10 @@ static inline void _set_gpio_irqenable(struct gpio=
_bank *bank, int gpio, int ena
  */
 static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enab=
le)
 {
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) || =
\
+		defined(CONFIG_ARCH_OMAP34XX)
 	unsigned long flags;
+#endif
=20
 	switch (bank->method) {
 #ifdef CONFIG_ARCH_OMAP16XX
-----

J.

--=20
Web [   Asking whether machines can think is like asking whether   ]
site: http:// [           submarines can swim.           ]       Made b=
y
www.earth.li/~noodles/  [                      ]         HuggieTag 0.0.=
23
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
