From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 18/50] staging: omap-thermal: section of basic helpers
Date: Fri, 15 Mar 2013 09:00:06 -0400
Message-ID: <1363352438-15935-19-git-send-email-eduardo.valentin@ti.com>
References: <1363352438-15935-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363352438-15935-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

Group of simple functions aggregating basic functionality.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/omap-thermal/omap-bandgap.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/omap-thermal/omap-bandgap.c b/drivers/staging/omap-thermal/omap-bandgap.c
index 77ff495..7927c59 100644
--- a/drivers/staging/omap-thermal/omap-bandgap.c
+++ b/drivers/staging/omap-thermal/omap-bandgap.c
@@ -88,6 +88,8 @@ do {								\
 	omap_bandgap_writel(bg_ptr, r, t->reg);			\
 } while (0)
 
+/***   Basic helper functions   ***/
+
 /**
  * omap_bandgap_power() - controls the power state of a bandgap device
  * @bg_ptr: pointer to omap_bandgap structure
-- 
1.7.7.1.488.ge8e1c
