From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [RESEND PATCHv3 0/4] Adding soc related info into /proc/cpuinfo
Date: Wed,  5 May 2010 11:42:04 +0300
Message-ID: <1273048928-6105-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:26494 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933834Ab0EEIl3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 04:41:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Linux-OMAP <linux-omap@vger.kernel.org>
Cc: ext Tony Lindgren <tony@atomide.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, "\\\"De-Schrijver Peter (Nokia-D/Helsinki)\\\"" <Peter.De-Schrijver@nokia.com>, santosh.shilimkar@ti.com, felipe.balbi@nokia.com, Eduardo Valentin <eduardo.valentin@nokia.com>

Hello all,

I'm resending this series with minor change in the subject prefix of patch 4/4.
Removed the PM: prefix. Everything else is same. So, I kept the v3 prefix as well.

v3:
And now v3 of this series. Basically a minor change wrt string manipulation.
No need to use strlen in so many places. Previous log for reference:

v2:

Here is the version 2 of this series. Now die id is protected using
same x86 protection mechanism to hide x86 product number. Besides,
a compilation Kconfig option has been added for DIE ID as well.

Here is previous PATCH 0/4 message:

v1:

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

 *** SUBJECT HERE ***

*** BLURB HERE ***

Eduardo Valentin (4):
  ARM: Introduce SoC Info into /proc/cpuinfo
  mach-omap2: Add SoC info data for OMAP2,3,4 into /proc/cpuinfo
  mach-omap1: Add SoC info data for OMAP1 into /proc/cpuinfo
  OMAP3: export chip IDCODE, Production ID and Die ID

 Documentation/kernel-parameters.txt |    2 +
 arch/arm/include/asm/system.h       |    2 +
 arch/arm/kernel/setup.c             |    5 +++
 arch/arm/mach-omap1/id.c            |   15 ++++++----
 arch/arm/mach-omap2/Kconfig         |   10 +++++++
 arch/arm/mach-omap2/id.c            |   51 ++++++++++++++++++++++++++++++----
 6 files changed, 73 insertions(+), 12 deletions(-)

