From: Tom Cooksey <thomas.cooksey@trolltech.com>
Subject: Accelerating video playback on OMAP2 & OMAP3
Date: Mon, 9 Jun 2008 18:25:08 +0200
Message-ID: <200806091825.08632.thomas.cooksey@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hoat.troll.no ([62.70.27.150]:54597 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751714AbYFIQbn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jun 2008 12:31:43 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 5421220ACE
	for <linux-omap@vger.kernel.org>; Mon,  9 Jun 2008 18:21:37 +0200 (CEST)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 4B373202F8
	for <linux-omap@vger.kernel.org>; Mon,  9 Jun 2008 18:21:37 +0200 (CEST)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id m59GLbjR012936
	for <linux-omap@vger.kernel.org>; Mon, 9 Jun 2008 18:21:37 +0200
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I cam currently looking into accelerating video playback on the OMAP2420, OMAP2430, 
OMAP3430 and eventually the OMAP3530 (once we recieve some hardware).


>From what I understand, we can use the v4l2 interface to send buffers to the display
hardware, which will do the scaling & YUV->RGB conversion in hardware. However, I was
wondering what the options are for doing mpeg decode in hardware too. I believe the
DaVinci platforms ship with GStreamer elements which will do MPEG decoding on the DSP
and provide the output to a seperate GStreamer video sync. Are there any gstreamer
elements avaliable to do the same on the OMAP2 & OMAP3 processors? If not, how can we
accelerate the MPEG decode?

We eventually want to be able to switch to rendering video frames into off-screen buffers.
We hope this will allow us to upload them as a textures, which our compositing system can 
use for window animations. Once the animation has finished and windows are static, we'd
then switch back to using the v4l2 overlay.


Help & advice is greatly appreciated! :-)


Cheers,

Tom


PS: This is a repost ater the original was sent to the old mailing list. Sorry if you get it twice.
