From: Felipe Balbi <me@felipebalbi.com>
Subject: ohci patches sitting in linux-omap only
Date: Thu, 19 Feb 2009 23:42:32 +0200
Message-ID: <20090219214231.GM20723@frodo>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:39789 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754241AbZBSVmi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Feb 2009 16:42:38 -0500
Received: from [91.154.126.168] (port=28375 helo=frodo)
	by serv01.siteground211.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <me@felipebalbi.com>)
	id 1LaGfD-0008Kz-En
	for linux-omap@vger.kernel.org; Thu, 19 Feb 2009 15:42:35 -0600
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi Tony, all,

if you don't have any objections, I'll send the following patches to
linux-usb as soon as possible, they've being sitting in linux-omap only
for a while already (they're all to ohci-omap.c):

David Brownell (1):
      ARM: OMAP: switch to gpio_direction_input

Jarkko Nikula (1):
      ARM: OMAP: Switch ohci-omap to gpio_request/free calls

Russell King (2):
      [ARM] omap: convert OMAP drivers to use ioremap()
      [ARM] omap: ensure OMAP drivers pass a struct device to clk_get()

Tony Lindgren (1):
      USB: ohci-omap: handle other omap15xx chips

-- 
balbi
