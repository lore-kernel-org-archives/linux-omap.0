From: Ezequiel Garcia <elezegarcia@gmail.com>
Subject: Re: [PATCH] arm: omap3: igep0020: Add console default kernel arguments
Date: Sat, 22 Dec 2012 11:17:44 -0300
Message-ID: <CALF0-+UWx-cP7tcZ_L3dHaJREgi9R7-hD23z2wjD5N5ftROQpw@mail.gmail.com>
References: <1356018118-29852-1-git-send-email-ezequiel.garcia@free-electrons.com>
	<CAFqH_50ELkdXhVwW8atG0VsXU85S3pZqCVf9cytQRGk5SocFXw@mail.gmail.com>
	<CAAwP0s1snYU7FR-BVM=GLg0oopT6NkBVLOysffia0dadsxW+BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f180.google.com ([209.85.210.180]:55820 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab2LVORp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 Dec 2012 09:17:45 -0500
Received: by mail-ia0-f180.google.com with SMTP id t4so4729501iag.39
        for <linux-omap@vger.kernel.org>; Sat, 22 Dec 2012 06:17:44 -0800 (PST)
In-Reply-To: <CAAwP0s1snYU7FR-BVM=GLg0oopT6NkBVLOysffia0dadsxW+BQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Javier Martinez Canillas <javier@dowhile0.org>

Hi Enric and Javier,

>> The u-boot 'bootargs' env overwrites the one from chosen ?
>>
>
> I just tested and U-Boot 'bootargs' has precedence over DT bootargs
> but I didn't find a way to append boot parameters from U-Boot. You can
> either overwrite it completely or not.
>

Yes. That seems to be the current case.
Perhaps we can merge
ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER
and CMDLINE_EXTEND in one generic config stating
the desired bootargs behavior.

Does this sound sane?

> That been said I think that is a good idea to have some default
> bootargs on the DT but since you can't append any boot option from
> U-Boot I would also add root=/dev/mmcblk0p2 rw rootwait so at least it
> will be able to mount the rootfs from the uSD/MMC.
>

True. Will re-send with those.

> Also, many IGEP COM Module base boards also have serial consoles that
> are connected to the OMAP3 UART3 (ttyO2), so maybe is better to add
> this to omap3-igep.dtsi instead of omap3-igep0020.dts to avoid future
> duplication.
>

Ok.

Thanks and merry xmas,

    Ezequiel
