From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 00/11]: ARM: OMAP: PM usecounting changes
Date: Tue, 25 Sep 2012 19:05:31 +0300
Message-ID: <1348589142-11983-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57676 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754277Ab2IYQFz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Sep 2012 12:05:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Hi,

Changes compared to previous version:

- Added patch #1 for fixing a potential race condition within clockdomain
  code
- Fixed patch #3 (old patch #2) regarding a similar race condition within
  the voltagedomain code

Tested with OMAP3 beagle, OMAP4460 GP panda, OMAP4430 EMU blaze devices.

Branch available:

git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
branch: mainline-3.6-rc5-pwrdm-changes-v6

-Tero

