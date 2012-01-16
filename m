From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] omap2+: add drm device
Date: Mon, 16 Jan 2012 16:12:10 +0200
Message-ID: <CAMP44s0EYp1inCHZkAZES7ezOiL7F533-euGQCk83hS_QN-LgQ@mail.gmail.com>
References: <1326487320-8781-1-git-send-email-rob.clark@linaro.org>
	<CAMP44s36cE_dBQcyDnboUgbUCtjgMnLnZq8c+0qB8GfH9Tq8aA@mail.gmail.com>
	<CAF6AEGvdLsg33yGqTQQ7EWJh_4+rGSPbCZmSSYCib1cSS2pqWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:43641 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754710Ab2APOMM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jan 2012 09:12:12 -0500
Received: by lahc1 with SMTP id c1so918586lah.19
        for <linux-omap@vger.kernel.org>; Mon, 16 Jan 2012 06:12:11 -0800 (PST)
In-Reply-To: <CAF6AEGvdLsg33yGqTQQ7EWJh_4+rGSPbCZmSSYCib1cSS2pqWg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: linux-omap@vger.kernel.org, patches@linaro.org, Greg KH <greg@kroah.com>, dri-devel@lists.freedesktop.org

On Fri, Jan 13, 2012 at 11:19 PM, Rob Clark <rob.clark@linaro.org> wrot=
e:
> On Fri, Jan 13, 2012 at 2:59 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Fri, Jan 13, 2012 at 10:41 PM, Rob Clark <rob.clark@linaro.org> w=
rote:
>>> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makef=
ile
>>> index 9a58461..b86e6cb 100644
>>> --- a/arch/arm/plat-omap/Makefile
>>> +++ b/arch/arm/plat-omap/Makefile
>>> @@ -4,7 +4,7 @@
>>>
>>> =C2=A0# Common support
>>> =C2=A0obj-y :=3D common.o sram.o clock.o devices.o dma.o mux.o \
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0usb.o fb.o counter_32k.o
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0usb.o fb.o counter_32k.o drm.o
>>
>> Should be something like this:
>> obj-$(CONFIG_DRM_OMAP) +=3D drm.o
>
> btw, how does that work if CONFIG_DRM_OMAP=3Dm? =C2=A0Do you end up w=
/ a
> plat-omap module?

Yes, and platform drivers are supposed to be loaded automatically at
boot-time by udev (or similar).

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
