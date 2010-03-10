From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/2] fixes for broken PM init with multi-OMAP
Date: Wed, 10 Mar 2010 09:16:29 -0800
Message-ID: <1268241391-26312-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f194.google.com ([209.85.222.194]:51554 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756208Ab0CJRQg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Mar 2010 12:16:36 -0500
Received: by pzk32 with SMTP id 32so221983pzk.4
        for <linux-omap@vger.kernel.org>; Wed, 10 Mar 2010 09:16:36 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

multi-OMAP builds are broken in various ways due to conditional code.
Here is a small series of fixes.

Build tested: omap3_defconfig, omap_4430sdp_defconfig
Boot tested: omap3_defconfig on OMAP3EVM
Boot tested: omap3_defconfig on OMAP3430SDP (Thanks, Santosh)
Boot tested: omap3_defconfig on OMAP4430SDP (Thanks, Santosh)

Applies on current l-o master branch.

Updates from RFC patch:
- removed 'FIXME' around conditional SDRC execution for OMAP4
  since OMAP4 has no SDRC.

Kevin Hilman (2):
  OMAP2: cpu_is_omap2*: fix compile-time removal of unused code.
  OMAP4: fix temporary hacks that break multi-omap PM

 arch/arm/mach-omap2/io.c              |   13 ++++++-------
 arch/arm/plat-omap/include/plat/cpu.h |    8 ++++++--
 2 files changed, 12 insertions(+), 9 deletions(-)

