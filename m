From: "Kridner, Jason" <jdk@ti.com>
Subject: Generic PWM kernel driver (with support for OMAP3)
Date: Mon, 13 Sep 2010 08:06:33 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E5F1B55AD@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56487 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751116Ab0IMNGk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Sep 2010 09:06:40 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>, Varun Jewalikar <varunjewalikar@hotmail.com>, soren <soren.ssc@gmail.com>, "scott@jumpnowtek.com" <scott@jumpnowtek.com>
Cc: "beagleboard@googlegroups.com" <beagleboard@googlegroups.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-embedded@vger.kernel.org" <linux-embedded@vger.kernel.org>

Bill,

I was looking at your PWM patch set[1] and it seems this has been pending for a long time (since February).  Do you know if this is any closer to being accepted, ie. have you done any additional work or has it been accepted to some maintainer's tree?

There was a Google Summer of Code project for BeagleBoard.org[2] to put PWM code into the kernel[3], but the student (Varun, copied) has not yet submitted his patches to the linux-embedded mailing list yet and he wasn't aware of your patch set when he began his work.  His patch set[4] also misses some of the features from your patch set.  The student's work seems to be based on Scott's work[5] and branched from his tree on github[6].

Have you released an updated patch series to address the feedback comments or shall we introduce a new set?

Regards,
Jason Kridner
http://beagleboard.org/twitter 

[1] https://patchwork.kernel.org/patch/76229/
[2] http://beagleboard.org/gsoc
[3] http://elinux.org/BeagleBoard/GSoC/2010_Projects/Pulse_Width_Modulation 
[4] http://github.com/neo01124/omap3-pwm
[5] http://www.jumpnowtek.com/index.php?option=com_content&view=article&id=56&Itemid=63 
[6] http://github.com/scottellis/omap3-pwm 
