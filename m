From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH 1/2] omap2+: add drm device
Date: Mon, 16 Jan 2012 15:24:59 -0600
Message-ID: <CAF6AEGv2pDDdAJrWAifCOC7=nHa+-48Fdq+Q5Kv3wHHFj_c8Nw@mail.gmail.com>
References: <1326487320-8781-1-git-send-email-rob.clark@linaro.org>
	<CAMP44s36cE_dBQcyDnboUgbUCtjgMnLnZq8c+0qB8GfH9Tq8aA@mail.gmail.com>
	<CAF6AEGvdLsg33yGqTQQ7EWJh_4+rGSPbCZmSSYCib1cSS2pqWg@mail.gmail.com>
	<CAMP44s0EYp1inCHZkAZES7ezOiL7F533-euGQCk83hS_QN-LgQ@mail.gmail.com>
	<CAF6AEGt0qYcWh8_hdygswroWNdiWmVB9-Cv3c00zKn3OSVmD4A@mail.gmail.com>
	<CAMP44s2V3pCFtGvhn8Dxc79gzz+LQ63ozRXQiRi7msHsCf35FQ@mail.gmail.com>
	<CAF6AEGvPNdXCduUU72mFVXsosMr=hur-7yCYwPrnV4=n3Q1tmQ@mail.gmail.com>
	<CAMP44s1HLJ0km1ObfuQ7VDANp9_bDCBtkTiesRxmxiS_Oz5--Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48301 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162Ab2APVZA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jan 2012 16:25:00 -0500
Received: by vcbfo1 with SMTP id fo1so1352607vcb.19
        for <linux-omap@vger.kernel.org>; Mon, 16 Jan 2012 13:24:59 -0800 (PST)
In-Reply-To: <CAMP44s1HLJ0km1ObfuQ7VDANp9_bDCBtkTiesRxmxiS_Oz5--Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, patches@linaro.org

On Mon, Jan 16, 2012 at 2:37 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Mon, Jan 16, 2012 at 7:01 PM, Rob Clark <rob.clark@linaro.org> wro=
te:
>> On Mon, Jan 16, 2012 at 10:59 AM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> On Mon, Jan 16, 2012 at 6:37 PM, Rob Clark <rob.clark@linaro.org> w=
rote:
>>>> On Mon, Jan 16, 2012 at 8:12 AM, Felipe Contreras
>>>> <felipe.contreras@gmail.com> wrote:
>>>>> On Fri, Jan 13, 2012 at 11:19 PM, Rob Clark <rob.clark@linaro.org=
> wrote:
>>>>>> On Fri, Jan 13, 2012 at 2:59 PM, Felipe Contreras
>>>>>> <felipe.contreras@gmail.com> wrote:
>>>>>>> On Fri, Jan 13, 2012 at 10:41 PM, Rob Clark <rob.clark@linaro.o=
rg> wrote:
>>>>>>>> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/=
Makefile
>>>>>>>> index 9a58461..b86e6cb 100644
>>>>>>>> --- a/arch/arm/plat-omap/Makefile
>>>>>>>> +++ b/arch/arm/plat-omap/Makefile
>>>>>>>> @@ -4,7 +4,7 @@
>>>>>>>>
>>>>>>>> =A0# Common support
>>>>>>>> =A0obj-y :=3D common.o sram.o clock.o devices.o dma.o mux.o \
>>>>>>>> - =A0 =A0 =A0 =A0usb.o fb.o counter_32k.o
>>>>>>>> + =A0 =A0 =A0 =A0usb.o fb.o counter_32k.o drm.o
>>>>>>>
>>>>>>> Should be something like this:
>>>>>>> obj-$(CONFIG_DRM_OMAP) +=3D drm.o
>>>>>>
>>>>>> btw, how does that work if CONFIG_DRM_OMAP=3Dm? =A0Do you end up=
 w/ a
>>>>>> plat-omap module?
>>>>>
>>>>> Yes, and platform drivers are supposed to be loaded automatically=
 at
>>>>> boot-time by udev (or similar).
>>>>
>>>> oh, but this won't work, because common.c has to call
>>>> omapdrm_reserve_vram() (similar to how omapfb_reserve_sdram_memblo=
ck()
>>>> works).. so I think it has to stay the way it is in this patch.
>>>
>>> #if defined(CONFIG_DRM_OMAP) || defined(CONFIG_DRM_OMAP_MODULE)
>>> extern void omapdrm_reserve_vram(void);
>>> #else
>>> static inline void omapdrm_reserve_vram(void) { }
>>> #endif
>>>
>>> Like how it's done with DSP stuff.
>>
>> right, but then you'd miss the omapdrm_reserve_vram() call at startu=
p..
>
> Why?

I guess drm.o is ending up in a module, but the code that calls that
(in common.c) is not in a module, so you get an unresolved symbol at
link

BR,
-R

> --
> Felipe Contreras
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
