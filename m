From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH 1/2] omap2+: add drm device
Date: Wed, 25 Jan 2012 07:51:09 -0600
Message-ID: <CAF6AEGuSSeFTurTXmBj3-zo4CgScO+KkbbYnq55wQ8r-PrEoYg@mail.gmail.com>
References: <1326487320-8781-1-git-send-email-rob.clark@linaro.org>
	<CAMP44s36cE_dBQcyDnboUgbUCtjgMnLnZq8c+0qB8GfH9Tq8aA@mail.gmail.com>
	<CAF6AEGvdLsg33yGqTQQ7EWJh_4+rGSPbCZmSSYCib1cSS2pqWg@mail.gmail.com>
	<CAMP44s0EYp1inCHZkAZES7ezOiL7F533-euGQCk83hS_QN-LgQ@mail.gmail.com>
	<CAF6AEGt0qYcWh8_hdygswroWNdiWmVB9-Cv3c00zKn3OSVmD4A@mail.gmail.com>
	<CAMP44s2V3pCFtGvhn8Dxc79gzz+LQ63ozRXQiRi7msHsCf35FQ@mail.gmail.com>
	<CAF6AEGvPNdXCduUU72mFVXsosMr=hur-7yCYwPrnV4=n3Q1tmQ@mail.gmail.com>
	<CAMP44s1HLJ0km1ObfuQ7VDANp9_bDCBtkTiesRxmxiS_Oz5--Q@mail.gmail.com>
	<CAF6AEGv2pDDdAJrWAifCOC7=nHa+-48Fdq+Q5Kv3wHHFj_c8Nw@mail.gmail.com>
	<CAMP44s2AaSbdRCNQidjp9boRvGLe5-fTUSLB7br106qzCdRA6A@mail.gmail.com>
	<CAN_cFWNCr+GKdDHsx4g+S8VHg37137F8Eiu-TKvgK9EGfoVF_A@mail.gmail.com>
	<CAMP44s0fWAFmamBxAebtdeh7qxX47MY0y6s1h0os9g1iGNTYtQ@mail.gmail.com>
	<CAF6AEGs_PjK8fY4FUwTSmigrHXzqG0X-g=DEg-YwzpvTe7ai3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35559 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314Ab2AYNvJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jan 2012 08:51:09 -0500
Received: by iacb35 with SMTP id b35so6821104iac.19
        for <linux-omap@vger.kernel.org>; Wed, 25 Jan 2012 05:51:09 -0800 (PST)
In-Reply-To: <CAF6AEGs_PjK8fY4FUwTSmigrHXzqG0X-g=DEg-YwzpvTe7ai3w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, patches@linaro.org

On Tue, Jan 24, 2012 at 8:32 PM, Rob Clark <rob.clark@linaro.org> wrote=
:
> On Tue, Jan 24, 2012 at 8:17 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Tue, Jan 24, 2012 at 5:54 PM, Rob Clark <rob.clark@linaro.org> wr=
ote:
>>> On Tue, Jan 24, 2012 at 9:33 AM, Felipe Contreras
>>> <felipe.contreras@gmail.com> wrote:
>>>> On Mon, Jan 16, 2012 at 11:24 PM, Rob Clark <rob.clark@linaro.org>=
 wrote:
>>>>> On Mon, Jan 16, 2012 at 2:37 PM, Felipe Contreras
>>>>> <felipe.contreras@gmail.com> wrote:
>>>>>> On Mon, Jan 16, 2012 at 7:01 PM, Rob Clark <rob.clark@linaro.org=
> wrote:
>>>>>>> On Mon, Jan 16, 2012 at 10:59 AM, Felipe Contreras
>>>>>>> <felipe.contreras@gmail.com> wrote:
>>>>>>>> #if defined(CONFIG_DRM_OMAP) || defined(CONFIG_DRM_OMAP_MODULE=
)
>>>>>>>> extern void omapdrm_reserve_vram(void);
>>>>>>>> #else
>>>>>>>> static inline void omapdrm_reserve_vram(void) { }
>>>>>>>> #endif
>>>>>>>>
>>>>>>>> Like how it's done with DSP stuff.
>>>>>>>
>>>>>>> right, but then you'd miss the omapdrm_reserve_vram() call at s=
tartup..
>>>>>>
>>>>>> Why?
>>>>>
>>>>> I guess drm.o is ending up in a module, but the code that calls t=
hat
>>>>> (in common.c) is not in a module, so you get an unresolved symbol=
 at
>>>>> link
>>>>
>>>> Right... But that code can be moved as well. Just like with the br=
idge.
>>>
>>> Hmm, looks like for dsp bridge the memory reservation is moved to
>>> devices.c. =A0Although I'm not entirely sure how that is better... =
and
>>> there is precedent for both approaches, ie. omapfb works like omapd=
rm,
>>> and tidspbridge works as you suggest.
>>>
>>> seems a bit bikeshed'ish to me
>>
>> I will send a patch to fix omapfb, perhaps after that it will be a b=
it
>> more clear how it should be done :) (if it gets accepted)
>
> ok, but the thing I don't like is it splits up the drm device setup
> from the omapdrm_reserve_vram() part (and similarly for omapfb),
>
> but if this is the consensus of how it should be done, well.. when in
> Rome, and all that

oh, sorry, I am mistaken, the oampdrm_reserve_vram() cannot be split
into devices.c, since you need the 'struct device *' to register the
CMA region.  I'd ask that you don't patch omapfb to "fix" it because
this would have to be undone once CMA is merged (since we should then
remove omap_vram and other carveout mechanism and use CMA instead)

BR,
-R

> BR,
> -R
>
>> --
>> Felipe Contreras
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> http://lists.freedesktop.org/mailman/listinfo/dri-devel
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
