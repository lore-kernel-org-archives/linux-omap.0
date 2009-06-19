From: Peter Barada <peterb@logicpd.com>
Subject: Missing OMAP nand drivers from 2.6.30?
Date: Fri, 19 Jun 2009 13:04:53 -0400
Message-ID: <1245431093.24284.4.camel@blitz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:15040 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751978AbZFSRC7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Jun 2009 13:02:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Looking at the current linux-omap tree from yesterday, I'm wondering
where the NAND chip driver for the OMAP34x/35x is.  It used to be in
drivers/mtd/nand/omap2.c, but there's no trace of it now (that I can
find).

Any ideas where it went?

-- 
Peter Barada <peterb@logicpd.com>
Logic Product Development, Inc.
