From: Luke Gong <lukejgong@gmail.com>
Subject: Re: Fail to suspend to ram: "Class driver suspend failed for cpu0"
Date: Fri, 21 Jan 2011 10:30:01 -0500
Message-ID: <AANLkTikKX8u6vkkwnGEbiZOMgqk50t0QmRu=9Pbj-KfL@mail.gmail.com>
References: <AANLkTin-q5o1x=0Eu1HvwDZxuCAOsGiVySWHBuAW0v+C@mail.gmail.com>
	<8762tjjidg.fsf@ti.com>
	<AANLkTikNkyN_qAGMWUrcRp8NzPW4fAYcpo0qiGBKTeDu@mail.gmail.com>
	<8762tij11t.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40373 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753592Ab1AUPaD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Jan 2011 10:30:03 -0500
Received: by eye27 with SMTP id 27so925602eye.19
        for <linux-omap@vger.kernel.org>; Fri, 21 Jan 2011 07:30:01 -0800 (PST)
In-Reply-To: <8762tij11t.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org

All right. Thank you.

One more question. At this moment, I can wake up the board by
keyboard. Can I wake it up on LAN?

On Fri, Jan 21, 2011 at 12:09 AM, Kevin Hilman <khilman@ti.com> wrote:
> Luke Gong <lukejgong@gmail.com> writes:
>
>> Thanks, Kevin.
>>
>> On Thu, Jan 20, 2011 at 5:54 PM, Kevin Hilman <khilman@ti.com> wrote=
:
>>> Luke Gong <lukejgong@gmail.com> writes:
>>>
>>>> I have a beagle board with OMAP3530. I ported linux-omap-pm2.6.32 =
to
>>>> this board. When I want to let it suspend to ram,
>>>
>>> This is an old kernel. =A0Any reason you're not using a newer kerne=
l?
>>
>> I have Angstrom7 with kernel 2.6.32 running on this board. So I
>> selected this old version to test. I might try the latest one.
>>
>
> You'll have to get support from the folks making the Angstrom kernel =
as
> I don't keep track of the kernel baseline they use or the local patch=
es
> they apply, so can't help you.
>
> If you can reproduce on current linux-omap, I'll be glad to help.
>
> Kevin
>
>
>>>
>>>> it fails and I get
>>>> the message "Class driver suspend failed for cpu0"
>>>
>>> This is the CPUfreq driver failing to suspend, probably because the=
re is
>>> no CPUfreq driver implemented in your kernel. =A0Try disabling CPU_=
=46REQ in
>>> your kernel config.
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
>> *************************************************************
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
>>
>> Another issue is about CPU frequency scaling. Using the original
>> Angstrom7, I can scale CPU frequency. But with the linux-omap-pm
>> kernel, I cannot do it even though I enable this feature in the conf=
ig
>> file. Is there any solution to support both cpu frequency scaling an=
d
>> suspend to ram?
>>
>> Thanks again for your help.
>>>
>>> Kevin
>>>
>>>> . Here is the log:
>>>>
>>>> root@beagleboard:~# echo mem > /sys/power/state
>>>> PM: Syncing filesystems ... done.
>>>> Freezing user space processes ... (elapsed 0.00 seconds) done.
>>>> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done=
=2E
>>>> Suspending console(s) (use no_console_suspend to debug)
>>>> omapfb omapfb: timeout waiting for FRAME DONE
>>>> Class driver suspend failed for cpu0
>>>> Restarting tasks ... done.
>>>>
>>>> *********************************************
>>>>
>>>> Is there any idea to fix this problem? Thanks.
>>>
>



--=20
Luke
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
