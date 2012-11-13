From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 1/5] staging: omap-thermal: fix compilation
Date: Tue, 13 Nov 2012 11:43:18 -0400
Message-ID: <1352821402-13458-2-git-send-email-eduardo.valentin@ti.com>
References: <1352821402-13458-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352821402-13458-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: b-cousson@ti.com, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

Because we are not including asm/io.h, the driver is not compiling.
This patch adds the missing header.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/omap-thermal/omap-bandgap.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/omap-thermal/omap-bandgap.c b/drivers/staging/omap-thermal/omap-bandgap.c
index 368a2e1..1cae5ed 100644
--- a/drivers/staging/omap-thermal/omap-bandgap.c
+++ b/drivers/staging/omap-thermal/omap-bandgap.c
@@ -38,6 +38,7 @@
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
 #include <linux/of_irq.h>
+#include <linux/io.h>
 
 #include "omap-bandgap.h"
 
-- 
1.7.7.1.488.ge8e1c
