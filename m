From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: BUG: LDP - smc911x region too small
Date: Mon, 19 Jan 2009 22:37:50 +0000
Message-ID: <20090119223750.GL18301@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55188 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754475AbZASWh4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2009 17:37:56 -0500
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1LP2ki-0004ez-LK
	for linux-omap@vger.kernel.org; Mon, 19 Jan 2009 22:37:53 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.69)
	(envelope-from <linux@n2100.arm.linux.org.uk>)
	id 1LP2kh-0008UD-0g
	for linux-omap@vger.kernel.org; Mon, 19 Jan 2009 22:37:51 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

At the moment:

        ldp_smc911x_resources[0].start = cs_mem_base + 0x0;
        ldp_smc911x_resources[0].end   = cs_mem_base + 0xf;

However, the SMC911x driver wants to claim 256 bytes from this region.
Indeed, its register set definitions appears to indicate that its needs
more than 16 bytes of address space.

So, the question is what is the right fix?

Unfortunately, fixing this will cause problems with the SMSC911x patches,
so I'd like to get an answer on this sooner rather than later please.
