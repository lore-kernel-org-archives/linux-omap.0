From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 0/5] ARM: OMAP3+: DPLL: fix set_rate logic
Date: Fri, 3 Oct 2014 16:57:09 +0300
Message-ID: <1412344634-2798-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41228 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752022AbaJCN5v (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Oct 2014 09:57:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, mturquette@linaro.org, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Hi,

OMAP3+ DPLL code is currently using set_rate op to change DPLL rates.
This is kind of wrong, as it also involves changing DPLL parent in certain
cases (switch between locked mode <-> bypass mode.) This set fixes these
issues by introducing the support of determine_rate and set_rate_and_parent
ops for the DPLL clocks. Also introduces support for set_parent, which
just switches a DPLL between locked <-> bypass modes.

Testing branch pushed at my tree: https://github.com/t-kristo/linux-pm.git
branch: 3.17-rc1-dpll-fixes

Testing done:
- omap2430-sdp : boot
- am335x-bone : boot
- am43xx-gpevm : boot
- dra7-evm : boot
- omap5-uevm : boot
- omap4-panda-es : boot
- omap3-beagle : boot
- omap3-beagle-xm : boot

-Tero

