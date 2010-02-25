From: Sriramakrishnan <srk@ti.com>
Subject: [PATCH] PCA953x : Fix compilation warning.
Date: Thu, 25 Feb 2010 19:02:38 +0530
Message-ID: <1267104758-32131-1-git-send-email-srk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50404 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932550Ab0BYNcn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Feb 2010 08:32:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Sriramakrishnan <srk@ti.com>

The platform data structure defined in pca953x header file
includes references to i2c data structures. Unless the i2c.h
file is included ahead of pca953x.h, compiler warning would
be generated wherever pca953x header file is included. Added
i2c.h to the pca953x.h itself to remove this dependency.

Also included conditional compile macros to guard against
multiple inclusion.

Signed-off-by: Sriramakrishnan <srk@ti.com>
---
 include/linux/i2c/pca953x.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/linux/i2c/pca953x.h b/include/linux/i2c/pca953x.h
index 81736d6..1284a2d 100644
--- a/include/linux/i2c/pca953x.h
+++ b/include/linux/i2c/pca953x.h
@@ -1,3 +1,8 @@
+#ifndef __LINUX_PCA953X_H
+#define __LINUX_PCA953X_H
+
+#include <linux/i2c.h>
+
 /* platform data for the PCA9539 16-bit I/O expander driver */
 
 struct pca953x_platform_data {
@@ -17,3 +22,4 @@ struct pca953x_platform_data {
 				void *context);
 	char		**names;
 };
+#endif
-- 
1.6.2.4

