From: "arun c" <arunedarath@mistralsolutions.com>
Subject: DISPC register values to eliminate the omapfb irq errors on 2430SDP
Date: Mon, 9 Jun 2008 13:07:32 +0530
Message-ID: <c656a4d20806090037h366eaeam9de95e74e210085e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.184]:54391 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911AbYFIHhe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jun 2008 03:37:34 -0400
Received: by ti-out-0910.google.com with SMTP id b6so532513tic.23
        for <linux-omap@vger.kernel.org>; Mon, 09 Jun 2008 00:37:32 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

FYI

By changing the gfx fifo threshold and burst size values
i could able to completely eliminate the omapfb irq
error messages on 2430 SDP board.

I am pasting the changes here for anybody
who wants to try it out.

##########################################

diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index 6aff476..4cf83b6 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -290,8 +290,8 @@ static void setup_plane_fifo(int plane, int ext_mode)
 		low = l * 3 / 4;
 		high = l;
 	} else {
-		low = l / 4;
-		high = l * 3 / 4;
+		low = l - 64;
+		high = l - 1;
 	}
 	MOD_REG_FLD(ftrs_reg[plane], FLD_MASK(16, 9) | FLD_MASK(0, 9),
 			(high << 16) | low);
@@ -409,7 +409,7 @@ static inline int _setup_plane(int plane, int channel_out,
 	l |= cconv_en << 9;

 	l &= ~(0x03 << burst_shift);
-	l |= DISPC_BURST_8x32 << burst_shift;
+	l |= DISPC_BURST_16x32 << burst_shift;

 	l &= ~(1 << chout_shift);
 	l |= chout_val << chout_shift;

###############################

Regards,
Arun C
