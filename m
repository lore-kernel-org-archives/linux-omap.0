From: Tony Lindgren <tony@atomide.com>
Subject: [APPLIED] [CBUS PATCH 2/2] cbus: switch kmalloc() + memset() to kzalloc()
Date: Mon, 3 May 2010 21:19:14 -0400
Message-ID: <notify-1272935955@atomide.com>
References: <1272736870-5216-2-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59980 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008Ab0EDBTO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 21:19:14 -0400
Received: from c-67-160-239-110.hsd1.ca.comcast.net ([67.160.239.110] helo=localhost.localdomain)
	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1O96n3-0009Fw-JA
	for linux-omap@vger.kernel.org; Tue, 04 May 2010 01:19:13 +0000
In-Reply-To: <1272736870-5216-2-git-send-email-felipe.balbi@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch has been applied to the linux-omap
by youw fwiendly patch wobot.

Branch in linux-omap: cbus

Initial commit ID (Likely to change): 749c6d8eaac8cd49b3d53eb7fb708ce61787a3a1

PatchWorks
http://patchwork.kernel.org/patch/96299/

Git (Likely to change, and takes a while to get mirrored)
http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=749c6d8eaac8cd49b3d53eb7fb708ce61787a3a1


