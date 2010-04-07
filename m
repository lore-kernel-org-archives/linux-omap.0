From: Tar Gz <bsdraisefromhell@gmail.com>
Subject: Re: [ASK] OMAP 3430 LDP Trouble
Date: Thu, 8 Apr 2010 06:13:22 +0700
Message-ID: <k2wd9ca78711004071613pc6f9a3b9v24d05d19d0d8d513@mail.gmail.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0322418AC7@dbde02.ent.ti.com>
	 <m2hce9ab5791004062218w5af7ea03rd9ec33ad7c0c72c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:50353 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757004Ab0DGXNX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 19:13:23 -0400
Received: by vws13 with SMTP id 13so780979vws.19
        for <linux-omap@vger.kernel.org>; Wed, 07 Apr 2010 16:13:22 -0700 (PDT)
In-Reply-To: <m2hce9ab5791004062218w5af7ea03rd9ec33ad7c0c72c9@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "Ghorai, Sukumar" <s-ghorai@ti.com>, linux-omap <linux-omap@vger.kernel.org>

i don't know where i'm missing that,,can i'm using serial boot via
hyperterminal windows?.. because i'm looking from many tutorial always
serial boot from minicom linux

best regards,
Aldyth M

On 4/7/10, Vimal Singh <vimal.newwork@gmail.com> wrote:
> On Wed, Apr 7, 2010 at 1:19 AM, Gadiyar, Anand <gadiyar@ti.com> wrote:
>> Gadiyar, Anand wrote:
>>> Tar Gz wrote:
>>> > if NAND support is currently missing for OMAP3430 LDP,,how i boot my
>>> > ldp again like before?...any idea?
>
> You can still have x-loader and u-boot on NAND (flash them from u-boot
> prompt, once you get booted up by any other method. for example serial
> boot as mentioned by Anand) and use NFS filesystem to work with.
>
> NAND driver support is missing in kernel, so, you will not be able to
> see/mount NAND partitions from kernel.
>
> --
> Regards,
> Vimal Singh
>
>
>>> <snip>
>>>
>>> If I understand you correctly, you now have a non-booting
>>> LDP, and want
>>> to get a bootloader flashed on it?
>>>
>>> You may need to do a serial boot.
>>>
>>> Maybe this (old, and no longer maintained) page will help?
>>>
>>> <https://gforge.ti.com/gf/project/omapzoom/wiki/?pagename=BootingAndFlashing>
>>>
>>
>> Or this one:
>> <http://omappedia.org/wiki/Zoom_Flashing#Serial_Boot_Procedure>
>
