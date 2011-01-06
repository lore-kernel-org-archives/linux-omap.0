From: Charles Manning <cdhmanning@gmail.com>
Subject: [PATCH 0/2] Add optional mtd nand alignment for subpage reading
Date: Thu,  6 Jan 2011 14:39:00 +1300
Message-ID: <1294277942-1252-1-git-send-email-cdhmanning@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:55893 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906Ab1AFBjQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 20:39:16 -0500
Received: by pwj3 with SMTP id 3so2112405pwj.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Jan 2011 17:39:16 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Charles Manning <cdhmanning@gmail.com>

Subpage reading already provides a certain degree of alignment in that it
aligns the reads to 16-bits if the bus is 16-bits wide.

For some situations this is not enough. For eample, the OMAP2 prefetch
engine only works with u32 aligned buffers and read sizes.

This patch set adds a mechanism to plug in an alignment function and
provides an example using the omap2 nand driver.

Comments welcome

-- Charles
