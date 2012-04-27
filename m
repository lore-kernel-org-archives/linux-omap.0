From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Audio support on OMAP 3430LDP or 4430SDP boards
Date: Fri, 27 Apr 2012 14:58:02 +0100
Message-ID: <20120427135802.GA28062@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:48344 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760000Ab2D0N6H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Apr 2012 09:58:07 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

Can someone please hint on what audio is supported on these two OMAP
boards?  From what I can tell, the answer is either "nothing" or "hdmi",
both of which are useless to me if someone wants me to convert the OMAP
ASoC driver to DMA engine.

>From what I can see on the 4430SDP, there's a 3.5mm headset jack,
microphones and speakers on the board, so the board does have audio
hardware.  However, it seems (as, I'm afraid to say, seems to be pretty
much standard practice with OMAP) there's a total lack of software
support in mainline.

This kind'a prevents me testing changes to the DMA support for OMAP
ASoC...

What can be done to remedy this situation?

Thanks.
