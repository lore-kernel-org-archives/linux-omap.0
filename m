From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: OMAP4/Panda: u-boot upgrade v2012.04.01 -> v2012.10 breaks RTC wakeups
Date: Tue, 06 Nov 2012 16:46:58 -0800
Message-ID: <87obja9r3x.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61200 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428Ab2KGArA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 19:47:00 -0500
Received: by mail-pb0-f46.google.com with SMTP id rr4so794390pbb.19
        for <linux-omap@vger.kernel.org>; Tue, 06 Nov 2012 16:47:00 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: u-boot@lists.denx.de
Cc: linux-omap <linux-omap@vger.kernel.org>, trini@ti.com

Hello,

I just noticed that the kernel wakeup from suspend using RTC is broken
after I upgraded u-boot from v2012.04.01 to v2012.10 on my
OMAP4430/Panda and OMAP4460/Panda-ES.

I haven't isolated the cause yet, but am hoping someone might have a
pointer about where to start digging.

Kevin
