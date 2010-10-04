From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: beagle hangs in uart3 disabling clocks
Date: Mon, 4 Oct 2010 18:08:21 +0530
Message-ID: <AANLkTi=C55AbJhCWkFAM06vL2c5UM=aH3z2r8i4_55Mk@mail.gmail.com>
References: <AANLkTi=9T=5swvF2UcrfDAL8cpHOcfpOU3Fi1O50Z6Tm@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB593023412B5A0@dbde02.ent.ti.com>
	<4CA9C5F6.7060902@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39835 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408Ab0JDMiW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 08:38:22 -0400
Received: by wyb28 with SMTP id 28so4835440wyb.19
        for <linux-omap@vger.kernel.org>; Mon, 04 Oct 2010 05:38:21 -0700 (PDT)
In-Reply-To: <4CA9C5F6.7060902@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pramod <pramod.gurav@ti.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, Ming Lei <tom.leiming@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I tried now on zoom3 with uart3[ttyO2] as console

It boots up fine for me

Logs:

http://pastebin.com/sXR5nYcD

I am using omap2plus_defconfig and lo-master

commit 0882b1455797b0a104978000a622c3f2412e7cf5
Author: Tony Lindgren <tony@atomide.com>
Date:   Fri Oct 1 17:23:48 2010 -0700

    omap: READ CAREFULLY: Fix build after merging in hwmod support for =
testing


---
Regards,
Govindraj.R



On Mon, Oct 4, 2010 at 5:47 PM, Pramod <pramod.gurav@ti.com> wrote:
> Hi Sanjeev,
>>>
>>> I just tested pm branch of tony's linux-omap-2.6 tree, and found my
>>> beagle will hang in uart3 disabling clocks, follows the log info:
>>>
>>>
>> [snip]..[snip]
>>
>>>
>>> Texas Instruments X-Loader 1.41
>>> Starting OS Bootloader...
>>>
>>>
>>> U-Boot 1.3.3 (Jul 10 2008 - 16:33:09)
>>>
>>> OMAP3530-GP rev 2, CPU-OPP2 L3-165MHz
>>> OMAP3 Beagle Board + LPDDR/NAND
>>> DRAM: =A0128 MB
>>> NAND:
>>
>> Lei,
>>
>> Couldn't help noticing the version information for x-loader and
>> u-boot. Both seem to be quite old...
>>
>> Could you try update both? May be, there is a dependency...
>>
> I am seeing the same issue with console on UART3 on zoom3 board. The
> bootloaders are older. Can you please share a link to latest bootload=
er
> which will have zoom3 support.
>
> I am using L25_INC3.x android kernel. The board hangs as soon as it b=
oots
> the kernel. Enabling the logs shows us that the hang occurs when UART=
3
> clocks are being disabled in omap_hwmod.c as mentioned by Lei Ming. H=
as
> anyone observed this issue on any of omap boards?
>
>> ~sanjeev
>>
>>>
> --
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
