From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Touchscreen calibration problem on OMAP3430sdp
Date: Tue, 02 Sep 2008 21:19:54 +0800
Message-ID: <1220361594.7042.24.camel@localhost>
Reply-To: stanley.miao@windriver.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:47513 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbYIBNS0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Sep 2008 09:18:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux@arm.linux.org.uk

Following is my touchscreen calibration information. The bottom right
point has a big Y value, so the four points construct a trapezium. After
calibration,  the touchscreen still isn't accurate. If I draw a square
with the draw function of ts_test, it will give me a trapezium. 

Is it because there is some problems with my touchscreen ? or because
the calibration algorithm is imperfect ?

Thanks
Stanley.


root@localhost:/root> ts_calibrate 
xres = 240, yres = 320
Took 33 samples...
Top left : X = 2492 Y =  122
Took 26 samples...
Top right : X = 2221 Y =  336
Took 26 samples...
Bot right : X = 2728 Y =  740
Took 27 samples...
Bot left : X = 2789 Y =  235
Took 22 samples...
Center : X = 2568 Y =  335
532.714355 -0.200746 0.285931
-908.327820 0.396201 0.153282
Calibration constants: 34911968 -13156 18738 -59528172 25965 10045
65536 

