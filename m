From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: OMAP build now completely broken in latest arm-soc
Date: Sun, 25 Nov 2012 09:37:04 +0000
Message-ID: <20121125093704.GV3332@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50218 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626Ab2KYJh2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 Nov 2012 04:37:28 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org

Not much more to say...

arch/arm/plat-omap/i2c.c:35:1: error: expected identifier or '(' before '<<' token

But also, the:

arch/arm/mach-omap2/timer.c:163:28: warning: 'omap_counter_match' defined but not used

warning is still there.
