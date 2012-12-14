From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] OMAPDSS: reading past end of array in dispc_dump_regs()
Date: Fri, 14 Dec 2012 18:01:33 +0300
Message-ID: <20121214150133.GB15839@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:44570 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755876Ab2LNPBv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Dec 2012 10:01:51 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Archit Taneja <archit@ti.com>, Chandrabhanu Mahapatra <cmahapatra@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org

We added another kind of plane in 66a0f9e4ac "OMAPDSS: Use WB fifo for
GFX overlay" so this array needs a new entry as well.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Static checker work.  I don't have a way to test this.

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index fedbd2c..bfe62cc 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3163,6 +3163,7 @@ static void dispc_dump_regs(struct seq_file *s)
 		[OMAP_DSS_VIDEO1]	= "VID1",
 		[OMAP_DSS_VIDEO2]	= "VID2",
 		[OMAP_DSS_VIDEO3]	= "VID3",
+		[OMAP_DSS_WB]		= "WB",
 	};
 	const char **p_names;
 
