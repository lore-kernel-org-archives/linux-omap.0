From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: Re: [REVIEW PATCH 11/14] OMAP34XXCAM: Add driver
Date: Tue, 03 Mar 2009 09:25:31 +0200
Message-ID: <49ACDB6B.4000102@nokia.com>
References: <A24693684029E5489D1D202277BE894415E6E1A1@dlee02.ent.ti.com>	 <5e9665e10902230008g62d5f3bfm56cffdfe04a3adea@mail.gmail.com>	 <200902231050.29282.tuukka.o.toivonen@nokia.com> <5e9665e10903021848u328e0cd4m5186344be15b817@mail.gmail.com>
Reply-To: sakari.ailus@maxwell.research.nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:28658 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550AbZCCH0F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Mar 2009 02:26:05 -0500
In-Reply-To: <5e9665e10903021848u328e0cd4m5186344be15b817@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DongSoo(Nathaniel) Kim" <dongsoo.kim@gmail.com>
Cc: "Toivonen Tuukka.O (Nokia-D/Oulu)" <tuukka.o.toivonen@nokia.com>, "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nagalla, Hari" <hnagalla@ti.com>

DongSoo(Nathaniel) Kim wrote:
> Hi Tuukka,
> 
> I understand that it is a huge thing to support VIDIOC_S_INPUT.

It might not be that much, in case it's supported by just one slave.

> But without that, we don't have any proper "V4L2" api to get
> information about how many devices are attached to camera interface,
> and names of input devices...and so on. Because VIDIOC_ENUMINPUT and
> VIDIOC_G_INPUT needs VIDIOC_S_INPUT for prior. Of course we can refer
> to sysfs, but using only single set of APIs like V4L2 looks more
> decent.
> 
> What do you think about this?
> If you think that it is a big burden, can I make a patch for this?

I'm just wondering the purpose --- as Tuukka explained, the ISP block 
doesn't make a camera, but a sensor essentially does. So for every 
sensor there's a video device, even if they are implemented by using 
just one ISP. How does this sound like?

But for video decoders at least it's definitely meaningful to support 
VIDIOC_S_INPUT.

-- 
Sakari Ailus
sakari.ailus@maxwell.research.nokia.com
