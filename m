From: david.hagood@gmail.com
Subject: Benchmarking: POP flash vs. MMC?
Date: Fri, 3 Apr 2009 16:24:45 -0500 (CDT)
Message-ID: <6541c55b1b4ad133498add734c9eecc8.squirrel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.226]:1313 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754638AbZDCVYu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2009 17:24:50 -0400
Received: by rv-out-0506.google.com with SMTP id g37so437388rvb.5
        for <linux-omap@vger.kernel.org>; Fri, 03 Apr 2009 14:24:48 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by Deathwish.hagood.sktc.net (Postfix) with ESMTP id 2224BC7B8235
	for <linux-omap@vger.kernel.org>; Fri,  3 Apr 2009 16:24:45 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Has anybody done any benchmarking on POP flash read/write speeds (using
JFFS2) vs. MMC/SDHC card access (using ext[234])? Or for that matter, has
anybody done any playing around with using the execute in place function
of JFFS2 to see if there is any over-all speed advantage (due to reduced
pressure on the RAM) vs. loading into RAM?


