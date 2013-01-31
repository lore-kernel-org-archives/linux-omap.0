From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Failure to boot...
Date: Thu, 31 Jan 2013 01:49:12 +0000
Message-ID: <20130131014912.GM2637@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59574 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519Ab3AaBtm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jan 2013 20:49:42 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, arm@kernel.org

Having spent today sorting out the Realview EB boot, the last thing
I expected to find was that both my OMAP platforms are unbootable
to the point that absolutely nothing happens after the boot loader
transfers control.

I've not been running the boots for about a month, so I'm not sure
when this breakage crept in.

You can see the results in the boot logs on the website.  Please
investigate.  And I'll try without arm-soc tomorrow.

Very disappointed that the ARM kernel seems to be rather screwed at
the moment across multiple sub-arches.
