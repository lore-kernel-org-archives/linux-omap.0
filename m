From: Kevin Hilman <khilman@ti.com>
Subject: Re: Fail to suspend to ram: "Class driver suspend failed for cpu0"
Date: Thu, 20 Jan 2011 21:09:02 -0800
Message-ID: <8762tij11t.fsf@ti.com>
References: <AANLkTin-q5o1x=0Eu1HvwDZxuCAOsGiVySWHBuAW0v+C@mail.gmail.com>
	<8762tjjidg.fsf@ti.com>
	<AANLkTikNkyN_qAGMWUrcRp8NzPW4fAYcpo0qiGBKTeDu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:60678 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750695Ab1AUFP1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Jan 2011 00:15:27 -0500
Received: by mail-iy0-f179.google.com with SMTP id 19so1445920iye.38
        for <linux-omap@vger.kernel.org>; Thu, 20 Jan 2011 21:15:27 -0800 (PST)
In-Reply-To: <AANLkTikNkyN_qAGMWUrcRp8NzPW4fAYcpo0qiGBKTeDu@mail.gmail.com>
	(Luke Gong's message of "Thu, 20 Jan 2011 18:32:33 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luke Gong <lukejgong@gmail.com>
Cc: linux-omap@vger.kernel.org

Luke Gong <lukejgong@gmail.com> writes:

> Thanks, Kevin.
>
> On Thu, Jan 20, 2011 at 5:54 PM, Kevin Hilman <khilman@ti.com> wrote:
>> Luke Gong <lukejgong@gmail.com> writes:
>>
>>> I have a beagle board with OMAP3530. I ported linux-omap-pm2.6.32 t=
o
>>> this board. When I want to let it suspend to ram,
>>
>> This is an old kernel. =C2=A0Any reason you're not using a newer ker=
nel?
>
> I have Angstrom7 with kernel 2.6.32 running on this board. So I
> selected this old version to test. I might try the latest one.
>

You'll have to get support from the folks making the Angstrom kernel as
I don't keep track of the kernel baseline they use or the local patches
they apply, so can't help you.

If you can reproduce on current linux-omap, I'll be glad to help.

Kevin


>>
>>> it fails and I get
>>> the message "Class driver suspend failed for cpu0"
>>
>> This is the CPUfreq driver failing to suspend, probably because ther=
e is
>> no CPUfreq driver implemented in your kernel. =C2=A0Try disabling CP=
U_FREQ in
>> your kernel config.
>
> It seems can suspend to ram after disabling CPU_FREQ. Here is the log=
:
>
> root@beagleboard:~# echo mem > /sys/power/state
> PM: Syncing filesystems ... done.
> Freezing user space processes ... (elapsed 0.00 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
> Suspending console(s) (use no_console_suspend to debug)
>
> *************************************************************
> Once I hit the keyboard, I get:
>
> root@beagleboard:~# echo mem > /sys/power/state
> PM: Syncing filesystems ... done.
> Freezing user space processes ... (elapsed 0.00 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
> Suspending console(s) (use no_console_suspend to debug)
> omapfb omapfb: timeout waiting for FRAME DONE
> Powerdomain (core_pwrdm) didn't enter target state 1
> Powerdomain (cam_pwrdm) didn't enter target state 1
> Powerdomain (per_pwrdm) didn't enter target state 1
> Could not enter target state in pm_suspend
> Restarting tasks ... done.
> root@beagleboard:~#
> ***************************************************
>
> I am just curious why the powerdomain didn't enter target state 1.
>
> Another issue is about CPU frequency scaling. Using the original
> Angstrom7, I can scale CPU frequency. But with the linux-omap-pm
> kernel, I cannot do it even though I enable this feature in the confi=
g
> file. Is there any solution to support both cpu frequency scaling and
> suspend to ram?
>
> Thanks again for your help.
>>
>> Kevin
>>
>>> . Here is the log:
>>>
>>> root@beagleboard:~# echo mem > /sys/power/state
>>> PM: Syncing filesystems ... done.
>>> Freezing user space processes ... (elapsed 0.00 seconds) done.
>>> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
>>> Suspending console(s) (use no_console_suspend to debug)
>>> omapfb omapfb: timeout waiting for FRAME DONE
>>> Class driver suspend failed for cpu0
>>> Restarting tasks ... done.
>>>
>>> *********************************************
>>>
>>> Is there any idea to fix this problem? Thanks.
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
