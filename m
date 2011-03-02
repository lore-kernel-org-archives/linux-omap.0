From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [RFC 0/3] omap3+: sr: Minor fix and cleanups
Date: Wed,  2 Mar 2011 17:57:22 +0200
Message-ID: <1299081445-27938-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59934 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754327Ab1CBP4P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 10:56:15 -0500
Received: by eyx24 with SMTP id 24so22036eyx.19
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 07:56:14 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>, Nishanth Menon <nm@ti.com>

Hi

I found a minor issue from smartreflex that it allows to enable multiple times
smartreflex class driver from userspace. Then two cleanups.

Nishant: I think this will conflict with your class 1.5 set. I think my
1/3 is worth to fix now and for 2-3/3 I don't have any particular priority.
I can rebase them on top of yours, you could take them with your set etc.

-- 
Jarkko
