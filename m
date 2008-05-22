From: Tony Lindgren <tony@atomide.com>
Subject: Recent DMA changes broke omap1, CDAC broken on 3430
Date: Wed, 21 May 2008 18:00:55 -0700
Message-ID: <20080522010051.GH23002@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62170 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760775AbYEVBAw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 May 2008 21:00:52 -0400
Received: from c-69-181-40-92.hsd1.ca.comcast.net ([69.181.40.92] helo=localhost.localdomain)
	by mho-01-bos.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1JyzAp-000ILL-4E
	for linux-omap@vger.kernel.org; Thu, 22 May 2008 01:00:51 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

Turns out my recent DMA changes broke omap1 dma to some extent.
I've pushed a fix for that, and also a fix for old alsa code,
and a compile fix for H4.

I also fixed omap_get_dma_src/dst_pos() to return the current
address. So if there are still some old drivers (wrongly) assuming
this function returns the transfer count, they're even more broken
now. Please everybody check your drivers for that.

It also seems that omap3430sdp ES2.0 returns 0 for CDAC address.
This means omap_get_dma_dst_pos() will always return 0, which
may break some drivers..

I have no idea why CDAC is 0 on 3430, there's something in TRM in
"9.5.4 Synchronized Transfer Monitoring Using CDAC" about setting
CDAC, but so far no luck. Maybe this only works for hardware triggered
transfers?

If anybody has ideas why CDAC is not behaving let me know!

Cheers,

Tony
