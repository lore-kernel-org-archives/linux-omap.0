From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: Re: [RFC] About ARM expansion boards and others things
Date: Wed, 4 May 2011 12:46:47 +0200
Message-ID: <BANLkTingDTjKKHqCcWsms7C+QugVxZQc9w@mail.gmail.com>
References: <BANLkTimjWtqLsWA1Gthix6RZYMzNRdC7rg@mail.gmail.com>
	<4DC12A59.2010608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34200 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab1EDKqs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 06:46:48 -0400
In-Reply-To: <4DC12A59.2010608@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vladimir Pantelic <vladoman@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm@vger.kernel.org

2011/5/4 Vladimir Pantelic <vladoman@gmail.com>:
> Enric Balletb=C3=B2 i Serra wrote:
>>
>> Hi guys,
>> I'm thinking probably in a crazy idea, I hope someone can help me or
>> kill definitely this idea from my mind.
>>
>> I'll explain a little more, the real problem is I don't know how to
>> add support for an expansion board for IGEP v2 board. I see most of
>> boards adds the support inside the board-xxxxx.c file, for example i=
f
>> the expansion board has a Touchscreen interface using ADS7846/TSC204=
6
>> they register ads7846 platform data in board-xxxx.c file. This is ok
>> beacause the ads7846 can be detected and if expansion board is not
>> present =C2=A0the detection fails, but maybe other devices in expans=
ion
>> board can't be detected (for example an I/O expansion). So which is
>> the best form to do this ?
>>
>> I'm thinking in create a kernel module for the expansion board that
>> add all the new features, the expansion board should come with a I2C
>> E2PROM for board ID storage, so the idea is create an i2c driver tha=
t
>> reads the E2PROM and if found the Board ID inits all the expansion
>> board devices.
>
> don't know if you are aware of that:
>
> http://elinux.org/BeagleBoardPinMux#Expansion_boards
>

Yes I know it.

> also beagle.c board file has support for some expansion boards
> already, maybe there is some code to be shared.
>
>

But I don't see any support for expansion board in board-omap3beagle.c
  http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
blob;f=3Darch/arm/mach-omap2/board-omap3beagle.c;h=3D33007fd4a0835fd298=
129c9fda30b844707cc08b;hb=3DHEAD

i see some patches (not published in mainline) that are reading a
kernel cmdline. I mean,  the bootloader (u-boot) detects if an
expansion board is present (mostly via i2c) and then add to the kernel
cmdline a parameter with the name of the expansion board. The kernel
reads this parameter and initializes the expansion board devices.

But not sure if this is a good solution. What solution do you think is
better ? Using kernel cmdline or create a separate kernel module for
every expansion board ?

In fact the purpose of this email is discuss a bit which is the proper
solution to add an expansion board to the kernel mainline.

Regards,
   Enric
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
