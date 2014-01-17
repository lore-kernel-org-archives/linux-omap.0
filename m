From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 0/3] ARM: OMAP: clk-next-omap emergency fixes
Date: Fri, 17 Jan 2014 22:25:37 +0200
Message-ID: <1389990340-23358-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44032 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752942AbaAQU0S (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Jan 2014 15:26:18 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, mturquette@linaro.org, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Hi,

Quick emergency band-aid for the build breakages introduced in clk-next
by Mike. I didn't have time to test this out (Nishanth will provide some
logs) and I will leave the decision whether/how to use these patches or not
to Tony + Mike.

I also pushed a test branch based on top of clk-next here:
tree: https://github.com/t-kristo/linux-pm.git
branch: clk-next-omap-fixes

-Tero

