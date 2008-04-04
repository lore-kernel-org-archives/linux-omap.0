From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [RFC/PATCH 0/1] ALSA SoC support for OMAP
Date: Fri,  4 Apr 2008 12:22:27 +0300
Message-ID: <1207300948-11598-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:24048 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbYDDJWU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Apr 2008 05:22:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-omap@vger.kernel.org

Hi

Here is the second version of ASoC support for OMAP. Now based to dev branch of
git://opensource.wolfsonmicro.com/linux-2.6-asoc but applies to linux-omap
by modifying Kconfig and Makefile in sound/soc/.

Code hasn't changed a very much. Some minor clean-ups etc and support for
OMAP2430 and 3430 is not included until we have updated
arch/arm/plat-omap/mcbsp.c module in place supporting them (work in progress).

This have the same issues than first version [1] but TODO list is different:
- Pin multiplexing: This belongs to .../plat-omap/mcbsp.c, not here
- Multiformat & multilink McBSP DAI: ASoC v2
- omap_mcbsp_start & _stop API change: Probably with or after updated mcbsp.c

Note that include/asm-arm/arch-omap/control.h is missing from vanilla kernel
at the moment but that's queued for 2.6.26.

-- 
Jarkko

1. http://marc.info/?l=linux-omap&m=120643770810683&w=2
