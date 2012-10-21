From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] OMAPDSS: HDMI: fix missing unlock on error in hdmi_dump_regs()
Date: Sun, 21 Oct 2012 20:54:26 +0800
Message-ID: <CAPgLHd--5Y4cq3ieoRSueg-i0boqRa4JqRPL7+cJ0UfesunjoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:61733 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753563Ab2JUMy1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 21 Oct 2012 08:54:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, FlorianSchandinat@gmx.de
Cc: yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add the missing unlock on the error handling path in function
hdmi_dump_regs().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
no test
---
 drivers/video/omap2/dss/hdmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index a48a7dd..8c9b8b3 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -644,8 +644,10 @@ static void hdmi_dump_regs(struct seq_file *s)
 {
 	mutex_lock(&hdmi.lock);
 
-	if (hdmi_runtime_get())
+	if (hdmi_runtime_get()) {
+		mutex_unlock(&hdmi.lock);
 		return;
+	}
 
 	hdmi.ip_data.ops->dump_wrapper(&hdmi.ip_data, s);
 	hdmi.ip_data.ops->dump_pll(&hdmi.ip_data, s);


