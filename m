From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH] arm: omap3: igep0020: Add console default kernel arguments
Date: Sun, 23 Dec 2012 19:22:19 +0100
Message-ID: <CAAwP0s1vgrsho12CtejnoBo4biTN-VF_m_oqm+CD95AemhEHyg@mail.gmail.com>
References: <1356018118-29852-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <CAFqH_50ELkdXhVwW8atG0VsXU85S3pZqCVf9cytQRGk5SocFXw@mail.gmail.com>
 <CAAwP0s1snYU7FR-BVM=GLg0oopT6NkBVLOysffia0dadsxW+BQ@mail.gmail.com> <CALF0-+UWx-cP7tcZ_L3dHaJREgi9R7-hD23z2wjD5N5ftROQpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:39998 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599Ab2LWSWk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Dec 2012 13:22:40 -0500
Received: by mail-oa0-f45.google.com with SMTP id i18so6303017oag.18
        for <linux-omap@vger.kernel.org>; Sun, 23 Dec 2012 10:22:39 -0800 (PST)
In-Reply-To: <CALF0-+UWx-cP7tcZ_L3dHaJREgi9R7-hD23z2wjD5N5ftROQpw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <elezegarcia@gmail.com>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Javier Martinez Canillas <javier@dowhile0.org>

On Sat, Dec 22, 2012 at 3:17 PM, Ezequiel Garcia <elezegarcia@gmail.com> wrote:
> Hi Enric and Javier,
>
>>> The u-boot 'bootargs' env overwrites the one from chosen ?
>>>
>>
>> I just tested and U-Boot 'bootargs' has precedence over DT bootargs
>> but I didn't find a way to append boot parameters from U-Boot. You can
>> either overwrite it completely or not.
>>
>
> Yes. That seems to be the current case.
> Perhaps we can merge
> ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER
> and CMDLINE_EXTEND in one generic config stating
> the desired bootargs behavior.
>
> Does this sound sane?
>

Hi Ezequiel,

You could enable ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER on
omap2plus_defconfig but just having a sane DTB bootargs default value
is better IMHO.

Best regards,
Javier
