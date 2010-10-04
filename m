From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: NOTE: hwmod changes merged to linux-omap master for testing
Date: Mon, 4 Oct 2010 14:50:11 +0530
Message-ID: <AANLkTi=Ek+m_AMx2-jOgkGOeMYjKFmTrCMjZ=2r+G67q@mail.gmail.com>
References: <20101002004821.GN3117@atomide.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C96B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41465 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754153Ab0JDJUM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 05:20:12 -0400
Received: by wyb28 with SMTP id 28so4697211wyb.19
        for <linux-omap@vger.kernel.org>; Mon, 04 Oct 2010 02:20:11 -0700 (PDT)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C96B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Oct 4, 2010 at 1:19 PM, G, Manjunath Kondaiah <manjugk@ti.com> =
wrote:
> Hi Tony,
> With latest merges on master branch with commit ID:
> 0882b1455797b0a104978000a622c3f2412e7cf5 omap: READ CAREFULLY: Fix bu=
ild after merging in hwmod support for testing
>
> Booting with zoom3 seems to be fine but observed issues with omap4 bl=
aze board.
>
> Looks like multiple warning dumps and finally it crashes after "Freei=
ng init memory" with both NFS and ramdisk file systems.

This issue though seems to exist much before hwmod merge, I tried
below commit on master

commit 2365f1f7e5544b531ccd3e07fd06bb12bf7a62a7
Merge: acc012f 391bcdd
Author: Tony Lindgren <tony@atomide.com>
Date:   Wed Sep 29 11:19:10 2010 -0700

Issue still reproducible.
I used 4430SDP with es2.0

Not sure what is happening though.

http://pastebin.com/LZKaAztT

---
Regards,
Govindraj.R


>
> The complete bootlogs are available at:
> NFS bootlog:
> http://pastebin.com/nrWQ5FGG
>
> Ramdisk bootlog:
> http://pastebin.com/1F75d2Ew
>
> -Manjunath
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony Lindgren
>> Sent: Saturday, October 02, 2010 6:18 AM
>> To: linux-omap@vger.kernel.org
>> Subject: NOTE: hwmod changes merged to linux-omap master for testing
>>
>> Hi all,
>>
>> So I've finally merged Kevin's hwmod branch into the
>> linux-omap master so we can give it some testing to see if we
>> can merge it to the mainline. Might take few minutes to hit
>> the mirrors.
>>
>> Please note that for omap2plus machines you need to change:
>>
>> - u-boot bootargs for kernel cmdline needs to change with setenv
>> - if you use hardcoded CONFIG_CMDLINE, change it in your .config
>> - /etc/inittab in your omap root file system if using serial console
>>
>> This is because otherwise the serial-omap would be
>> conflicting with the 8250 driver. This should not affect
>> omap1 machines.
>>
>> Please give it a try and report any issues on this list! Now
>> all the machines except ams_delta_defconfig should build.
>> That one is still missing some camera driver changes to build.
>>
>> Regards,
>>
>> Tony
>> --
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-omap" in the body of a message to
>> majordomo@vger.kernel.org More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
>> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
