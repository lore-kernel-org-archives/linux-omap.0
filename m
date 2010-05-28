From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [pm-wip/uart][PATCH 0/6]: Serial HWMOD updation and cleanup.
Date: Fri, 28 May 2010 17:41:14 +0530
Message-ID: <AANLkTikxWTAUOtoUSB7aXcC9Z0miTsJCssf-OzoFbp2e@mail.gmail.com>
References: <47398.192.168.10.88.1274362670.squirrel@dbdmail.itg.ti.com>
	<87typtgimw.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40164 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755279Ab0E1MLP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 May 2010 08:11:15 -0400
Received: by vws9 with SMTP id 9so923674vws.19
        for <linux-omap@vger.kernel.org>; Fri, 28 May 2010 05:11:14 -0700 (PDT)
In-Reply-To: <87typtgimw.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org

On Fri, May 28, 2010 at 2:35 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Hi Govindraj,
>
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Patch series is based on remotes/origin/pm-wip/govindraj
>> branch from Kevin's PM tree.
>>
>> Patches are tested with 3430SDP.
>> Have updated 2420/2430 hwmod data files
>> it would be great if some one can test the same.
>
> OK, I've updated pm-wip/uart to include most of this series as well a=
s
> some of the other fixes I posted yesterday to get things working on
> OMAP2.
>
>> Govindraj.R (6):
>> =A0 Serial: Clean up set_uart_globals.
>> =A0 Serial: Add UART4 hwmod data.
>> =A0 Serial: Modify OMAP3 hwmod data file with uart data.
>> =A0 Serial: Add UART hwmod data for 2420.
>> =A0 Serial: Add UART hwmod data for 2430.
>> =A0 Serial: Update UART HWMOD layer.
>
> I've kept patch 1 as is, but changed the subject slightly.
>
> Patches 2, 4 and 5 I've folded into the patch that added hwmod data
> for OMAP3.
>
> Patch 6 I folded into the initial UART conversion patch and also
> changed the authorship for that patch to you, since you've done most
> of that work.
>

Thanks. Looks great now.

> Patch 3, I've dropped as that shouldn't be needed after you switch
> to platform_get_resource_byname().
>

One comment here,
In that patch other than swapping rx and tx fields.
I had modified name field from uart*_hwmod to uart*

-	.name		=3D "uart[1-3]_hwmod",
+	.name		=3D "uart[1-3]",

I think this might be necessary.
To be in sync with auto generated data file.

I think it can be incorporated with,

OMAP2/3: UART: add omap_hwmod data for UARTs 1-4

> Please update your omap-serial driver on top of the new pm-wip/uart
> branch and then we'll be basically ready for upstream.
>

Sure and here is the update:

http://marc.info/?l=3Dlinux-serial&m=3D127504585628001&w=3D2

Meanwhile I took wip-uart patches to pm branch and tested
enabling sleep_while_idle and enable_off_mode
on 3430/3630SDP with omap3_pm_defconfig.
Things worked fine with ret/off count getting incremented.

---
Regards,
Govindraj.R


> Kevin
>
>> =A0arch/arm/mach-omap2/omap_hwmod_2420_data.c | =A0184 +++++++++++++=
+++++++++++++++
>> =A0arch/arm/mach-omap2/omap_hwmod_2430_data.c | =A0184 +++++++++++++=
+++++++++++++++
>> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0 66 +++++++++-
>> =A0arch/arm/mach-omap2/prcm-common.h =A0 =A0 =A0 =A0 =A0| =A0 =A02 +
>> =A0arch/arm/mach-omap2/serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 38=
 +++----
>> =A0arch/arm/plat-omap/common.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
17 ---
>> =A0arch/arm/plat-omap/include/plat/common.h =A0 | =A0 =A01 -
>> =A0arch/arm/plat-omap/include/plat/dma.h =A0 =A0 =A0| =A0 =A02 +
>> =A0arch/arm/plat-omap/include/plat/irqs.h =A0 =A0 | =A0 =A02 +
>> =A09 files changed, 449 insertions(+), 47 deletions(-)
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
