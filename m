From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCH 0/4] Adding soc related info into /proc/cpuinfo
Date: Mon, 26 Apr 2010 11:24:49 +0300
Message-ID: <1272270293-18568-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:34033 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790Ab0DZIZW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 04:25:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>, ext Tony Lindgren <tony@atomide.com>
Cc: "\\\"De-Schrijver Peter (Nokia-D/Helsinki)\\\"" <Peter.De-Schrijver@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@nokia.com>

Hello all,

This series is to continue what has been discussed several weeks ago
wrt IDCODE patch. Original patch was made by Peter and discussion is here:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg17553.html

So, the conclusion was that IDCODE info is useful even in production systems,
and for that debugfs is not a good choice to export it. One suggestion was to
add it under /proc/cpuinfo. However this entry nowadays exports only ARM related
information.

So this series does the trick by extending the ARM /proc/cpuinfo to include
soc info data. There are a few ways to add a hook for soc specific data. But
I've decided to implement it via the simplest way I found. Basically it is
same thing which is done for system_rev, system_serial_low and system_serial_high.
Then, now we have system_soc_info, which is printed only if there is something
useful there.

As usual, comments are welcome.

BR,

Eduardo Valentin (4):
  ARM: Introduce SoC Info into /proc/cpuinfo
  OMAP2,3: Add SoC info data for OMAP2,3
  OMAP1: Add SoC info data for OMAP1
  OMAP3: PM: export chip IDCODE, Production ID and Die ID

 arch/arm/include/asm/system.h |    2 ++
 arch/arm/kernel/setup.c       |    5 +++++
 arch/arm/mach-omap1/id.c      |   18 ++++++++++++------
 arch/arm/mach-omap2/id.c      |   41 +++++++++++++++++++++++++++++++++++------
 4 files changed, 54 insertions(+), 12 deletions(-)

