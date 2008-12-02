From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [ANNOUNCE] new PM branch: pm-20081119
Date: Mon, 01 Dec 2008 21:17:51 -0800
Message-ID: <4934C4FF.1070603@deeprootsystems.com>
References: <87d4grdxqh.fsf@deeprootsystems.com>	 <345163910811200045n3af8b3b5mbd30601aeeee31e@mail.gmail.com>	 <B85A65D85D7EB246BE421B3FB0FBB59301B6C8C79B@dbde02.ent.ti.com>	 <87r656b8js.fsf@deeprootsystems.com>	 <B85A65D85D7EB246BE421B3FB0FBB59301B6D59577@dbde02.ent.ti.com>	 <87ljvd6p3u.fsf@deeprootsystems.com>	 <8bf247760811222357t45c25113ncfe6874b149651d5@mail.gmail.com>	 <87vdudbmu5.fsf@trdhcp146196.ntc.nokia.com> <8bf247760812010822t26f1af27l689bc64175703589@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:24516 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbYLBFR6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Dec 2008 00:17:58 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1120047yxm.1
        for <linux-omap@vger.kernel.org>; Mon, 01 Dec 2008 21:17:54 -0800 (PST)
In-Reply-To: <8bf247760812010822t26f1af27l689bc64175703589@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sriram V <vshrirama@gmail.com>
Cc: =?ISO-8859-1?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>, "Premi, Sanjeev" <premi@ti.com>, Peter Reid <ppeter.reid@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Sriram V wrote:
> Hi,
>   On OMAP3EVM, with a minimum config. All domains are hitting RET.
> Only SGX domain hits  OFF. No other domain hits OFF.

Yes, the default boot behavior is to default to RET, but SGX does not
support RET, only ON or OFF, so it goes to OFF.

>   I tried doing a echo 1 > /sys/power/enable_off_mode.

After doing this, and then 'echo mem > /sys/power/state' do you see
any other states that have hit OFF in /debug/pm_debug/count?

>   Powertop shows Sleep States upto C4.  Has anyone seen Sleep States
> upto C6 with this kernel?

Yes, I've seen states up to C6.  The only thing preventing deeper state=
s
is application or timer activity not being long enough.  What does=20
powertop list as the primary interrupt or timer sources waking out of i=
dle?

>  dont know why MPU/CORE not hitting OFF even though the clocks are of=
f.

It looks like you're primarily testing dynamic idle.  Can you check via=
=20
/debug/pm_debug/count whether you're hitting OFF in any powerdomains=20
when going into suspend?

Kevin

