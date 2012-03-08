From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP2+: Fix build for omap4 only builds with missing
 include of linux/bug.h
Date: Thu, 8 Mar 2012 10:49:23 -0800
Message-ID: <20120308184923.GV12083@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:13292 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab2CHSt0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 13:49:26 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

=46ound few more with randconfig generated .configs:

In file included from arch/arm/mach-omap2/prm-regbits-34xx.h:17,
                 from arch/arm/mach-omap2/vc.c:18:
arch/arm/mach-omap2/prm2xxx_3xxx.h: In function =E2=80=98omap2_prm_read=
_mod_reg=E2=80=99:
arch/arm/mach-omap2/prm2xxx_3xxx.h:239: error: implicit declaration of =
function =E2=80=98WARN=E2=80=99

In file included from arch/arm/mach-omap2/powerdomain44xx.c:22:
arch/arm/mach-omap2/prm2xxx_3xxx.h: In function =E2=80=98omap2_prm_read=
_mod_reg=E2=80=99:
arch/arm/mach-omap2/prm2xxx_3xxx.h:239: error: implicit declaration of =
function =E2=80=98WARN=E2=80=99

This is because omap2_prm functions are currently just stubs for
omap4 only builds.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/powerdomain44xx.c
+++ b/arch/arm/mach-omap2/powerdomain44xx.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
+#include <linux/bug.h>
=20
 #include "powerdomain.h"
 #include <plat/prcm.h>
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/bug.h>
=20
 #include <plat/cpu.h>
=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
