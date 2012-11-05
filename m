From: Federico Fuga <ml@studiofuga.com>
Subject: hdmi on 4430 (kernel 3.4)
Date: Mon, 5 Nov 2012 22:59:26 +0100
Message-ID: <32739C29-CEEA-481C-B070-1754E3CA94C8@studiofuga.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from oproxy12-pub.bluehost.com ([50.87.16.10]:41827 "HELO
	oproxy12-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753786Ab2KEV7b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 16:59:31 -0500
Received: from [95.75.21.25] (port=15341 helo=[192.168.1.100])
	by box484.bluehost.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.76)
	(envelope-from <ml@studiofuga.com>)
	id 1TVUhe-00055d-Kf
	for linux-omap@vger.kernel.org; Mon, 05 Nov 2012 14:59:31 -0700
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi Everybody,

I am working on a custom OMAP4430 board with HDMI support. I am using the latest omapzoom ubuntu-integration kernel (3.4.0-1487.6) 
I tested the same on the pandaboard with the same cpu, with the same result. Both are lacking the "HDMI Companion chip" (U6 on pandaboard with 4430), because on our custom board we don't need EDID support (we are using an HDMI to VGA chip converter), for testing purpose it was removed from the pandaboard.
I am unable to make HDMI working. 
I was assured that this kernel is correctly working with HDMI on pandaboard, so I'd guess that the problem is due to the missing edid, but I am not 100% sure.
For simplicity, I removed the DVI configuration on the panda board file, by removing the DVI display configuration, and changing the default device to HDMI.
The hdmi interface seems to be configured correctly , the overlay/manager/display chain is correctly setup and enabled, but no signal is detected by the monitor, and the screen is black.
No errors are present in the logs - I'll send a copy of it with omapdss.debug=y tomorrow, eventually.
I wanted to check the HDMI registers, but I didn't find the hdmi registers table on the TRM.
Does someone have some hint, comment or previous experience on that? 
Where can I find the hdmi registers list on the manual or other documentation?
Note that as far as i know, the 2.6.35 kernel was working correctly (I can't check right now, unfortunately).
Thank you.

best regards


Federico Fuga


