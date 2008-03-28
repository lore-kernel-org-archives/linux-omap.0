From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] Add sram34xx.S
Date: Fri, 28 Mar 2008 13:46:35 +0200
Message-ID: <1206704800-6768-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64330 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753349AbYC1Lqm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Mar 2008 07:46:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "Dasu, Karthik P" <karthik-dp@ti.com>, Tony Lindgren <tony@atomide.com>

Hi all,

Following two patches add sram34xx.S based on Karthik's patch and what's
at [1]. Looks like the sram code in [1] is newer so I've used that.
Let me know if that's not the case.

Karthik, can you please check and ack? I've only compile tested them.

Regards,

Tony

[1] http://linux.omap.com/pub/kernel/3430zoom/linux-ldp-v1.0b.tar.gz
