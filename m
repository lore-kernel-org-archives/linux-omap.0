From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: OMAP4 SDP regression...
Date: Mon, 17 Mar 2014 23:32:30 +0000
Message-ID: <20140317233229.GP21483@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:56283 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750733AbaCQXcj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Mar 2014 19:32:39 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

There's been a couple of regressions on OMAP4430 SDP I've only recently
noticed:

http://www.arm.linux.org.uk/developer/build/result.php?type=boot&idx=1597

Configuring network interfaces... udhcpc (v1.9.1) started
Sending discover...
Sending discover...
Sending discover...
No lease, failing
done.

No link lights come up either.  The hardware is fine because uboot manages
to successfully tftp the kernel.

It looks like it was working in -rc4+armsoc and -rc5+armsoc, but not
-rc6+armsoc.

>From what I can see, nothing has changed in drivers/net/ethernet/micrel/
since rc5.

I've been through the delta from 3.14-rc5, and I don't see anything
obvious.  Any ideas?  Known problem?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
