From: Brad Parker <brad@heeltoe.com>
Subject: omap3 otg host not working since 2.6.28?
Date: Sun, 08 Nov 2009 21:11:31 -0500
Message-ID: <4AF77A53.2050908@heeltoe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway.heeltoe.com ([66.134.219.32]:20320 "EHLO
	gateway.heeltoe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbZKICVH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Nov 2009 21:21:07 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by gateway.heeltoe.com (Postfix) with ESMTP id BD1B6CC06C
	for <linux-omap@vger.kernel.org>; Sun,  8 Nov 2009 21:11:32 -0500 (EST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I can't get OTG host mode to work with any recent kernels.  I'm curious 
if anyone else has tried this.
It may well be something most people don't do.

I've tried this on our custom hardware (omap3530/tps65930) and on a 
beagleboard with the same
results.  Our OTG hardware is identical to the beagleboard.

I am using a special mini-B cable which has the ID pin grounded.  I know 
about forcing the
mode with echo "host" >/sys/devices/platform/musb_hdrc/mode. 

When I use a 2.6.28 kernel built using the same patches as are in OE, 
OTG host works fine.  I can get the controller
into host mode.  When I use any kernels from the omap git tree past 
2.6.28 it doesn't work.  The controller
stays in "b-mode" and won't switch.

I can dig into it and figure out why, but I thought I'd ask in case 
anyone else has already solved it.  I've written
some diagnostics for the OTG controller and found it's finicky about 
getting into host mode, sometimes
wanting the phy to be reset before it will switch.

-brad

 
-----------
Brad Parker
Heeltoe Consulting
http://www.heeltoe.com
781-483-3101

