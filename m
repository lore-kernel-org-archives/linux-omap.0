From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH] staging: tidspbridge: Fix build breakage due to splitting CM functions.
Date: Wed, 19 Dec 2012 10:48:46 +0100
Message-ID: <1355910526-29691-1-git-send-email-eballetbo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35154 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072Ab2LSJs5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Dec 2012 04:48:57 -0500
Received: by mail-wi0-f172.google.com with SMTP id o1so3351065wic.17
        for <linux-omap@vger.kernel.org>; Wed, 19 Dec 2012 01:48:56 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, javier.martinez@collabora.co.uk, omar.ramirez@ti.com, gregkh@linuxfoundation.org, tony@atomide.com
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>

=46rom: Enric Balletbo i Serra <eballetbo@iseebcn.com>

Commit ff4ae5d (ARM: OMAP2+: CM/hwmod: split CM functions into OMAP2, O=
MAP3-specific files)
resulted in a build breakage for tidspbridge driver.

   ...
   CC [M]  drivers/staging/tidspbridge/core/tiomap3430.o
   staging/tidspbridge/core/tiomap3430.c: In function =E2=80=98bridge_b=
rd_start=E2=80=99:
   staging/tidspbridge/core/tiomap3430.c:550:24: error: =E2=80=98OMAP34=
30_CM_AUTOIDLE_PLL=E2=80=99
     undeclared (first use in this function)
   make[3]: *** [drivers/staging/tidspbridge/core/tiomap3430.o] Error 1
   ...

=46ix this by including the appropriate header file.

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
---
 drivers/staging/tidspbridge/core/_tiomap.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/tidspbridge/core/_tiomap.h b/drivers/stagi=
ng/tidspbridge/core/_tiomap.h
index 543a127..b783bfa 100644
--- a/drivers/staging/tidspbridge/core/_tiomap.h
+++ b/drivers/staging/tidspbridge/core/_tiomap.h
@@ -31,7 +31,7 @@
  * driver should read or write to PRM/CM registers directly; they
  * should rely on OMAP core code to do this.
  */
-#include <mach-omap2/cm2xxx_3xxx.h>
+#include <mach-omap2/cm3xxx.h>
 #include <mach-omap2/prm-regbits-34xx.h>
 #include <mach-omap2/cm-regbits-34xx.h>
 #include <dspbridge/devdefs.h>
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
