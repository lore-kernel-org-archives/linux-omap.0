From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: arm-soc + rmk's tree boot failure on OMAP4430SDP
Date: Fri, 16 Mar 2012 23:11:58 +0000
Message-ID: <20120316231158.GA9970@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56677 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031499Ab2CPXMG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Mar 2012 19:12:06 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>

Sometime during the last week, the OMAP4430SDP stopped booting - it now
stops with no kernel messages output:

http://www.arm.linux.org.uk/developer/build/result.php?type=boot&idx=69

The previously booted version:

http://www.arm.linux.org.uk/developer/build/result.php?type=boot&idx=57

worked fine - though this log will only be available for about 3 hours.

I've re-checked my tree, and the OMAP4430SDP boots fine, so it's either
breakage coming from arm-soc or a result of merging the two trees
together.
