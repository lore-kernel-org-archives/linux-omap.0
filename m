From: Ilya Yanok <yanok@emcraft.com>
Subject: Problems booting recent kernels on AM3517
Date: Mon, 19 Dec 2011 04:10:06 +0400
Message-ID: <4EEE80DE.8040001@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ocean.emcraft.com ([213.221.7.182]:51467 "EHLO
	ocean.emcraft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab1LSAJe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 18 Dec 2011 19:09:34 -0500
Received: from localhost ([127.0.0.1] helo=[IPv6:::1])
	by ocean.emcraft.com with esmtp (Exim 4.76)
	(envelope-from <yanok@emcraft.com>)
	id 1RcQnM-0002sl-9g
	for linux-omap@vger.kernel.org; Mon, 19 Dec 2011 04:09:32 +0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi All,

I've just rebased my patches on the top of current linux-omap tree and
found my AM3517 unbootable: omap3_pm_idle is called and then the system
hangs.

I can see some patches to support pm_idle on AM3517 so I assume that the
current code can't work on my systems properly.

What is the right way to make my systems boot again?

(I've tried to disable PM_RUNTIME but that results in crash somewhere
inside DSS driver.)

Regards, Ilya.
