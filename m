From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: More LDP stuff
Date: Thu, 6 Jan 2011 15:36:53 +0000
Message-ID: <20110106153653.GD1198@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41133 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025Ab1AFPg6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 10:36:58 -0500
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.72)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1PartX-0000qT-9H
	for linux-omap@vger.kernel.org; Thu, 06 Jan 2011 15:36:55 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.72)
	(envelope-from <linux@n2100.arm.linux.org.uk>)
	id 1PartW-0001au-1R
	for linux-omap@vger.kernel.org; Thu, 06 Jan 2011 15:36:54 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

During boot, apart from the watchdog issue, I'm also seeing:

Clocking rate (Crystal/Core/MPU): 26.0/266/500 MHz
Reprogramming SDRC clock to 266000000 Hz
dpll3_m2_clk rate change failed: -22

Is that something to be concerned about?

ads7846 spi1.0: unable to get regulator: -19

Is something missing from the ldp support code to declare this regulator?

mmcblk0: retrying using single block read
(repeated many times)

Is the OMAP HSMMC driver really unable to handle multi-block read
requests, or is something missing on the LDP to make it work?
