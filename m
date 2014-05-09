From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: Remove suspend_set_ops from common pm late init
Date: Fri, 9 May 2014 15:38:15 -0500
Message-ID: <CAGo_u6o8uWB7zycuYa=3BQU8K2=S1YPWqHA49-CopdSERxGiRw@mail.gmail.com>
References: <1399661580-54599-1-git-send-email-d-gerlach@ti.com>
	<536D26C6.1060903@ti.com>
	<536D37C0.1000704@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:59322 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756796AbaEIUiQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 May 2014 16:38:16 -0400
Received: by mail-wg0-f42.google.com with SMTP id y10so4379498wgg.25
        for <linux-omap@vger.kernel.org>; Fri, 09 May 2014 13:38:15 -0700 (PDT)
In-Reply-To: <536D37C0.1000704@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, May 9, 2014 at 3:17 PM, Dave Gerlach <d-gerlach@ti.com> wrote:
> On 05/09/2014 02:04 PM, Nishanth Menon wrote:
>>
>> On 05/09/2014 01:53 PM, Dave Gerlach wrote:

>>> +#ifdef CONFIG_SUSPEND
>>> +void omap_common_suspend_init(void);
>>> +#else
>>> +static inline void omap_common_suspend_init(void)
>>> +{
>>> +}
>>> +#endif
>>> +
>>
>> push this off to this pm.h?
>
>
> I could, I had just put it in the same spot as omap2_common_pm_late_init. I
> agree it makes sense to move it though.
>

yeah - the usage in the case of suspend_init is restricted solely to
pm code.. generic code does not have to invoke it.

Regards,
Nishanth Menon
