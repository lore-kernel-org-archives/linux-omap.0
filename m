From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: OMAP and arm-soc's for-next branch
Date: Sat, 24 Mar 2012 12:22:56 +0000
Message-ID: <20120324122256.GA5611@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45706 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528Ab2CXMXE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Mar 2012 08:23:04 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

I've just re-merged the build tree for the nightly builds so it's now
based on v3.3, and pulled in the latest for-next from arm-soc.

I notice that the problem I reported earlier (see the "arm-soc + rmk's
tree boot failure on OMAP4430SDP" thread), which results in OMAP
being totally unable to boot, is still present.

As far as I'm concerned, as long as this remains unfixed in arm-soc,
arm-soc is not to push any branch containing the broken commit
(3ec2decb) upstream.
