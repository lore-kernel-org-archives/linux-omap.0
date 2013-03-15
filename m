From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 17/50] staging: omap-thermal: add a section of register manipulation
Date: Fri, 15 Mar 2013 09:00:05 -0400
Message-ID: <1363352438-15935-18-git-send-email-eduardo.valentin@ti.com>
References: <1363352438-15935-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363352438-15935-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

This is introduces a series of marks inside the code to
better organize functions per group, aggregating their
functionality.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/omap-thermal/omap-bandgap.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/omap-thermal/omap-bandgap.c b/drivers/staging/omap-thermal/omap-bandgap.c
index fce3942..77ff495 100644
--- a/drivers/staging/omap-thermal/omap-bandgap.c
+++ b/drivers/staging/omap-thermal/omap-bandgap.c
@@ -42,6 +42,8 @@
 
 #include "omap-bandgap.h"
 
+/***   Helper functions to access registers and their bitfields   ***/
+
 /**
  * omap_bandgap_readl() - simple read helper function
  * @bg_ptr: pointer to omap_bandgap structure
-- 
1.7.7.1.488.ge8e1c
