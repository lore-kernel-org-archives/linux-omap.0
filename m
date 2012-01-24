From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] omap2+: add drm device
Date: Tue, 24 Jan 2012 17:33:12 +0200
Message-ID: <CAMP44s2AaSbdRCNQidjp9boRvGLe5-fTUSLB7br106qzCdRA6A@mail.gmail.com>
References: <1326487320-8781-1-git-send-email-rob.clark@linaro.org>
	<CAMP44s36cE_dBQcyDnboUgbUCtjgMnLnZq8c+0qB8GfH9Tq8aA@mail.gmail.com>
	<CAF6AEGvdLsg33yGqTQQ7EWJh_4+rGSPbCZmSSYCib1cSS2pqWg@mail.gmail.com>
	<CAMP44s0EYp1inCHZkAZES7ezOiL7F533-euGQCk83hS_QN-LgQ@mail.gmail.com>
	<CAF6AEGt0qYcWh8_hdygswroWNdiWmVB9-Cv3c00zKn3OSVmD4A@mail.gmail.com>
	<CAMP44s2V3pCFtGvhn8Dxc79gzz+LQ63ozRXQiRi7msHsCf35FQ@mail.gmail.com>
	<CAF6AEGvPNdXCduUU72mFVXsosMr=hur-7yCYwPrnV4=n3Q1tmQ@mail.gmail.com>
	<CAMP44s1HLJ0km1ObfuQ7VDANp9_bDCBtkTiesRxmxiS_Oz5--Q@mail.gmail.com>
	<CAF6AEGv2pDDdAJrWAifCOC7=nHa+-48Fdq+Q5Kv3wHHFj_c8Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:35478 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752096Ab2AXPdN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 10:33:13 -0500
Received: by lagu2 with SMTP id u2so86184lag.19
        for <linux-omap@vger.kernel.org>; Tue, 24 Jan 2012 07:33:12 -0800 (PST)
In-Reply-To: <CAF6AEGv2pDDdAJrWAifCOC7=nHa+-48Fdq+Q5Kv3wHHFj_c8Nw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, patches@linaro.org

On Mon, Jan 16, 2012 at 11:24 PM, Rob Clark <rob.clark@linaro.org> wrote:
> On Mon, Jan 16, 2012 at 2:37 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Mon, Jan 16, 2012 at 7:01 PM, Rob Clark <rob.clark@linaro.org> wrote:
>>> On Mon, Jan 16, 2012 at 10:59 AM, Felipe Contreras
>>> <felipe.contreras@gmail.com> wrote:
>>>> #if defined(CONFIG_DRM_OMAP) || defined(CONFIG_DRM_OMAP_MODULE)
>>>> extern void omapdrm_reserve_vram(void);
>>>> #else
>>>> static inline void omapdrm_reserve_vram(void) { }
>>>> #endif
>>>>
>>>> Like how it's done with DSP stuff.
>>>
>>> right, but then you'd miss the omapdrm_reserve_vram() call at startup..
>>
>> Why?
>
> I guess drm.o is ending up in a module, but the code that calls that
> (in common.c) is not in a module, so you get an unresolved symbol at
> link

Right... But that code can be moved as well. Just like with the bridge.

-- 
Felipe Contreras
