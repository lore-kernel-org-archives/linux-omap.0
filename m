From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 00/12] ARM: OMAP2 DT clock conversion
Date: Fri, 28 Feb 2014 11:22:52 +0200
Message-ID: <1393579384-23440-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40316 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751240AbaB1JYO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Feb 2014 04:24:14 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Hi,

This set concludes the omap2+ clock DT conversion work by creating the
DT clock data for omap2 SoC also.

I am also currently doing related work to cleanup CM/PRM codebase in
preparation to move it into drivers/, this set is basically going to
be a pre-requisite for that. I'll hopefully post something related
to that early next week.

This set has been boot tested on OMAP2430 only (thanks Nishanth, I don't
have access to OMAP2 hardware myself), so any testing feedback on
2420 board(s) would be appreciated.

Working tree:

Tree: https://github.com/t-kristo/linux-pm.git
Branch: 3.14-rc4-omap2-dt-clks

-Tero

