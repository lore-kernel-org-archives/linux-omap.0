From: "DongSoo(Nathaniel) Kim" <dongsoo.kim@gmail.com>
Subject: Re: [REVIEW PATCH 11/14] OMAP34XXCAM: Add driver
Date: Tue, 3 Mar 2009 11:48:05 +0900
Message-ID: <5e9665e10903021848u328e0cd4m5186344be15b817@mail.gmail.com>
References: <A24693684029E5489D1D202277BE894415E6E1A1@dlee02.ent.ti.com>
	 <5e9665e10902230008g62d5f3bfm56cffdfe04a3adea@mail.gmail.com>
	 <200902231050.29282.tuukka.o.toivonen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:54182 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954AbZCCCsH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 21:48:07 -0500
Received: by wf-out-1314.google.com with SMTP id 28so3048004wfa.4
        for <linux-omap@vger.kernel.org>; Mon, 02 Mar 2009 18:48:05 -0800 (PST)
In-Reply-To: <200902231050.29282.tuukka.o.toivonen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>
Cc: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ailus Sakari (Nokia-D/Helsinki)" <Sakari.Ailus@nokia.com>, "Nagalla, Hari" <hnagalla@ti.com>

Hi Tuukka,

I understand that it is a huge thing to support VIDIOC_S_INPUT.
But without that, we don't have any proper "V4L2" api to get
information about how many devices are attached to camera interface,
and names of input devices...and so on. Because VIDIOC_ENUMINPUT and
VIDIOC_G_INPUT needs VIDIOC_S_INPUT for prior. Of course we can refer
to sysfs, but using only single set of APIs like V4L2 looks more
decent.

What do you think about this?
If you think that it is a big burden, can I make a patch for this?
Cheers,

Nate

On Mon, Feb 23, 2009 at 5:50 PM, Tuukka.O Toivonen
<tuukka.o.toivonen@nokia.com> wrote:
> On Monday 23 February 2009 10:08:54 ext DongSoo(Nathaniel) Kim wrote:
>> So, logically it does not make sense with making device nodes of every
>> single slave attached with OMAP3camera interface. Because they can't
>> be opened at the same time,even if it is possible it should not work
>> properly.
>>
>> So.. how about making only single device node like /dev/video0 for
>> OMAP3 camera interface and make it switchable through V4L2 API. Like
>> VIDIOC_S_INPUT?
>
> You are right that if the OMAP3 has several camera sensors attached
> to its camera interface, generally just one can be used at once.
>
> However, from user's perspective those are still distinct
> cameras. Many v4l2 applications don't support VIDIOC_S_INPUT
> or at least it will be more difficult to use than just pointing
> an app to the correct video device. Logically they are two
> independent cameras, which can't be used simultaneously
> due to HW restrictions.
>
> - Tuukka
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
