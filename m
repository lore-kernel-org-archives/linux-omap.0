From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [pm-wip/uart][PATCH 0/6]: Serial HWMOD updation and cleanup.
Date: Fri, 28 May 2010 07:43:42 -0700
Message-ID: <87zkzkdr35.fsf@deeprootsystems.com>
References: <47398.192.168.10.88.1274362670.squirrel@dbdmail.itg.ti.com>
	<87typtgimw.fsf@deeprootsystems.com>
	<AANLkTikxWTAUOtoUSB7aXcC9Z0miTsJCssf-OzoFbp2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:48679 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758410Ab0E1Onq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 May 2010 10:43:46 -0400
Received: by pzk42 with SMTP id 42so617364pzk.4
        for <linux-omap@vger.kernel.org>; Fri, 28 May 2010 07:43:45 -0700 (PDT)
In-Reply-To: <AANLkTikxWTAUOtoUSB7aXcC9Z0miTsJCssf-OzoFbp2e@mail.gmail.com> (Govindraj's message of "Fri\, 28 May 2010 17\:41\:14 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org

Govindraj <govindraj.ti@gmail.com> writes:

> On Fri, May 28, 2010 at 2:35 AM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> Hi Govindraj,
>>
>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>>
>>> Patch series is based on remotes/origin/pm-wip/govindraj
>>> branch from Kevin's PM tree.
>>>
>>> Patches are tested with 3430SDP.
>>> Have updated 2420/2430 hwmod data files
>>> it would be great if some one can test the same.
>>
>> OK, I've updated pm-wip/uart to include most of this series as well =
as
>> some of the other fixes I posted yesterday to get things working on
>> OMAP2.
>>
>>> Govindraj.R (6):
>>> =A0 Serial: Clean up set_uart_globals.
>>> =A0 Serial: Add UART4 hwmod data.
>>> =A0 Serial: Modify OMAP3 hwmod data file with uart data.
>>> =A0 Serial: Add UART hwmod data for 2420.
>>> =A0 Serial: Add UART hwmod data for 2430.
>>> =A0 Serial: Update UART HWMOD layer.
>>
>> I've kept patch 1 as is, but changed the subject slightly.
>>
>> Patches 2, 4 and 5 I've folded into the patch that added hwmod data
>> for OMAP3.
>>
>> Patch 6 I folded into the initial UART conversion patch and also
>> changed the authorship for that patch to you, since you've done most
>> of that work.
>>
>
> Thanks. Looks great now.
>
>> Patch 3, I've dropped as that shouldn't be needed after you switch
>> to platform_get_resource_byname().
>>
>
> One comment here,
> In that patch other than swapping rx and tx fields.
> I had modified name field from uart*_hwmod to uart*
>
> -	.name		=3D "uart[1-3]_hwmod",
> +	.name		=3D "uart[1-3]",
>
> I think this might be necessary.
> To be in sync with auto generated data file.
>
> I think it can be incorporated with,
>
> OMAP2/3: UART: add omap_hwmod data for UARTs 1-4

OK, I will fold the "_hwmod" removal part of the patch into the hwmod
data patch.

>> Please update your omap-serial driver on top of the new pm-wip/uart
>> branch and then we'll be basically ready for upstream.
>>
>
> Sure and here is the update:
>
> http://marc.info/?l=3Dlinux-serial&m=3D127504585628001&w=3D2

Looks good to me.

> Meanwhile I took wip-uart patches to pm branch and tested
> enabling sleep_while_idle and enable_off_mode
> on 3430/3630SDP with omap3_pm_defconfig.
> Things worked fine with ret/off count getting incremented.

Great, so this series + omap-serial is now working OMAP2420, 3430 and
3630.  Nice.

One other missing piece is that I need a refresh of this patch:

  [pm-wip/uart][PATCH] Serial: Avoid using hwmod lookup using name stri=
ng

against the current pm-wip/uart branch, and I will fold that into the
UART hwmod conversion patch.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
