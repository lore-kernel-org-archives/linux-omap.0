From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [OMAPZOOM][PATCH] DSPBRIDGE: Remove SEEK_* redefinitions
Date: Mon, 23 Feb 2009 11:53:00 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602854E3E50@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46234 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752904AbZBWRxI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 12:53:08 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1NHr1a9019617
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2009 11:53:06 -0600
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n1NHr1nA008018
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2009 11:53:01 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

=46rom: Fernando Guzman Lugo <x0095840@ti.com>
Date: Mon, 23 Feb 2009 10:04:27 -0600
Subject: [PATCH] DSPBRIDGE: Remove SEEK_* redefinitions

This patch removes the SEEK_* redefinitions in host_os.h

Signed-off-by: Guzman Lugo Fernando <x0095840@ti.com>
---
=A0arch/arm/plat-omap/include/dspbridge/host_os.h |=A0=A0=A0 6 ------
=A01 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/host_os.h b/arch/arm/=
plat-omap/include/dspbridge/host_os.h
index ff49e0d..9245eea
--- a/arch/arm/plat-omap/include/dspbridge/host_os.h
+++ b/arch/arm/plat-omap/include/dspbridge/host_os.h
@@ -60,12 +60,6 @@
=A0#include <asm/cacheflush.h>
=A0#include <linux/dma-mapping.h>
=A0
-/*=A0 ----------------------------------- Macros */
-
-#define SEEK_SET=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0 /* See=
k from beginning of file.=A0 */
-#define SEEK_CUR=A0=A0=A0=A0=A0=A0=A0 1=A0=A0=A0=A0=A0=A0=A0=A0 /* See=
k from current position.=A0 */
-#define SEEK_END=A0=A0=A0=A0=A0=A0=A0 2=A0=A0=A0=A0=A0=A0=A0=A0 /* See=
k from end of file.=A0 */
-
=A0/* TODO -- Remove, once BP defines them */
=A0#define INT_MAIL_MPU_IRQ=A0=A0=A0=A0=A0=A0=A0 26
=A0#define INT_DSP_MMU_IRQ=A0=A0=A0=A0=A0=A0=A0 28
--=20
1.5.6.4
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
