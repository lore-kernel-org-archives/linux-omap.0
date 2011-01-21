From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH] omap3: nand: bch ecc support added
Date: Fri, 21 Jan 2011 13:07:44 +0530
Message-ID: <AANLkTi=0ZuG6i3x4uZ2+R8ZVmvmydrvK2zZQJbLoz=4L@mail.gmail.com>
References: <1295518680-8737-1-git-send-email-s-ghorai@ti.com>
 <AANLkTin3pRkqLkQ_J1iTtqr0M+iz5V25S9ZwJc9+T0VW@mail.gmail.com> <2A3DCF3DA181AD40BDE86A3150B27B6B036A8DAF6C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:39629 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331Ab1AUHiF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Jan 2011 02:38:05 -0500
Received: by qwa26 with SMTP id 26so1506800qwa.19
        for <linux-omap@vger.kernel.org>; Thu, 20 Jan 2011 23:38:04 -0800 (PST)
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B036A8DAF6C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Kamat, Nishant" <nskamat@ti.com>

On Fri, Jan 21, 2011 at 9:37 AM, Ghorai, Sukumar <s-ghorai@ti.com> wrote:
>
>> -----Original Message-----
>> From: Vimal Singh [mailto:vimal.newwork@gmail.com]
>> Sent: Thursday, January 20, 2011 8:47 PM
>> To: Ghorai, Sukumar
>> Cc: linux-omap@vger.kernel.org; linux-mtd@lists.infradead.org; linux-arm-
>> kernel@lists.infradead.org; Kamat, Nishant
>> Subject: Re: [PATCH] omap3: nand: bch ecc support added
>>
>> Hi Ghorai,
>>
>> I am the initial author of this patch. And I guess this patch still
>> uses most of my work.
> [Ghorai] I know you are working on it,
>
> But I think your code was in a shape for -
> 1. not for up-streamble shape
That's because I never posted it for up-stream.

> 2. non functional,
No, it was a working (at least for 8-bit correction) patch on that
kernel version (I do not remember the correct version now, may be
.29-.30)
It did not work for 4-bit, because of known reason. And I guess while
posting this patch you should also have mentioned/documented about
that. No?

> So can you check this version matching with your original code?
> In that case I can add your Signed-off.
Yes, you should. I can see this version has got many changes, but
original idea is same. And not all code is changed. Does it?

Regards,
Vimal
