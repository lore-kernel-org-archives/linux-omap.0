From: Gary Thomas <gary@mlbassoc.com>
Subject: OMAP3 DSS2 - VENC timings
Date: Mon, 16 Jan 2012 11:08:53 -0700
Message-ID: <4F1467B5.80600@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([64.234.241.98]:48109 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754760Ab2APSIz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jan 2012 13:08:55 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I'm running a frame buffer console on a TV device via the VENC.
The video timings don't see to be quite right as Tux is about
1/2 off the screen - both directions, i.e. his head and right
side have been cut off as they are outside the viewable area.
Also, when I send data to the device (via /dev/tty1) which has
90x35 characters, I lose 4 characters on each end of every line.

Is there something I can do about this?  I've looked at the
timings in drivers/video/omap2/dss/venc.c

Also, how can I select NTSC vs PAL setups via the command line?
I have only the one video device VENC.

Thanks

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
