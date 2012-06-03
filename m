From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Broken builds
Date: Sun, 3 Jun 2012 19:01:22 +0100
Message-ID: <20120603180122.GA23368@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50018 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753204Ab2FCSB1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 3 Jun 2012 14:01:27 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Looks like the DSS stuff has broken OMAP builds again during this
merge window:

drivers/video/omap2/dss/core.c:197: error: static declaration of 'dss_debugfs_create_file' follows non-static declaration
drivers/video/omap2/dss/dss.h:166: error: previous declaration of 'dss_debugfs_create_file' was here

Both the OMAP3 and OMAP4 builds break with these two errors.
