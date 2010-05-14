From: simon@santesteban.eu
Subject: em28xx driver for omap - right shift
Date: Fri, 14 May 2010 10:33:13 +0200 (CEST)
Message-ID: <58854.80.35.16.215.1273825993.squirrel@mail.santesteban.eu>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from slcd079.piensasolutions.com ([217.76.150.162]:60328 "EHLO
	slcd079.piensasolutions.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932221Ab0ENIdP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 May 2010 04:33:15 -0400
Received: from mail.santesteban.eu (localhost.localdomain [127.0.0.1])
	by slcd079.piensasolutions.com (Postfix) with ESMTP id 8D82E1DC4009
	for <linux-omap@vger.kernel.org>; Fri, 14 May 2010 10:33:13 +0200 (CEST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I have been trying to use an usb video capturer on my overo board, and id
idn't work, all that I got was a blank (actually green on SDL) picture.

After some digging I found that there was a problem in the initialization
of the device, wich was solved applying the foolowing patch to
em28xx-core.c

diff em28xx-core_old.c em28xx-core.c
778c778
< 		height >>= norm_maxh(dev);
---
> 		height >>= 1;


Some time in the past, there was a patch to add support for interlaced
video that replaced the ancient code

	height = norm_maxh(dev) >> 1;

with

	height = norm_maxh(dev);
	[..some code..]
	if (!dev->progressive)
		height >>= norm_maxh(dev);


Surprisingly on my desktop computer this code is working. When
norm_maxh(dev) = 576, the shift to the right does not change the value of
height, ie:
height = 576;
height>>=height;
printf("%i\n",height);

returns 576

However, if I compile for arm, the code returns 0



Could you confirm that this is right? (maybe I'm breaking something else)

Once this change is applied, the video is shown ok (at least for a while,
but I thinnk this is another issue)




