From: Luke Gong <lukejgong@gmail.com>
Subject: Re: Fail to suspend to ram: "Class driver suspend failed for cpu0"
Date: Fri, 21 Jan 2011 10:28:05 -0500
Message-ID: <AANLkTin2S6mBzVOHuRa-VHf7NBdAYp+93Z5T9wRmRdzc@mail.gmail.com>
References: <AANLkTin-q5o1x=0Eu1HvwDZxuCAOsGiVySWHBuAW0v+C@mail.gmail.com>
	<8762tjjidg.fsf@ti.com>
	<AANLkTikNkyN_qAGMWUrcRp8NzPW4fAYcpo0qiGBKTeDu@mail.gmail.com>
	<e1f3af7f928ead8c7b6cf98100b1e2d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:43695 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979Ab1AUP2I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Jan 2011 10:28:08 -0500
Received: by ewy5 with SMTP id 5so927471ewy.19
        for <linux-omap@vger.kernel.org>; Fri, 21 Jan 2011 07:28:06 -0800 (PST)
In-Reply-To: <e1f3af7f928ead8c7b6cf98100b1e2d1@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

But at this moment, it seems I cannot use both dvfs and suspend to ram
simultaneously :(.

On Thu, Jan 20, 2011 at 11:23 PM, Vishwanath Sripathy
<vishwanath.bs@ti.com> wrote:
> Luke,
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Luke Gong
>> Sent: Friday, January 21, 2011 5:03 AM
>> To: Kevin Hilman
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: Fail to suspend to ram: "Class driver suspend failed fo=
r
>> cpu0"
>>
>> Thanks, Kevin.
>>
>> On Thu, Jan 20, 2011 at 5:54 PM, Kevin Hilman <khilman@ti.com>
>> wrote:
>> > Luke Gong <lukejgong@gmail.com> writes:
>> >
>> >> I have a beagle board with OMAP3530. I ported linux-omap-
>> pm2.6.32 to
>> >> this board. When I want to let it suspend to ram,
>> >
>> > This is an old kernel. =A0Any reason you're not using a newer kern=
el?
>>
>> I have Angstrom7 with kernel 2.6.32 running on this board. So I
>> selected this old version to test. I might try the latest one.
>>
>> >
>> >> it fails and I get
>> >> the message "Class driver suspend failed for cpu0"
>> >
>> > This is the CPUfreq driver failing to suspend, probably because th=
ere
> is
>> > no CPUfreq driver implemented in your kernel. =A0Try disabling
>> CPU_FREQ in
>> > your kernel config.
>>
>> It seems can suspend to ram after disabling CPU_FREQ. Here is the lo=
g:
>>
>> root@beagleboard:~# echo mem > /sys/power/state
>> PM: Syncing filesystems ... done.
>> Freezing user space processes ... (elapsed 0.00 seconds) done.
>> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
>> Suspending console(s) (use no_console_suspend to debug)
>>
>> **********************************************************
>> ***
>> Once I hit the keyboard, I get:
>>
>> root@beagleboard:~# echo mem > /sys/power/state
>> PM: Syncing filesystems ... done.
>> Freezing user space processes ... (elapsed 0.00 seconds) done.
>> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
>> Suspending console(s) (use no_console_suspend to debug)
>> omapfb omapfb: timeout waiting for FRAME DONE
>> Powerdomain (core_pwrdm) didn't enter target state 1
>> Powerdomain (cam_pwrdm) didn't enter target state 1
>> Powerdomain (per_pwrdm) didn't enter target state 1
>> Could not enter target state in pm_suspend
>> Restarting tasks ... done.
>> root@beagleboard:~#
>> ***************************************************
>>
>> I am just curious why the powerdomain didn't enter target state 1.
> It looks like your camera module is not idling upon suspend preventin=
g per
> and core to idle. Pls check whether camera driver has implemented
> suspend/resume hooks properly. OR you can disable camera module and t=
ry.
>>
>> Another issue is about CPU frequency scaling. Using the original
>> Angstrom7, I can scale CPU frequency. But with the linux-omap-pm
>> kernel, I cannot do it even though I enable this feature in the conf=
ig
>> file. Is there any solution to support both cpu frequency scaling an=
d
>> suspend to ram?
> In current linux-omap-pm branch, DVFS feature is not supported and th=
is
> work is under progress. Previously DVFS feature was supported in pm b=
ranch
> using SRF and it has been removed sometime back.
> If you really want cpufreq support, you can pick DVFS patches under r=
eview
> available at: https://patchwork.kernel.org/patch/290542/
>
> It's also available in the dvfs tree hosted@
> http://dev.omapzoom.org/?p=3Dthara/omap-dvfs.git;a=3Dshortlog;h=3Dref=
s/heads/pm-
> dvfs
>
> Vishwa
>
>>
>> Thanks again for your help.
>> >
>> > Kevin
>> >
>> >> . Here is the log:
>> >>
>> >> root@beagleboard:~# echo mem > /sys/power/state
>> >> PM: Syncing filesystems ... done.
>> >> Freezing user space processes ... (elapsed 0.00 seconds) done.
>> >> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) don=
e.
>> >> Suspending console(s) (use no_console_suspend to debug)
>> >> omapfb omapfb: timeout waiting for FRAME DONE
>> >> Class driver suspend failed for cpu0
>> >> Restarting tasks ... done.
>> >>
>> >> *********************************************
>> >>
>> >> Is there any idea to fix this problem? Thanks.
>> >
>>
>>
>>
>> --
>> Luke
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Luke
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
