From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/6] OMAPDSS: remove unnecessary plat/clock.h includes
Date: Thu, 27 Sep 2012 10:33:30 -0600
Message-ID: <20120927163329.21755.34776.stgit@dusk.lan>
References: <20120927162800.21755.62891.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:46746 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270Ab2I0Qfz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Sep 2012 12:35:55 -0400
In-Reply-To: <20120927162800.21755.62891.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The OMAP DSS video drivers include <plat/clock.h> but don't use any
information from that file.  These includes are causing problems with
ARM single image kernels - remove them.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    1 -
 drivers/video/omap2/dss/dsi.c   |    1 -
 drivers/video/omap2/dss/dss.c   |    1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index ee9e296..17fcb94 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -38,7 +38,6 @@
 #include <linux/pm_runtime.h>
 
 #include <plat/cpu.h>
-#include <plat/clock.h>
 
 #include <video/omapdss.h>
 
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index b07e886..bf7a080 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -41,7 +41,6 @@
 
 #include <video/omapdss.h>
 #include <video/mipi_display.h>
-#include <plat/clock.h>
 
 #include "dss.h"
 #include "dss_features.h"
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 04b4586..1dfef0e 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -35,7 +35,6 @@
 #include <video/omapdss.h>
 
 #include <plat/cpu.h>
-#include <plat/clock.h>
 
 #include "dss.h"
 #include "dss_features.h"


