From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [ASK] OMAP 3430 LDP Trouble
Date: Wed, 7 Apr 2010 10:48:31 +0530
Message-ID: <m2hce9ab5791004062218w5af7ea03rd9ec33ad7c0c72c9@mail.gmail.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0322418AC7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f179.google.com ([209.85.221.179]:36274 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854Ab0DGFSx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 01:18:53 -0400
Received: by qyk9 with SMTP id 9so793250qyk.1
        for <linux-omap@vger.kernel.org>; Tue, 06 Apr 2010 22:18:52 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0322418AC7@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Tar Gz <bsdraisefromhell@gmail.com>, "Ghorai, Sukumar" <s-ghorai@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Wed, Apr 7, 2010 at 1:19 AM, Gadiyar, Anand <gadiyar@ti.com> wrote:
> Gadiyar, Anand wrote:
>> Tar Gz wrote:
>> > if NAND support is currently missing for OMAP3430 LDP,,how i boot my
>> > ldp again like before?...any idea?

You can still have x-loader and u-boot on NAND (flash them from u-boot
prompt, once you get booted up by any other method. for example serial
boot as mentioned by Anand) and use NFS filesystem to work with.

NAND driver support is missing in kernel, so, you will not be able to
see/mount NAND partitions from kernel.

-- 
Regards,
Vimal Singh


>> <snip>
>>
>> If I understand you correctly, you now have a non-booting
>> LDP, and want
>> to get a bootloader flashed on it?
>>
>> You may need to do a serial boot.
>>
>> Maybe this (old, and no longer maintained) page will help?
>>
>> <https://gforge.ti.com/gf/project/omapzoom/wiki/?pagename=BootingAndFlashing>
>>
>
> Or this one:
> <http://omappedia.org/wiki/Zoom_Flashing#Serial_Boot_Procedure>
