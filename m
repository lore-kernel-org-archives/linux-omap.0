From: Opel Fahrer <opelfahrer79@yahoo.de>
Subject: CAM / V4L2: OMAP3 camera issues
Date: Thu, 19 Mar 2009 07:23:43 -0700 (PDT)
Message-ID: <341895.54098.qm@web24704.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n21.bullet.mail.ukl.yahoo.com ([87.248.110.138]:26536 "HELO
	n21.bullet.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752209AbZCSO3O convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Mar 2009 10:29:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Hi everybody,

I just wanted to ask if someone of you recently had a look at the  camera driver for the ov3640 sensor included in the omap zoom 1 platform. As I'm a total noob in writing drivers I'm searching for someone to help me to get this device to work the right way because currently it's really a mess. Unfortunately our future work with the omap zoom heavily relies on having camera images in reasonable resolutions and reasonable quality, so for us there is no way around fixing at least some of these points:

As far as I have seen there are several issues. The main problem is that it is only possible to use a very restricted number of image formats. One can use Bayer images in 1024x768 up to 2048x1536 pixels, and using the Bayer format is the only way to get RGB images actually. The much more appreciated YUYV and YVYU formats seem to be broken somehow, so nobody is known to me who was able to decode such an image into a reasonable color image yet. Lastly, a problem is that there is no way to control the exposure of the sensor, such that the images are all heavily over-exposed and there is no way known to me to change any setting to use auto-exposure (the feature is reported to be not available by v4l2). 

I'd be happy if someone could help me in fixing some of these problems.
Regards
Clemens



      

