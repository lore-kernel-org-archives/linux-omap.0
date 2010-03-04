From: "stanley.miao" <stanley.miao@windriver.com>
Subject: vdds_dsi doesn't exist on all omap3430 arch chip
Date: Thu, 04 Mar 2010 18:29:10 +0800
Message-ID: <4B8F8B76.9050807@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:55671 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442Ab0CDKWV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Mar 2010 05:22:21 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi, Tomi,

The commit below:
http://www.gitorious.org/linux-omap-dss2/linux/commit/ec70668fa99b2dd0d305fbdb451a728f2e2a4c58
doesn't apply to ti_omap_am3517. There is no "vdds_dsi" on am3517.

Stanley.

