From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 21/22] OMAP powerdomain, hwmod, omap_device: add some credits
Date: Tue, 18 May 2010 20:19:02 -0600
Message-ID: <20100519021901.19716.23150.stgit@localhost.localdomain>
References: <20100519021800.19716.8938.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39835 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756066Ab0ESCVF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 22:21:05 -0400
In-Reply-To: <20100519021800.19716.8938.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tero Kristo <tero.kristo@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Thara Gopinath <thara@ti.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Add some missing credits for people who have contributed significant fe=
atures
or fixes.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Cc: Tero Kristo <tero.kristo@nokia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c  |   10 +++++-----
 arch/arm/mach-omap2/powerdomain.c |    2 +-
 arch/arm/plat-omap/omap_device.c  |    4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index 2fff39f..0a563a6 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2,12 +2,12 @@
  * omap_hwmod implementation for OMAP2/3/4
  *
  * Copyright (C) 2009 Nokia Corporation
- * Paul Walmsley
- * With fixes and testing from Kevin Hilman
  *
- * Created in collaboration with (alphabetical order): Benoit Cousson,
- * Kevin Hilman, Tony Lindgren, Rajendra Nayak, Vikram Pandita, Sakari
- * Poussa, Anand Sawant, Santosh Shilimkar, Richard Woodruff
+ * Paul Walmsley, Beno=C3=AEt Cousson, Kevin Hilman
+ *
+ * Created in collaboration with (alphabetical order): Thara Gopinath,
+ * Tony Lindgren, Rajendra Nayak, Vikram Pandita, Sakari Poussa, Anand
+ * Sawant, Santosh Shilimkar, Richard Woodruff
  *
  * This program is free software; you can redistribute it and/or modif=
y
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/po=
werdomain.c
index f9f0bca..a2904aa 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -5,8 +5,8 @@
  * Copyright (C) 2007-2009 Nokia Corporation
  *
  * Written by Paul Walmsley
- *
  * Added OMAP4 specific support by Abhijit Pagare <abhijitpagare@ti.co=
m>
+ * State counting code by Tero Kristo <tero.kristo@nokia.com>
  *
  * This program is free software; you can redistribute it and/or modif=
y
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap=
_device.c
index 0f51974..f899603 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -2,10 +2,10 @@
  * omap_device implementation
  *
  * Copyright (C) 2009 Nokia Corporation
- * Paul Walmsley
+ * Paul Walmsley, Kevin Hilman
  *
  * Developed in collaboration with (alphabetical order): Benoit
- * Cousson, Kevin Hilman, Tony Lindgren, Rajendra Nayak, Vikram
+ * Cousson, Thara Gopinath, Tony Lindgren, Rajendra Nayak, Vikram
  * Pandita, Sakari Poussa, Anand Sawant, Santosh Shilimkar, Richard
  * Woodruff
  *


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
