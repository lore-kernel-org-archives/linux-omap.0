From: linux@johnea.net
Subject: Which git to clone for testing prior to submitting bugs?
Date: Thu, 27 Sep 2012 10:19:30 -0700
Message-ID: <50648AA2.2010004@johnea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from johnea.net ([70.167.123.7]:45977 "EHLO mail.johnea.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751455Ab2I0R3L (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Sep 2012 13:29:11 -0400
Received: from [192.168.1.143] (wsip-70-166-88-164.sd.sd.cox.net [70.166.88.164])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.johnea.net (Postfix) with ESMTPSA id 76B9F73F188B
	for <linux-omap@vger.kernel.org>; Thu, 27 Sep 2012 10:19:31 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Hello,

We're developing a system based on DM3730, and using Beagleboard-xM as a prototype platform.

The 3.2 series kernels provided a working video output on Beagleboard-xM integrated HDMI connector.

We use the kernel parameters: omapfb.mode=dvi:800x480MR-24@60 omapfb.vram=0:6M,1:2M,2:2M omapdss.def_disp=dvi

We upgraded to kernel 3.4.3 in order to take advantage of the kernel parameter: buddy=spidev

This provided spidev access without requiring that we build a custom kernel.

However in the 3.4 series, dvi output no longer works.

In a subsequent distro upgrade to 3.4.4 neither dvi, nor buddy=spidev function anymore.

I'd like to test the latest appropriate kernel prior to considering these issues as current bugs.

Can someone please advise which git tree to clone, for testing and possible bisect, prior to reporting bugs to this list?

Thank You

John Andrews
linux@johnea.net

