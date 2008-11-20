From: Peter Barada <peter@the-baradas.com>
Subject: Question regarding OMAP NAND driver read_buf16() function
Date: Thu, 20 Nov 2008 14:13:05 -0500
Message-ID: <1227208386.27896.239.camel@blackhole>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from h-66-166-225-55.cmbrmaor.covad.net ([66.166.225.55]:61727 "EHLO
	baradas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753859AbYKTTgW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Nov 2008 14:36:22 -0500
Received: from [192.168.3.4] (blackhole [192.168.3.4])
	by baradas.org (Postfix) with ESMTP id 2EF4798BA0
	for <linux-omap@vger.kernel.org>; Thu, 20 Nov 2008 14:13:06 -0500 (EST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


In drivers/mtd/nand/omap2.c, I see the call to __raw_readsl:

	__raw_readsl(nand->IO_ADDR_R, buf, len / 2);

Since len is in bytes (from the comment), shouldn't this either be:

	__raw_readsl(nand->IO_ADDR_R, buf, len / 4);

or:

	__raw_readsw(nand->IO_ADDR_R, buf, len / 2);
	
-- 
Peter Barada // senior software engineer
 
LOGIC // embedded product solutions
411 Washington Ave. N. Suite 400
Minneapolis, MN 55401
M // 617.513.5874
 
Peter.Barada@logicpd.com
www.logicpd.com

