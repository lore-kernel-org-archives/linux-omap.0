From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH/RFT 0/2] fixes for broken PM init with multi-OMAP
Date: Tue,  9 Mar 2010 09:03:59 -0800
Message-ID: <1268154241-24788-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:36356 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755106Ab0CIREJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Mar 2010 12:04:09 -0500
Received: by fxm5 with SMTP id 5so1524568fxm.29
        for <linux-omap@vger.kernel.org>; Tue, 09 Mar 2010 09:04:06 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

multi-OMAP builds are broken in various ways due to conditional code.
Here is a small series of fixes.

Build tested: omap3_defconfig, omap_4430sdp_defconfig
Boot tested: omap3_defconfig on OMAP3EVM

Needs boot testing on OMAP4.

Applies on current l-o master branch.

Kevin Hilman (2):
  OMAP2: cpu_is_omap2*: optimize out unused code.
  OMAP4: fix temporary hacks that break multi-omap PM

 arch/arm/mach-omap2/io.c              |   13 ++++++-------
 arch/arm/plat-omap/include/plat/cpu.h |    8 ++++++--
 2 files changed, 12 insertions(+), 9 deletions(-)

