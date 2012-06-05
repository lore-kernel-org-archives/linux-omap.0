From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [GIT PULL] OMAP DSS for v3.5
Date: Tue, 5 Jun 2012 15:00:29 +0200
Message-ID: <CAORVsuVu3U9kUgonvZK=JDFcFLJmHqx66PetXJ8KPZRjYX4Bgw@mail.gmail.com>
References: <1337681363.4125.10.camel@deskari>
	<CAORVsuXLhGCEHMbZB_8FrzfL-sMH76wMH9rdUjOzOfL06bLH4w@mail.gmail.com>
	<1338899593.4456.6.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:54762 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756215Ab2FENAa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jun 2012 09:00:30 -0400
Received: by lbbgm6 with SMTP id gm6so3853141lbb.19
        for <linux-omap@vger.kernel.org>; Tue, 05 Jun 2012 06:00:29 -0700 (PDT)
In-Reply-To: <1338899593.4456.6.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-omap@vger.kernel.org, linux-fbdev <linux-fbdev@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Hi Tomi,

On Tue, Jun 5, 2012 at 2:33 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:
> Hi Jean,
>
> On Tue, 2012-06-05 at 14:17 +0200, Jean Pihet wrote:
>> Hi Tomi,
>
>> I am using a mainline kernel (3.5.0-rc1) with the patches below inte=
grated.
>> I have an issue with suspend/resume on OMAP3 Beagleboard, where the
>> system hangs at resume time.
>>
>> Here below is a log with the option no_console_suspend set and a few
>> added messages in case of null pointer in _od_resume_noirq.
>> It looks like there is no omap_device associated to the "omapdss_dpi=
" pdev.
>>
>> What do you think? How to fix this?
>> Sorry I know there have been some discussions on the lists but I am
>> not aware of all the details in the devices creation for DSS.
>>
>> / # echo mem > /sys/power/state
>> [ =A0 23.262298] PM: Syncing filesystems ... done.
>> [ =A0 23.295501] Freezing user space processes ... (elapsed 0.02 sec=
onds) done.
>> [ =A0 23.326507] Freezing remaining freezable tasks ... (elapsed 0.0=
2 seconds) don
>> e.
>> [ =A0 23.502197] PM: suspend of devices complete after 163.766 msecs
>> [ =A0 23.511932] PM: late suspend of devices complete after 3.418 ms=
ecs
>> [ =A0 23.524444] PM: noirq suspend of devices complete after 5.860 m=
secs
>> [ =A0 23.531249] Disabling non-boot CPUs ...
>> [ =A0 24.476562] Powerdomain (per_pwrdm) didn't enter target state 1
>> [ =A0 24.482818] Powerdomain (core_pwrdm) didn't enter target state =
1
>> [ =A0 24.489166] Could not enter target state in pm_suspend
>> [ =A0 24.495147] *** _od_resume_noirq: od=3DNULL, dev=3D0xc78bcc08
>> [ =A0 24.500915] *** _od_resume_noirq: od=3DNULL, pdev=3D0xc78bcc00
>> [ =A0 24.506805] *** _od_resume_noirq: od=3DNULL, pdev->name:omapdss=
_dpi
>> [ =A0 24.513336] Unable to handle kernel NULL pointer dereference at=
 virtual addre
>> ss 00000018
>> [ =A0 24.521942] pgd =3D c62f0000
>> [ =A0 24.524841] [00000018] *pgd=3D862c1831, *pte=3D00000000, *ppte=3D=
00000000
>> [ =A0 24.531524] Internal error: Oops: 17 [#1] SMP ARM
>> [ =A0 24.536529] Modules linked in:
>> [ =A0 24.539764] CPU: 0 =A0 =A0Not tainted =A0(3.5.0-rc1-00010-g5041=
caa-dirty #131)
>> [ =A0 24.546844] PC is at _od_resume_noirq+0x1c/0xac
>> [ =A0 24.551635] LR is at _od_resume_noirq+0x94/0xac
>> ...
>
> I'm on leave currently, so I can't test it right now. But can you try
Oh sorry about that!

> the attached patch? Or even better, try merging the tag:
That fixes it! I am able to suspend/resume correctly now.

>
> git://gitorious.org/linux-omap-dss2/linux.git tags/omapdss-for-3.5-rc=
2
>
> which contains the included patch plus a couple other fixes.
Thanks for the link, that is certainly useful!

Have a nice time on leave ;-p

>
> =A0Tomi
>

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
