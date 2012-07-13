From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 0/8] ARM: OMAP: pm: usecounting changes
Date: Fri, 13 Jul 2012 17:19:37 +0300
Message-ID: <1342189185-5306-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48325 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161914Ab2GMOUo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jul 2012 10:20:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Hi,

Changes compared to previous version:

- added kerneldoc comments to new API functions
- added autoidle flagging support for omap3 dplls
- modified the clkdm code tweak required to fix omap3 per domain problems
 * moved implementation to _clkdm_del_autodeps
 * renamed the CLKDM_SKIP_MANUAL_TRANS to CLKDM_NO_AUTODEP_DISABLE
 * modified comments accordingly
- ported for 3.5-rc6

- tested with omap3 beagle board, both ret / off + suspend / cpuidle

- functional branch available at:
  git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
  branch: mainline-3.5-rc6-pwrdm-changes-v4

-Tero

