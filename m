From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: Scalling_setspeed doesn't work
Date: Wed, 18 Nov 2009 14:19:53 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FA68A167@dbde02.ent.ti.com>
References: <82cfbe860911170858j2a115673qff7588ac9eb4463c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39762 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753807AbZKRIt5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 03:49:57 -0500
In-Reply-To: <82cfbe860911170858j2a115673qff7588ac9eb4463c@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tarek attia <tarek.m.attia@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

You need to use userspace governor before trying to set speed using scalling_setspeed. Can you pls confirm that? 
You can select userspace governor by using below command
echo userspace > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

Vishwa

-----Original Message-----
From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of tarek attia
Sent: Tuesday, November 17, 2009 10:28 PM
To: linux-omap
Subject: Scalling_setspeed doesn't work

When I try to change the value of (scalling_setspeed) file ,it doesn't
change however it doesn't rise errors as well,,but after changing it
and trying to rereading it ,I found that nothing is changed
!!!?????????


BTW:-I'm using Linux kernel(2.6.29) on the beagleboard with the power
management branch



Any help will be appreciated .

Best Regards,
tarek
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

