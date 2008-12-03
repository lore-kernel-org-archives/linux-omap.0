From: Peter Barada <peter@the-baradas.com>
Subject: Problems unblanking backlight in 2.6.27
Date: Wed, 03 Dec 2008 15:58:16 -0500
Message-ID: <1228337896.27896.358.camel@blackhole>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from h-66-166-225-55.cmbrmaor.covad.net ([66.166.225.55]:64528 "EHLO
	baradas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751066AbYLCU6S (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Dec 2008 15:58:18 -0500
Received: from [192.168.3.4] (blackhole [192.168.3.4])
	by baradas.org (Postfix) with ESMTP id 2E1A698B9C
	for <linux-omap@vger.kernel.org>; Wed,  3 Dec 2008 15:58:17 -0500 (EST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


I'm trying to add backlight support for the OMAP 35x LV SOM to the
2.6.27 kernel, and I'm running into problems.

I cloned drivers/video/backlight/omap_bl.c and modified the
enable/intensity to toggle the GPIO lines attached to the display, and
on the 10 minute console blank timer the backlight shuts off and the
panel is disabled.  However, I can't get trigger the code to turn it
back on, even after adding:

	do_poke_blanked_console = 1;
	schedule_console_callback();

in my touch driver on a pen down event...

Any ideas how to get the console to unblank on touch (including having
the backlight turn back on)?

-- 
Peter Barada // senior software engineer
 
LOGIC // embedded product solutions
411 Washington Ave. N. Suite 400
Minneapolis, MN 55401
M // 617.513.5874
 
Peter.Barada@logicpd.com
www.logicpd.com

/ / / / / / / / / / / / / / / / / / / / / / / / / / / / 

This message (including any attachments) contains confidential
information intended for a specific individual and purpose, and is
protected by law. If you are not the intended recipient, you should
delete this message and are hereby notified that any disclosure,
copying, or distribution of this message, or the taking of any action
based on it, is strictly prohibited.

