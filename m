From: DongSoo Kim <dongsoo.kim@gmail.com>
Subject: OMAP3430 camear ISP strobe control
Date: Wed, 4 Feb 2009 15:37:58 +0900
Message-ID: <5e9665e10902032237s4cc19d2aw3740dbd443a3e5fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.225]:43006 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbZBDGiA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Feb 2009 01:38:00 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-media@vger.kernel.org
Cc: =?EUC-KR?B?x/zB2CCx6A==?= <riverful.kim@samsung.com>, jongse.won@samsung.com, kyungmin.park@samsung.com

Hello.

Since I was working on OMAP3 camera driver with camera interface
driver in OMAPZOOM repository,

I could not figure it out how to control strobe device.

I found that strobe control depends on CSI1 (MIPI)..but how could I
control that?

In my opinion, in case of OMAP3 ISP has to be made in v4l2 int device
way. (of course new v4l2 int device commands should be made either)

And also new V4L2 API should be made I guess...;(

Anyone has any idea?
