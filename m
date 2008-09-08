From: "arun c" <arunedarath@mistralsolutions.com>
Subject: [PATCH] omapfb: setting GOLCD bit for shadow registers to make effect
Date: Mon, 8 Sep 2008 05:19:32 -0400
Message-ID: <c656a4d20809080219q545ccff3v13221d2287f6de30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.189]:22353 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbYIHJTd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2008 05:19:33 -0400
Received: by ti-out-0910.google.com with SMTP id b6so855172tic.23
        for <linux-omap@vger.kernel.org>; Mon, 08 Sep 2008 02:19:32 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

A shadow register change has no direct effect on the display
configuration until the GOLCD (DISPC_CONTROL[5]) is set.

Signed-off-by: Arun C <arunedarath@mistralsolutions.com>
---
 drivers/video/omap/dispc.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index 82ba030..2e7af85 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -436,6 +436,11 @@ static inline int _setup_plane(int plane, int channel_out,

 	dispc_write_reg(ri_reg[plane], (screen_width - width) * bpp / 8 + 1);

+	/* Wait untill GOLCD bit is cleared and set it */
+	while (dispc_read_reg(DISPC_CONTROL) & (1 << 5))
+		continue;
+	MOD_REG_FLD(DISPC_CONTROL, 1 << 5, 1 << 5);
+
 	return height * screen_width * bpp / 8;
 }

-- 
1.5.3.4
