From: "Manuel, Lesly Arackal" <leslyam@ti.com>
Subject: Re: [PATCH v10 4/7] MFD: TWL4030: power scripts for OMAP3 boards
Date: Tue, 24 May 2011 17:47:07 +0530
Message-ID: <BANLkTi=8mzg3FxJpJqLFgYsk9hrS5tcEag@mail.gmail.com>
References: <1304687833-4578-1-git-send-email-leslyam@ti.com>
	<1304687833-4578-5-git-send-email-leslyam@ti.com>
	<20110513183958.GY8970@sortiz-mobl>
	<BANLkTi=c9naYFuuRbNG8FK6WuKWVBp0DKg@mail.gmail.com>
	<20110522214036.GO18610@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:48654 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755915Ab1EXMRI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 May 2011 08:17:08 -0400
Received: by mail-wy0-f172.google.com with SMTP id 29so5668840wyb.31
        for <linux-omap@vger.kernel.org>; Tue, 24 May 2011 05:17:07 -0700 (PDT)
In-Reply-To: <20110522214036.GO18610@sortiz-mobl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>

Hi Samuel,

On Mon, May 23, 2011 at 3:10 AM, Samuel Ortiz <sameo@linux.intel.com> w=
rote:
> Hi Lesly,
>
> On Tue, May 17, 2011 at 07:10:03PM +0530, Manuel, Lesly Arackal wrote=
:
>> Hi Samuel,
>>
>> On Sat, May 14, 2011 at 12:09 AM, Samuel Ortiz <sameo@linux.intel.co=
m> wrote:
>> > Hi Lesly,
>> >
>> > On Fri, May 06, 2011 at 06:47:10PM +0530, Lesly A M wrote:
>> >> Power bus message sequence for TWL4030 to enter sleep/wakeup/warm=
_reset.
>> >>
>> >> TWL4030 power scripts which can be used by different OMAP3 boards
>> >> with the power companion chip (TWL4030 series).
>> >>
>> >> The twl4030 generic script can be used by any board file to updat=
e
>> >> the power data in twl4030_platform_data.
>> >>
>> >> Since the TWL4030 power script has dependency with APIs in twl403=
0-power.c
>> >> removing the __init for these APIs.
>> >>
>> >> For more information please see:
>> >> =A0 =A0 =A0 http://omapedia.org/wiki/TWL4030_power_scripts
>> > I understand you guys are trying to keep the arch/arm stats to a s=
ane level,
>> > but I don't see why this driver should be under drivers/mfd/. I'm =
usually
>> > flexible about what goes into drivers/mfd, but this one seems out =
of context
>> > to me.
>>
>> Since this script driver file contains the changes for PM IC (TWL403=
0 series),
>> which is a Multifunction devices with GPIOs, USB, audio,
>> current regulators, power management chip, ...
>>
>> This script driver file contains the pm bus message sequence which w=
ill be
>> programmed in the scratch memory of the PM IC, and some resource con=
figuration
>> data for PM IC resources.
>>
>> This change was suggested by Tony for the last version of this patch=
 series.
> I understand, but I'm trying to get the "let's push everything that s=
omehow
> linked to our MFD driver to drivers/mfd/" crazyness down to a sane le=
vel.
> This one doesn't look like it should be part of drivers/mfd.
>

This was moved to drivers/mfd/ based on the discussion of last version
of this patch series.
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg48349.html

I am slightly confused about, where to place these changes ?

in ../../mach-omap2/ or drivers/mfd/  ...

--
Thanks & Regards,
Lesly A M
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
