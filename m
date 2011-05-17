From: "Manuel, Lesly Arackal" <leslyam@ti.com>
Subject: Re: [PATCH v10 4/7] MFD: TWL4030: power scripts for OMAP3 boards
Date: Tue, 17 May 2011 19:10:03 +0530
Message-ID: <BANLkTi=c9naYFuuRbNG8FK6WuKWVBp0DKg@mail.gmail.com>
References: <1304687833-4578-1-git-send-email-leslyam@ti.com>
	<1304687833-4578-5-git-send-email-leslyam@ti.com>
	<20110513183958.GY8970@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:38300 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753427Ab1EQNkL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 May 2011 09:40:11 -0400
Received: by mail-ww0-f43.google.com with SMTP id 17so495325wwb.24
        for <linux-omap@vger.kernel.org>; Tue, 17 May 2011 06:40:03 -0700 (PDT)
In-Reply-To: <20110513183958.GY8970@sortiz-mobl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>

Hi Samuel,

On Sat, May 14, 2011 at 12:09 AM, Samuel Ortiz <sameo@linux.intel.com> =
wrote:
> Hi Lesly,
>
> On Fri, May 06, 2011 at 06:47:10PM +0530, Lesly A M wrote:
>> Power bus message sequence for TWL4030 to enter sleep/wakeup/warm_re=
set.
>>
>> TWL4030 power scripts which can be used by different OMAP3 boards
>> with the power companion chip (TWL4030 series).
>>
>> The twl4030 generic script can be used by any board file to update
>> the power data in twl4030_platform_data.
>>
>> Since the TWL4030 power script has dependency with APIs in twl4030-p=
ower.c
>> removing the __init for these APIs.
>>
>> For more information please see:
>> =A0 =A0 =A0 http://omapedia.org/wiki/TWL4030_power_scripts
> I understand you guys are trying to keep the arch/arm stats to a sane=
 level,
> but I don't see why this driver should be under drivers/mfd/. I'm usu=
ally
> flexible about what goes into drivers/mfd, but this one seems out of =
context
> to me.

Since this script driver file contains the changes for PM IC (TWL4030 s=
eries),
which is a Multifunction devices with GPIOs, USB, audio,
current regulators, power management chip, ...

This script driver file contains the pm bus message sequence which will=
 be
programmed in the scratch memory of the PM IC, and some resource config=
uration
data for PM IC resources.

This change was suggested by Tony for the last version of this patch se=
ries.

Regards,
Lesly A M
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
