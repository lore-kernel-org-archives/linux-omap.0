From: Constantine Shulyupin <const@makelinux.com>
Subject: Re: booting pandaboard with dtb
Date: Mon, 22 Oct 2012 12:08:53 +0200
Message-ID: <CAE7jHC_Ghq800r1ep5xAzyHj2C0sZxzHfZU371yE4vrqvL=Gtg@mail.gmail.com>
References: <CAE7jHC8v-M48mrA6J3tAzSSHVW+1FBvPzTVW5cWS_oRnj9hduw@mail.gmail.com>
	<5084D9A5.1060704@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:52514 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451Ab2JVKIx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Oct 2012 06:08:53 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so2231388oag.19
        for <linux-omap@vger.kernel.org>; Mon, 22 Oct 2012 03:08:53 -0700 (PDT)
In-Reply-To: <5084D9A5.1060704@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kishon <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, Tim Bird <tim.bird@am.sony.com>

I found it works only with
fdt addr 0x90000000
and precompiled linaro u-boot

On Mon, Oct 22, 2012 at 7:29 AM, kishon <kishon@ti.com> wrote:
> Hi,
>
>
> On Monday 22 October 2012 03:58 AM, Constantine Shulyupin wrote:
>>
>> Hi,
>>
>> Tell me please, which u-boot and u-boot configuration to use to boot
>> latest kernel with omap4-panda.dtb ?
>
>
> denx u-boot (git://git.denx.de/u-boot.git) should do. Do you face any
> issues?
>
> Thanks
> Kishon



-- 
Constantine Shulyupin
http://www.MakeLinux.com/
Embedded Linux Systems,
Device Drivers, TI DaVinci
