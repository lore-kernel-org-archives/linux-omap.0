From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH 1/2] omap2+: add drm device
Date: Tue, 24 Jan 2012 09:54:55 -0600
Message-ID: <CAN_cFWNCr+GKdDHsx4g+S8VHg37137F8Eiu-TKvgK9EGfoVF_A@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:37631 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753311Ab2AXPy4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jan 2012 10:54:56 -0500
Received: by qcsg15 with SMTP id g15so128174qcs.19
        for <linux-omap@vger.kernel.org>; Tue, 24 Jan 2012 07:54:56 -0800 (PST)
In-Reply-To: <CAMP44s2AaSbdRCNQidjp9boRvGLe5-fTUSLB7br106qzCdRA6A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, patches@linaro.org

On Tue, Jan 24, 2012 at 9:33 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Mon, Jan 16, 2012 at 11:24 PM, Rob Clark <rob.clark@linaro.org> wrote:
>> On Mon, Jan 16, 2012 at 2:37 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> On Mon, Jan 16, 2012 at 7:01 PM, Rob Clark <rob.clark@linaro.org> wrote:
>>>> On Mon, Jan 16, 2012 at 10:59 AM, Felipe Contreras
>>>> <felipe.contreras@gmail.com> wrote:
>>>>> #if defined(CONFIG_DRM_OMAP) || defined(CONFIG_DRM_OMAP_MODULE)
>>>>> extern void omapdrm_reserve_vram(void);
>>>>> #else
>>>>> static inline void omapdrm_reserve_vram(void) { }
>>>>> #endif
>>>>>
>>>>> Like how it's done with DSP stuff.
>>>>
>>>> right, but then you'd miss the omapdrm_reserve_vram() call at startup..
>>>
>>> Why?
>>
>> I guess drm.o is ending up in a module, but the code that calls that
>> (in common.c) is not in a module, so you get an unresolved symbol at
>> link
>
> Right... But that code can be moved as well. Just like with the bridge.

Hmm, looks like for dsp bridge the memory reservation is moved to
devices.c.  Although I'm not entirely sure how that is better... and
there is precedent for both approaches, ie. omapfb works like omapdrm,
and tidspbridge works as you suggest.

seems a bit bikeshed'ish to me

BR,
-R

> --
> Felipe Contreras
