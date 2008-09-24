From: "omaper 123" <omaper123@gmail.com>
Subject: OMAP3430 - Finding problems with Camera ISP serial driver
Date: Wed, 24 Sep 2008 10:36:33 +0530
Message-ID: <b20d63e90809232206t1f1fc4f3uf1852c5e584630fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.225]:26656 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbYIXFGf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 01:06:35 -0400
Received: by qb-out-0506.google.com with SMTP id f11so1654344qba.17
        for <linux-omap@vger.kernel.org>; Tue, 23 Sep 2008 22:06:34 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi All,
 	I'm working on OMAP3430 SDP board and trying to use OmniVision
Camera (MIPI CSI2 interface) for my video application. Application
works fine with Micron( Parallel interface), but with OV camera it
blocks indefinitely at the call to fetch frame from the driver( i.e.
VIDICO_DQBUF ioctl call).
    From the boot logs, it is clear that both the cameras are
detected, registered properly with v4l2. I'm using /dev/video0 and
/dev/video4 as the device files for accessing micro(mt9p012) and
OmniVisio(OV3640) cameras respectively.
  Am i missing something ?. Do I do need to do any other configurations?.
 I'm new to OMAP platform and  trying to debug Camera ISP CSI2
interface driver. Looking for suggestions and debugging hints...

Thanks
 Omaper
