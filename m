From: Ezequiel Garcia <elezegarcia@gmail.com>
Subject: Re: [PATCH] arm: omap3: igep0020: Add console default kernel arguments
Date: Sun, 23 Dec 2012 18:27:57 -0300
Message-ID: <CALF0-+UU8jujgtmzdaXgGLgDSD5Gr3z9oAqzFEorsvvXsA4pvw@mail.gmail.com>
References: <1356018118-29852-1-git-send-email-ezequiel.garcia@free-electrons.com>
	<CAFqH_50ELkdXhVwW8atG0VsXU85S3pZqCVf9cytQRGk5SocFXw@mail.gmail.com>
	<CAAwP0s1snYU7FR-BVM=GLg0oopT6NkBVLOysffia0dadsxW+BQ@mail.gmail.com>
	<CALF0-+UWx-cP7tcZ_L3dHaJREgi9R7-hD23z2wjD5N5ftROQpw@mail.gmail.com>
	<CAAwP0s1vgrsho12CtejnoBo4biTN-VF_m_oqm+CD95AemhEHyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:54042 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077Ab2LWV16 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Dec 2012 16:27:58 -0500
Received: by mail-ie0-f172.google.com with SMTP id c13so8279217ieb.17
        for <linux-omap@vger.kernel.org>; Sun, 23 Dec 2012 13:27:57 -0800 (PST)
In-Reply-To: <CAAwP0s1vgrsho12CtejnoBo4biTN-VF_m_oqm+CD95AemhEHyg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Javier Martinez Canillas <javier@dowhile0.org>

On Sun, Dec 23, 2012 at 3:22 PM, Javier Martinez Canillas
<martinez.javier@gmail.com> wrote:
> On Sat, Dec 22, 2012 at 3:17 PM, Ezequiel Garcia <elezegarcia@gmail.com> wrote:
>> Hi Enric and Javier,
>>
>>>> The u-boot 'bootargs' env overwrites the one from chosen ?
>>>>
>>>
>>> I just tested and U-Boot 'bootargs' has precedence over DT bootargs
>>> but I didn't find a way to append boot parameters from U-Boot. You can
>>> either overwrite it completely or not.
>>>
>>
>> Yes. That seems to be the current case.
>> Perhaps we can merge
>> ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER
>> and CMDLINE_EXTEND in one generic config stating
>> the desired bootargs behavior.
>>
>> Does this sound sane?
>>
>
> Hi Ezequiel,
>
> You could enable ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER on
> omap2plus_defconfig

Actually, ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER depends
on ARM_ATAG_DTB_COMPAT being selected and it's only compatibility
stuff for bootloaders non DTB capable.

I don't think we should add that to omap2plus_defconfig.

> but just having a sane DTB bootargs default value
> is better IMHO.
>

Agreed. I'll send a v2 with your proposed default command line.


-- 
    Ezequiel
