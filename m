From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] omap2+: add drm device
Date: Mon, 16 Jan 2012 18:59:15 +0200
Message-ID: <CAMP44s2V3pCFtGvhn8Dxc79gzz+LQ63ozRXQiRi7msHsCf35FQ@mail.gmail.com>
References: <1326487320-8781-1-git-send-email-rob.clark@linaro.org>
	<CAMP44s36cE_dBQcyDnboUgbUCtjgMnLnZq8c+0qB8GfH9Tq8aA@mail.gmail.com>
	<CAF6AEGvdLsg33yGqTQQ7EWJh_4+rGSPbCZmSSYCib1cSS2pqWg@mail.gmail.com>
	<CAMP44s0EYp1inCHZkAZES7ezOiL7F533-euGQCk83hS_QN-LgQ@mail.gmail.com>
	<CAF6AEGt0qYcWh8_hdygswroWNdiWmVB9-Cv3c00zKn3OSVmD4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:45450 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752654Ab2APQ7R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jan 2012 11:59:17 -0500
Received: by lahc1 with SMTP id c1so1017037lah.19
        for <linux-omap@vger.kernel.org>; Mon, 16 Jan 2012 08:59:16 -0800 (PST)
In-Reply-To: <CAF6AEGt0qYcWh8_hdygswroWNdiWmVB9-Cv3c00zKn3OSVmD4A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, patches@linaro.org

On Mon, Jan 16, 2012 at 6:37 PM, Rob Clark <rob.clark@linaro.org> wrote=
:
> On Mon, Jan 16, 2012 at 8:12 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Fri, Jan 13, 2012 at 11:19 PM, Rob Clark <rob.clark@linaro.org> w=
rote:
>>> On Fri, Jan 13, 2012 at 2:59 PM, Felipe Contreras
>>> <felipe.contreras@gmail.com> wrote:
>>>> On Fri, Jan 13, 2012 at 10:41 PM, Rob Clark <rob.clark@linaro.org>=
 wrote:
>>>>> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Mak=
efile
>>>>> index 9a58461..b86e6cb 100644
>>>>> --- a/arch/arm/plat-omap/Makefile
>>>>> +++ b/arch/arm/plat-omap/Makefile
>>>>> @@ -4,7 +4,7 @@
>>>>>
>>>>> =C2=A0# Common support
>>>>> =C2=A0obj-y :=3D common.o sram.o clock.o devices.o dma.o mux.o \
>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0usb.o fb.o counter_32k.o
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0usb.o fb.o counter_32k.o drm.o
>>>>
>>>> Should be something like this:
>>>> obj-$(CONFIG_DRM_OMAP) +=3D drm.o
>>>
>>> btw, how does that work if CONFIG_DRM_OMAP=3Dm? =C2=A0Do you end up=
 w/ a
>>> plat-omap module?
>>
>> Yes, and platform drivers are supposed to be loaded automatically at
>> boot-time by udev (or similar).
>
> oh, but this won't work, because common.c has to call
> omapdrm_reserve_vram() (similar to how omapfb_reserve_sdram_memblock(=
)
> works).. so I think it has to stay the way it is in this patch.

#if defined(CONFIG_DRM_OMAP) || defined(CONFIG_DRM_OMAP_MODULE)
extern void omapdrm_reserve_vram(void);
#else
static inline void omapdrm_reserve_vram(void) { }
#endif

Like how it's done with DSP stuff.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
