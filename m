From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Fwd: Re: Broken builds
Date: Wed, 13 Jun 2012 10:57:53 +0100
Message-ID: <20120613095753.GA32099@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55437 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730Ab2FMJ6A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jun 2012 05:58:00 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Linus,

Can you please apply the patch below.  I've been waiting 10 days so far
for a fix for the build problem to get through the "normal" channels,
and it seems to be stuck with the FBdev maintainer, who "missed -rc2"
with his pull request - and still hasn't submitted it.

Tomi Valkeinen has a different fix to this, which is the one stuck in
the fbdev maintainers tree.

I'm fed up with waiting for this build breakage to get fixed, and to
think how badly I get flamed if I do something even sneeze wrongly in
the direction of any x86 code...

----- Forwarded message from Tony Lindgren <tony@atomide.com> -----

Date: Tue, 5 Jun 2012 01:22:18 -0700
From: Tony Lindgren <tony@atomide.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Broken builds
Delivery-date: Tue, 05 Jun 2012 09:22:25 +0100

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

----- End forwarded message -----
