From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 00/13] ARM: OMAP2+: clock cleanup series for 3.17
Date: Wed, 2 Jul 2014 11:47:34 +0300
Message-ID: <1404290867-6768-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38794 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750982AbaGBIrw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Jul 2014 04:47:52 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org

Hi,

This sets cleans up some of the omap specific clock drivers still residing
under arch/arm/mach-omap2. This set is done in preparation to migrate
these drivers eventually under drivers/clk/ti, where we don't have access
to certain board specific functionality. The basic idea of this set is to
introduce clk_features struct which contains any SoC specific data / flags
within it, and this is used runtime instead of the current cpu_is_? checks.

There are also a couple of bug fixes introduced in this set:
- Patch #1 : fix potential overflow in _dpll_test_fint
- Patch #8 : embeds a fix for checking omap5/dra7 for the bypass modes also

Set tested on following boards:

- omap2430-sdp : boot
- omap3-beagle : boot / suspend
- omap4-panda-es : boot / suspend
- omap5-uevm : boot
- dra7-evm : boot

Branch also available:

tree: https://github.com/t-kristo/linux-pm.git
branch: for-v3.17/omap2-clk-cleanup

-Tero

