From: Tony Lindgren <tony@atomide.com>
Subject: Re: Broken builds
Date: Tue, 5 Jun 2012 01:22:18 -0700
Message-ID: <20120605082218.GL12766@atomide.com>
References: <20120603180122.GA23368@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:28469 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756291Ab2FEIWV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jun 2012 04:22:21 -0400
Content-Disposition: inline
In-Reply-To: <20120603180122.GA23368@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120603 11:05]:
> Looks like the DSS stuff has broken OMAP builds again during this
> merge window:
> 
> drivers/video/omap2/dss/core.c:197: error: static declaration of 'dss_debugfs_create_file' follows non-static declaration
> drivers/video/omap2/dss/dss.h:166: error: previous declaration of 'dss_debugfs_create_file' was here
> 
> Both the OMAP3 and OMAP4 builds break with these two errors.

Here's a patch for Tomi to fix this one.

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Tue, 5 Jun 2012 01:20:55 -0700
Subject: [PATCH] OMAPDSS: Fix compile for dss_debugfs_create_file

Otherwise we get:

drivers/video/omap2/dss/core.c:197: error: static declaration of
'dss_debugfs_create_file' follows non-static declaration
drivers/video/omap2/dss/dss.h:166: error: previous declaration of
'dss_debugfs_create_file' was here

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -194,7 +194,7 @@ static inline int dss_initialize_debugfs(void)
 static inline void dss_uninitialize_debugfs(void)
 {
 }
-static inline int dss_debugfs_create_file(const char *name,
+int dss_debugfs_create_file(const char *name,
 		void (*write)(struct seq_file *))
 {
 	return 0;
