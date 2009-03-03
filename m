From: "DongSoo(Nathaniel) Kim" <dongsoo.kim@gmail.com>
Subject: Re: [REVIEW PATCH 11/14] OMAP34XXCAM: Add driver
Date: Tue, 3 Mar 2009 16:40:18 +0900
Message-ID: <5e9665e10903022340p4ad6736v21748800566bfc0f@mail.gmail.com>
References: <A24693684029E5489D1D202277BE894415E6E1A1@dlee02.ent.ti.com>
	 <5e9665e10902230008g62d5f3bfm56cffdfe04a3adea@mail.gmail.com>
	 <200902231050.29282.tuukka.o.toivonen@nokia.com>
	 <5e9665e10903021848u328e0cd4m5186344be15b817@mail.gmail.com>
	 <49ACDB6B.4000102@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:48742 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbZCCHkU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Mar 2009 02:40:20 -0500
Received: by wf-out-1314.google.com with SMTP id 28so3171538wfa.4
        for <linux-omap@vger.kernel.org>; Mon, 02 Mar 2009 23:40:18 -0800 (PST)
In-Reply-To: <49ACDB6B.4000102@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sakari.ailus@maxwell.research.nokia.com
Cc: "Toivonen Tuukka.O (Nokia-D/Oulu)" <tuukka.o.toivonen@nokia.com>, "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nagalla, Hari" <hnagalla@ti.com>

Hello Sakari,

Let me explain what I want to do.
First of all, I need to make it clear that I'm not using bare sensors
with omap3, but I'm using ISP included camera modules. To be more
clear I can take a 3G handset for instance, which has dual cameras on
it.
Each camera has their own ISP on them, and they share omap3 camera
data pins and clock/sync pins also.

So, I need a API to switch between two of them because OMAP3 can't
handle every data from each camera at once.

To be honest, I definitely thought that VIDIOC_S_INPUT is the proper
API for that ;(
But now I'm quite confused.

Regards,

Nate



On Tue, Mar 3, 2009 at 4:25 PM, Sakari Ailus <sakari.ailus@nokia.com> wrote:
> DongSoo(Nathaniel) Kim wrote:
>>
>> Hi Tuukka,
>>
>> I understand that it is a huge thing to support VIDIOC_S_INPUT.
>
> It might not be that much, in case it's supported by just one slave.
>
>> But without that, we don't have any proper "V4L2" api to get
>> information about how many devices are attached to camera interface,
>> and names of input devices...and so on. Because VIDIOC_ENUMINPUT and
>> VIDIOC_G_INPUT needs VIDIOC_S_INPUT for prior. Of course we can refer
>> to sysfs, but using only single set of APIs like V4L2 looks more
>> decent.
>>
>> What do you think about this?
>> If you think that it is a big burden, can I make a patch for this?
>
> I'm just wondering the purpose --- as Tuukka explained, the ISP block
> doesn't make a camera, but a sensor essentially does. So for every sensor
> there's a video device, even if they are implemented by using just one ISP.
> How does this sound like?
>
> But for video decoders at least it's definitely meaningful to support
> VIDIOC_S_INPUT.
>
> --
> Sakari Ailus
> sakari.ailus@maxwell.research.nokia.com
>



-- 
========================================================
DongSoo(Nathaniel), Kim
Engineer
Mobile S/W Platform Lab. S/W centre
Telecommunication R&D Centre
Samsung Electronics CO., LTD.
e-mail : dongsoo.kim@gmail.com
          dongsoo45.kim@samsung.com
========================================================