> With the most of the PM support (Suspend/Resume, Power Domains, CPU
> Idle)  up with minimum config.
>=20
> What else remains to be supported?
>=20
> CPU freq, constraint frame work and individual drivers support to
> enable power domain transition to OFF/RET?
> Is this all? do these cover all the pm features of omap3?
>=20
> Is the constraints framework embedded within the TI SRF or is it
> independently usable?
>=20
> I havent seen too many drivers which specify constraints in the TI
> sources though.
>=20
>=20
> Regards,
> sriram
>=20
> On Mon, Nov 24, 2008 at 1:02 PM, H=F6gander Jouni
> <jouni.hogander@nokia.com> wrote:
>> "ext Sriram V" <vshrirama@gmail.com> writes:
>>
>>> Kevin,
>>>
>>> On Fri, Nov 21, 2008 at 9:35 PM, Kevin Hilman
>>> <khilman@deeprootsystems.com> wrote:
>>>> "Premi, Sanjeev" <premi@ti.com> writes:
>>>>
>>>>>> -----Original Message-----
>>>>>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>>>>> Sent: Thursday, November 20, 2008 11:10 PM
>>>>>> To: Premi, Sanjeev
>>>>>> Cc: Peter Reid; linux-omap@vger.kernel.org
>>>>>> Subject: Re: [ANNOUNCE] new PM branch: pm-20081119
>>>>>>
>>>>>> "Premi, Sanjeev" <premi@ti.com> writes:
>>>>>>
>>>>>>> These are my observations on OMAP3EVM:
>>>>>>>
>>>>>>> 1) Very frequently I see these messages:
>>>>>>>
>>>>>>> <4>__ratelimit: 6736 callbacks suppressed
>>>>>>> __ratelimit: 6736 callbacks suppressed <3>omapfb omapfb: irq er=
ror
>>>>>>> status 00c2 omapfb omapfb: irq error status 00c2 <3>omapfb
>>>>>> omapfb: irq
>>>>>>> error status 0060 omapfb omapfb: irq error status 0060 <3>omapf=
b
>>>>>>> omapfb: irq error status 00c2 omapfb omapfb: irq error status 0=
0c2
>>>>>>> <3>omapfb omapfb: irq error status 0060 omapfb omapfb: irq erro=
r
>>>>>>> status 0060 <3>omapfb omapfb: irq error status 00e2 omapfb
>>>>>> omapfb: irq
>>>>>>> error status 00e2 <3>omapfb omapfb: irq error status 00c2 omapf=
b
>>>>>>> omapfb: irq error status 00c2 <3>omapfb omapfb: irq error
>>>>>> status 0060
>>>>>>> omapfb omapfb: irq error status 0060 <3>omapfb omapfb: irq erro=
r
>>>>>>> status 00e2 omapfb omapfb: irq error status 00e2 <3>omapfb
>>>>>> omapfb: irq
>>>>>>> error status 00c2 omapfb omapfb: irq error status 00c2 <3>omapf=
b
>>>>>>> omapfb: irq error status 0060 omapfb omapfb: irq error status 0=
060
>>>>>> Sanjeev,
>>>>>>
>>>>>> For starters can you try with a minimal kernel (no drivers,
>>>>>> no framebuffer, etc.)
>>>>>>
>>>>>> The first goal is to hit retention and off with no drivers
>>>>>> than start moving out to address driver issues from there.
>>>>>>
>>>>>> Kevin
>>>>>>
>>>>> Here is what I was able to see with the minimal config (attached)=
=2E
>>>>>
>>>>> [root@OMAP3EVM /]# echo mem > /sys/power/state
>>>>> <6>PM: Syncing filesystems ... PM: Syncing filesystems ... done.
>>>>> done.
>>>>> Freezing user space processes ... Freezing user space processes .=
=2E. (elapsed 0.00 seconds) (elapsed 0.00 seconds) done.
>>>>> done.
>>>>> Freezing remaining freezable tasks ... Freezing remaining freezab=
le tasks ... (elapsed 0.01 seconds) (elapsed 0.01 seconds) done.done.
>>>>>
>>>>> Suspending console(s) (use no_console_suspend to debug)
>>>>> Suspending console(s) (use no_console_suspend to debug)
>>>>>
>>>>> <snip>un-printable characters<snip>
>>>>>
>>>>> Powerdomain (per_pwrdm) didn't enter target state 1
>>>>> Could not enter target state in pm_suspend
>>>>> Restarting tasks ... Restarting tasks ... done.
>>>>> done.
>>>> This is what I see on Beagle as well (PER is not entering retentio=
n.)
>>>>
>>>> At this point, the current PM debug code doesn't help further in
>>>> determining exactly why a powerdomain did not hit its target state=
=2E
>>>> Some device in the domain may still have its clocks enabled, or it=
s
>>>> idle state not set correctly.  Or, a given module may have been
>>>> initialized by the bootloader in a way which prevents it from goin=
g
>>>> idle.
>>>>
>>>   True. I have observed on omap3evm with minimum configuration, and
>>> booting out of ramdisk:
>>>           with nand booting:  only per powerdomain does not enter r=
etention
>>>           with mmc boot:  core and per dont enter retention
>>>
>>>    it could do with clocks set the bootloaders that is preventing i=
t from
>>>    entering ret/off.
>> To tackle this you should have CONFIG_OMAP_RESET_CLOCKS enabled in
>> config.
>>
>>>    what do you mean by idle state not set correctly? are you referr=
ing
>>> to auto-idle bit?
>> Not sure what Kevin meant there, but if the problem was in the
>> autoidle bit in *_SYSCONFIG, I would expect also CORE pwrdm to
>> fail. Anyway it's also worth of checking the statuses of PER modules
>> *_SYSCONFIG registers.
>>
>>>
>>>> We need some improved PM debug capabilities in the kernel to pinpo=
int
>>>> exactly the module that is causing the problem.
>>>>
>>>    Apart from PM debug, are you using any other module/methods to
>>>    debug?
>> State of PRCM registers can be quickly checked from
>> /sys/kernel/debug/pm_debug/registers/current (assuming you have moun=
t
>> debugfs in /sys/kernel/debug and PM_DEBUG is enabled in config).
>>
>> --
>> Jouni H=F6gander
>>
>>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
