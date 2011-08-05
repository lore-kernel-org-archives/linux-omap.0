From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 0/5] OMAP: DSS2: Miscellaneous DISPC Patches
Date: Fri, 5 Aug 2011 19:05:59 +0530
Message-ID: <1312551364-4828-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59261 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756402Ab1HEN10 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Aug 2011 09:27:26 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p75DRPrq025600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 5 Aug 2011 08:27:25 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id p75DRPME027293
	for <linux-omap@vger.kernel.org>; Fri, 5 Aug 2011 08:27:25 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p75DRPsh022504
	for <linux-omap@vger.kernel.org>; Fri, 5 Aug 2011 08:27:25 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Reduce the size of the large functions dispc_dump_regs(), dispc_save_context()
and dispc_restore_context() and _dispc_setup_color_conv_coef().

Make fifo_size array length in dispc.c generic.

Applies over master branch of:

git://gitorious.org/linux-omap-dss2/linux.git

changes in v2:
- Remove "OMAP4: DSS2: VIDEO3 pipeline support", replace it with a patch which
makes fifo_size array length in dispc.c generic. VIDEO3 is removed because it
has some functional dependencies with Zorder. So they should be posted together.

Archit Taneja (5):
  OMAP: DSS2: DISPC: Prepare dispc_dump_regs() for shortening
  OMAP: DSS2: DISPC: Shorten dispc_dump_regs()
  OMAP: DSS2: DISPC: dispc_save_context() and dispc_restore_context()
    cleanup
  OMAP: DSS2: DISPC: Shorten _dispc_set_color_conv_coef()
  OMAP: DSS2: Use a macro to declare size of the fifo_size array in
    dispc.c

 drivers/video/omap2/dss/dispc.c |  788 +++++++++++++--------------------------
 1 files changed, 265 insertions(+), 523 deletions(-)

