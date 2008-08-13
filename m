From: "Remith Ravi" <remith@mistralsolutions.com>
Subject: Re: USB-webcam support
Date: Wed, 13 Aug 2008 12:40:14 +0530
Message-ID: <814dfab70808130010u62033f97i4bf15e5c03c47df7@mail.gmail.com>
References: <c656a4d20808120332v224c5053r7225c086acd8c2cd@mail.gmail.com>
	 <0680EC522D0CC943BC586913CF3768C00208C15FD8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f29.google.com ([209.85.217.29]:52299 "EHLO
	mail-gx0-f29.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbYHMHKQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Aug 2008 03:10:16 -0400
Received: by gxk10 with SMTP id 10so840847gxk.13
        for <linux-omap@vger.kernel.org>; Wed, 13 Aug 2008 00:10:16 -0700 (PDT)
In-Reply-To: <0680EC522D0CC943BC586913CF3768C00208C15FD8@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: arun c <arunedarath@mistralsolutions.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Aug 12, 2008 at 4:45 PM, Syed Mohammed, Khasim <khasim@ti.com> wrote:
> Hi Arun,
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of arun c
>> Sent: Tuesday, August 12, 2008 4:02 PM
>> To: linux-omap@vger.kernel.org
>> Subject: USB-webcam support
>>
>> Hi All,
>>
>> If I have a USB camera with good Linux support, can I connect it
>> to omap3evm(or any omap2) and make it functional?
>>
> Yes you can, I have tried Logitech LZ708BC on Beagle board and it works good at 160x120 resolution.
>
> You just need UVC driver, which I think is part of latest kernel.


Is it using USB Isochronous transfer? I checked the web. There is no
information regarding the given camera model.

Regards,
Remith


>
> Regards,
> Khasim
> http://khasim.blogspot.com
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
