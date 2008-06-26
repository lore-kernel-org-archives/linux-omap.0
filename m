From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: tslib on OMAP3
Date: Thu, 26 Jun 2008 12:33:09 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301118F2D6E@dbde02.ent.ti.com>
References: <200806251833.25218.thomas.cooksey@trolltech.com>
 <2ee9e08d0806250948pbc33b01k9bccd66fe3131e4f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:60212 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061AbYFZHDT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2008 03:03:19 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by calf.ext.ti.com (8.13.7/8.13.7) with ESMTP id m5Q73Dla023489
	for <linux-omap@vger.kernel.org>; Thu, 26 Jun 2008 02:03:18 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m5Q73CxL012843
	for <linux-omap@vger.kernel.org>; Thu, 26 Jun 2008 02:03:12 -0500 (CDT)
In-Reply-To: <2ee9e08d0806250948pbc33b01k9bccd66fe3131e4f@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tom,

The tslib is contained OMAP35x package released from Texas Instruments. It is functional.
This package is based on 2.6.22-18.

What is the kernel version you are using?
Are you may want to look to update the touchscreen driver (drivers/input/touchscreen/ads7846.c).

Best regards,
Sanjeev

---------- Forwarded message ----------
From: Tom Cooksey <thomas.cooksey@trolltech.com>
Date: Wed, Jun 25, 2008 at 10:03 PM
Subject: tslib on OMAP3
To: linux-omap@vger.kernel.org


Does anyone have tslib running well on an OMAP3?

I have a LogicPD Zoom LPD3430 thing and a TI OMAP3430 SDP dev board,
and both have similar issues. The touchscreen is on /dev/input/event1 and
works, but is so inaccurate, it's almost unusable. After running ts_calibrate
I'm testing with ts_test. If I press and hold with ts_test in draw mode, I can
see just how inaccurate it is... After a few seconds I get a white blob about
1/3 of the screen width in diameter.

Has anyone got this to work correctly? If so, what tslib plugins/modules are
you using and with which parameters? I've tried various combinations and
found some to give a slight improvement and others make it a lot worse.



Cheers,

Tom
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
