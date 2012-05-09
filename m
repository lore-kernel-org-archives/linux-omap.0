From: Hein Tibosch <hein_tibosch@yahoo.es>
Subject: omapfb-main.c: check result of simple_strtoul
Date: Wed, 09 May 2012 22:47:38 +0800
Message-ID: <4FAA838A.3040106@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bosmailout20.eigbox.net ([66.96.189.20]:48888 "EHLO
	bosmailout20.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759775Ab2EIP2w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 11:28:52 -0400
Received: from bosmailscan06.eigbox.net ([10.20.15.6])
	by bosmailout20.eigbox.net with esmtp (Exim)
	id 1SS8BI-0004c2-OP
	for linux-omap@vger.kernel.org; Wed, 09 May 2012 10:47:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Tomi,


In drivers/video/omap2/omapfb/omapfb-main.c:

 static int omapfb_parse_vram_param(const char *param, int max_entries,
 		unsigned long *sizes, unsigned long *paddrs)
 {
 	int fbnum;
 	unsigned long size;
 	unsigned long paddr = 0;
 	char *p, *start;
  	start = (char *)param;
 	while (1) {
 		p = start;
  		fbnum = simple_strtoul(p, &p, 10);
-		if (p == param)
+		if (p == start)

correct?

Hein

