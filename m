From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: OMAP3 ISP suspend/resume question
Date: Tue, 21 Dec 2010 15:52:28 +0100
Message-ID: <201012211552.28545.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:55205 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876Ab0LUOwW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Dec 2010 09:52:22 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

Hi everybody,

I'm trying to implement proper suspend/resume in the OMAP3 ISP driver and ran 
into an issue that I'd like to discuss here.

The OMAP3 ISP has a bad tendency to crash when the input video stream is 
stopped asynchronously to the ISP. For that reason the ISP must be suspended 
before the connected video sensors. As they sensors and ISP are connected to 
different busses (I2C and platform), the suspend/resume order is not 
guaranteed. My first issue is to model that dependency and instruct the kernel 
to suspend the sensors and ISP in the right order.

The second issue comes from the fact that the sensor clock is (or least can 
be) supplied by the ISP. In order to suspend the sensor properly the clock 
needs to be present, and the ISP can't thus be fully suspended, which 
conflicts with the first requirement.

I've thought about splitting the ISP suspend operation in prepare() and 
suspend(). prepare() would stop the video stream in the ISP, and suspend() 
would really suspend the ISP, disabling the clocks. The dev_pm_ops 
documentation states that prepare() must not touch the hardware state, so 
that's probably not a very good solution. I could split it using 
suspend()/suspend_noirq(), but it might be an abuse of suspend_noirq(). The 
same problem occurs during resume as well, as the ISP clock must be restarted 
before resuming the sensor, which in turn should be resumed before the ISP 
video stream is restarted.

Thoughts and advices would be appreciated on both issues.

-- 
Regards,

Laurent Pinchart
