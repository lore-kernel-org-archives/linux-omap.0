From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [ANNOUNCE] new PM branch: pm-20081119
Date: Mon, 24 Nov 2008 09:32:50 +0200
Message-ID: <87vdudbmu5.fsf@trdhcp146196.ntc.nokia.com>
References: <87d4grdxqh.fsf@deeprootsystems.com>
	<345163910811200045n3af8b3b5mbd30601aeeee31e@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301B6C8C79B@dbde02.ent.ti.com>
	<87r656b8js.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301B6D59577@dbde02.ent.ti.com>
	<87ljvd6p3u.fsf@deeprootsystems.com>
	<8bf247760811222357t45c25113ncfe6874b149651d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:42700 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbYKXHdB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Nov 2008 02:33:01 -0500
In-Reply-To: <8bf247760811222357t45c25113ncfe6874b149651d5@mail.gmail.com>
	(ext Sriram V.'s message of "Sun, 23 Nov 2008 13:27:42 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Sriram V <vshrirama@gmail.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Premi, Sanjeev" <premi@ti.com>, Peter Reid <ppeter.reid@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"ext Sriram V" <vshrirama@gmail.com> writes:

> Kevin,
>
> On Fri, Nov 21, 2008 at 9:35 PM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> "Premi, Sanjeev" <premi@ti.com> writes:
>>
>>>> -----Original Message-----
>>>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>>> Sent: Thursday, November 20, 2008 11:10 PM
>>>> To: Premi, Sanjeev
>>>> Cc: Peter Reid; linux-omap@vger.kernel.org
>>>> Subject: Re: [ANNOUNCE] new PM branch: pm-20081119
>>>>
>>>> "Premi, Sanjeev" <premi@ti.com> writes:
>>>>
>>>> > These are my observations on OMAP3EVM:
>>>> >
>>>> > 1) Very frequently I see these messages:
>>>> >
>>>> > <4>__ratelimit: 6736 callbacks suppressed
>>>> > __ratelimit: 6736 callbacks suppressed <3>omapfb omapfb: irq err=
or
>>>> > status 00c2 omapfb omapfb: irq error status 00c2 <3>omapfb
>>>> omapfb: irq
>>>> > error status 0060 omapfb omapfb: irq error status 0060 <3>omapfb
>>>> > omapfb: irq error status 00c2 omapfb omapfb: irq error status 00=
c2
>>>> > <3>omapfb omapfb: irq error status 0060 omapfb omapfb: irq error
>>>> > status 0060 <3>omapfb omapfb: irq error status 00e2 omapfb
>>>> omapfb: irq
>>>> > error status 00e2 <3>omapfb omapfb: irq error status 00c2 omapfb
>>>> > omapfb: irq error status 00c2 <3>omapfb omapfb: irq error
>>>> status 0060
>>>> > omapfb omapfb: irq error status 0060 <3>omapfb omapfb: irq error
>>>> > status 00e2 omapfb omapfb: irq error status 00e2 <3>omapfb
>>>> omapfb: irq
>>>> > error status 00c2 omapfb omapfb: irq error status 00c2 <3>omapfb
>>>> > omapfb: irq error status 0060 omapfb omapfb: irq error status 00=
60
>>>>
>>>> Sanjeev,
>>>>
>>>> For starters can you try with a minimal kernel (no drivers,
>>>> no framebuffer, etc.)
>>>>
>>>> The first goal is to hit retention and off with no drivers
>>>> than start moving out to address driver issues from there.
>>>>
>>>> Kevin
>>>>
>>>
>>> Here is what I was able to see with the minimal config (attached).
>>>
>>> [root@OMAP3EVM /]# echo mem > /sys/power/state
>>> <6>PM: Syncing filesystems ... PM: Syncing filesystems ... done.
>>> done.
>>> Freezing user space processes ... Freezing user space processes ...=
 (elapsed 0.00 seconds) (elapsed 0.00 seconds) done.
>>> done.
>>> Freezing remaining freezable tasks ... Freezing remaining freezable=
 tasks ... (elapsed 0.01 seconds) (elapsed 0.01 seconds) done.done.
>>>
>>> Suspending console(s) (use no_console_suspend to debug)
>>> Suspending console(s) (use no_console_suspend to debug)
>>>
>>> <snip>un-printable characters<snip>
>>>
>>> Powerdomain (per_pwrdm) didn't enter target state 1
>>> Could not enter target state in pm_suspend
>>> Restarting tasks ... Restarting tasks ... done.
>>> done.
>>
>> This is what I see on Beagle as well (PER is not entering retention.=
)
>>
>
>> At this point, the current PM debug code doesn't help further in
>> determining exactly why a powerdomain did not hit its target state.
>> Some device in the domain may still have its clocks enabled, or its
>> idle state not set correctly.  Or, a given module may have been
>> initialized by the bootloader in a way which prevents it from going
>> idle.
>>
>
>   True. I have observed on omap3evm with minimum configuration, and
> booting out of ramdisk:
>           with nand booting:  only per powerdomain does not enter ret=
ention
>           with mmc boot:  core and per dont enter retention
>
>    it could do with clocks set the bootloaders that is preventing it =
from
>    entering ret/off.

To tackle this you should have CONFIG_OMAP_RESET_CLOCKS enabled in
config.

>    what do you mean by idle state not set correctly? are you referrin=
g
> to auto-idle bit?

Not sure what Kevin meant there, but if the problem was in the
autoidle bit in *_SYSCONFIG, I would expect also CORE pwrdm to
fail. Anyway it's also worth of checking the statuses of PER modules
*_SYSCONFIG registers.

>
>
>> We need some improved PM debug capabilities in the kernel to pinpoin=
t
>> exactly the module that is causing the problem.
>>
>
>    Apart from PM debug, are you using any other module/methods to
>    debug?

State of PRCM registers can be quickly checked from
/sys/kernel/debug/pm_debug/registers/current (assuming you have mount
debugfs in /sys/kernel/debug and PM_DEBUG is enabled in config).

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
