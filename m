From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: omap-serial: transmission of x-char with DMA (and other issues)
Date: Fri, 13 Apr 2012 11:41:11 +0100
Message-ID: <20120413104111.GF25053@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54204 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab2DMKlQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Apr 2012 06:41:16 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org

Can someone tell me how this works with the current omap-serial driver
please?  It looks to me like this has been broken when DMA support was
added to the driver.

Moreover, please look at the probe function error paths.  They seem to
be lacking any kind of realistic cleanup, so are a potential memory leak.

Then there's the issue of fiddling with the xmit buffer so that it's
using coherent memory in the startup and shutdown functions (why?  when
other serial drivers cope just fine without doing this).  If we want to
use DMA coherent memory there, there should be a clean way to do this,
rather than going behind the upper layers.
