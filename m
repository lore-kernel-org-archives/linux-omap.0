From: Arun C <arunedarath@mistralsolutions.com>
Subject: Problem with configuring the LCD in VGA mode
Date: Sat, 08 Mar 2008 16:16:08 +0530
Message-ID: <1204973168.4869.23.camel@localhost.localdomain>
Reply-To: arunedarath@mistralsolutions.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway.mistralsoftware.com ([220.227.112.130]:4449 "EHLO
	Mistralsoftware.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752494AbYCHKuD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Mar 2008 05:50:03 -0500
Received: from [192.168.13.249] by mistralsolutions.com (MDaemon PRO v9.6.4)
	with ESMTP id 52-md50000008014.msg
	for <linux-omap@vger.kernel.org>; Sat, 08 Mar 2008 16:22:30 +0530
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Hi all,

I have a custom board with VGA support for LCD and i am using the latest
git frame buffer driver.

LCD works fine without any problem in QVGA mode with the following
timings,

DSS1fclk=55Mhz

mode "240x320-60"
        # D: 5.000 MHz, H: 19.455 kHz, V: 59.862 Hz
        geometry 240 320 240 320 16
        timings 200000 0 14 3 1 3 1
        accel false
        rgba 5/11,6/5,5/0,0/0
endmode

I changed the following parameters for VGA mode keeping DSS1fclk at
55MHz

        .x_res          = 480,
        .y_res          = 640,
        .hsw            = 2,            
        .hfp            = 0,            
        .hbp            = 28,           
        .vsw            = 1,            
        .vfp            = 2,            
        .vbp            = 0,            
        .pixel_clock    = 20000,

As with these settings my pixel clock is set to 18.3Mhz and LCD comes up
with the linux logo.

But if I try to display continuously to frame buffer lcd flickers and
gfxfifo underflow irq occurs frequently.

I tried increasing DSS1fclk to 82.5 (660Mhz/8) still gfxfifo
underflows. 

If i keep DSS1fclk=55Mhz and pixel_clock=5000 it works without any
problem but the vfreq( vertical refresh rate) is very too low for 
decent viewing in VGA mode.

Any body faced this issue?? Please help me to solve this problem.


Regards,
Arun c













-------------------------------------------------------DISCLAIMER------------------------------------------------------
The information transmitted herewith is confidential and proprietary information intended only for use by the individual or entity to which it is addressed. If the reader of this message is not the intended recipient, you are hereby notified that any review, retransmission, dissemination, distribution, copying or other use of, or taking of any action in reliance upon this information is strictly prohibited. If you have received this communication in error, please contact the sender and delete the material from your computer.
--------------------------------------------------------------------------------------------------------------------------------

Please do not print this email unless it is absolutely necessary. Spread environmental awareness.


