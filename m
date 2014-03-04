From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 00/18] ARM: OMAP2+: CM/PRM cleanup set
Date: Tue, 4 Mar 2014 18:19:00 +0200
Message-ID: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48402 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275AbaCDQUG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Mar 2014 11:20:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, khilman@linaro.org
Cc: linux-arm-kernel@lists.infradead.org

Hi,

This set cleans up the CM/PRM codebase a bit, removing the need for direct
CM/PRM register access macros outside CM/PRM drivers. This is done in
preparation to isolate these drivers into its own driver directory.
Currently my plan is to create a single PRCM driver, which will contain
both, and as such, CM/PRM inter-access is not removed in this set.

This set is built on top of the OMAP2 DT clock conversion set, but most
of the patches can also be standalone if need be.

Testing done:
- omap2 : none (any feedback welcome)
- omap3-beagle : boot, suspend-resume (RET), suspend-resume (OFF)
- omap4-panda-es : boot, suspend-resume (RET)

Branch also available here:
tree: https://github.com/t-kristo/linux-pm.git
branch: 3.14-rc4-cm-prm-cleanup

-Tero

