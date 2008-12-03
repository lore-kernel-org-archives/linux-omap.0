From: "Sriram V" <vshrirama@gmail.com>
Subject: Re: [ANNOUNCE] new PM branch: pm-20081119
Date: Wed, 3 Dec 2008 19:53:31 +0530
Message-ID: <8bf247760812030623u75dfc8cax1d1e5963961ce733@mail.gmail.com>
References: <87d4grdxqh.fsf@deeprootsystems.com>
	 <345163910811200045n3af8b3b5mbd30601aeeee31e@mail.gmail.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301B6C8C79B@dbde02.ent.ti.com>
	 <87r656b8js.fsf@deeprootsystems.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301B6D59577@dbde02.ent.ti.com>
	 <87ljvd6p3u.fsf@deeprootsystems.com>
	 <8bf247760811222357t45c25113ncfe6874b149651d5@mail.gmail.com>
	 <87vdudbmu5.fsf@trdhcp146196.ntc.nokia.com>
	 <8bf247760812010822t26f1af27l689bc64175703589@mail.gmail.com>
	 <4934C4FF.1070603@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:58161 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbYLCO3h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Dec 2008 09:29:37 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2502719fgg.17
        for <linux-omap@vger.kernel.org>; Wed, 03 Dec 2008 06:29:35 -0800 (PST)
In-Reply-To: <4934C4FF.1070603@deeprootsystems.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Kevin,

On Tue, Dec 2, 2008 at 10:47 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Sriram V wrote:
>>
>> Hi,
>>  On OMAP3EVM, with a minimum config. All domains are hitting RET.
>> Only SGX domain hits  OFF. No other domain hits OFF.
>
> Yes, the default boot behavior is to default to RET, but SGX does not
> support RET, only ON or OFF, so it goes to OFF.
>
>>  I tried doing a echo 1 > /sys/power/enable_off_mode.
>
> After doing this, and then 'echo mem > /sys/power/state' do you see
> any other states that have hit OFF in /debug/pm_debug/count?


Am running out of a ramdisk now, I see all domains hitting OFF.

>
>>  Powertop shows Sleep States upto C4.  Has anyone seen Sleep States
>> upto C6 with this kernel?
>
> Yes, I've seen states up to C6.  The only thing preventing deeper sta=
tes
> is application or timer activity not being long enough.  What does po=
wertop
> list as the primary interrupt or timer sources waking out of idle?
>

  Powertop output:

 PowerTOP version 1.10      (C) 2007 Intel Corporation

Cn                Avg residency       P-states (frequencies)
C0 (cpu running)        ( 0.2%)
C0                0.2ms ( 0.0%)
C1                4.8ms ( 1.7%)
C2                2.8ms ( 0.3%)
C3                0.0ms ( 0.0%)
C4              909.1ms (21.8%)
Wakeups-from-idle per second :  6.1     interval: 4.6s


Top causes for wakeups:
  44.4% (  5.0)       <interrupt> : serial idle, serial
  24.4% (  2.8)       <interrupt> : prcm
  20.0% (  2.2)       <interrupt> : gp timer
   4.4% (  0.5)     <kernel core> : schedule_delayed_work_on (delayed_w=
ork_timer
   2.2% (  0.2)     <kernel core> : neigh_table_init_no_netlink (neigh_=
periodic_
   2.2% (  0.2)     <kernel core> : omap_uart_block_sleep (omap_uart_id=
le_timer)


Regards,
sriram



>>  dont know why MPU/CORE not hitting OFF even though the clocks are o=
ff.
>
> It looks like you're primarily testing dynamic idle.  Can you check v=
ia
> /debug/pm_debug/count whether you're hitting OFF in any powerdomains =
when
> going into suspend?
>



> Kevin
>
>> With the most of the PM support (Suspend/Resume, Power Domains, CPU
>> Idle)  up with minimum config.
>>
>> What else remains to be supported?
>>
>> CPU freq, constraint frame work and individual drivers support to
>> enable power domain transition to OFF/RET?
>> Is this all? do these cover all the pm features of omap3?
>>
>> Is the constraints framework embedded within the TI SRF or is it
>> independently usable?
>>
>> I havent seen too many drivers which specify constraints in the TI
>> sources though.
>>
>>
>> Regards,
>> sriram
>>
>> On Mon, Nov 24, 2008 at 1:02 PM, H=F6gander Jouni
>> <jouni.hogander@nokia.com> wrote:
>>>
>>> "ext Sriram V" <vshrirama@gmail.com> writes:
>>>
>>>> Kevin,
>>>>
>>>> On Fri, Nov 21, 2008 at 9:35 PM, Kevin Hilman
>>>> <khilman@deeprootsystems.com> wrote:
>>>>>
>>>>> "Premi, Sanjeev" <premi@ti.com> writes:
>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>>>>>> Sent: Thursday, November 20, 2008 11:10 PM
>>>>>>> To: Premi, Sanjeev
>>>>>>> Cc: Peter Reid; linux-omap@vger.kernel.org
>>>>>>> Subject: Re: [ANNOUNCE] new PM branch: pm-20081119
>>>>>>>
>>>>>>> "Premi, Sanjeev" <premi@ti.com> writes:
>>>>>>>
>>>>>>>> These are my observations on OMAP3EVM:
>>>>>>>>
>>>>>>>> 1) Very frequently I see these messages:
>>>>>>>>
>>>>>>>> <4>__ratelimit: 6736 callbacks suppressed
>>>>>>>> __ratelimit: 6736 callbacks suppressed <3>omapfb omapfb: irq e=
rror
>>>>>>>> status 00c2 omapfb omapfb: irq error status 00c2 <3>omapfb
>>>>>>>
>>>>>>> omapfb: irq
>>>>>>>>
>>>>>>>> error status 0060 omapfb omapfb: irq error status 0060 <3>omap=
fb
>>>>>>>> omapfb: irq error status 00c2 omapfb omapfb: irq error status =
00c2
>>>>>>>> <3>omapfb omapfb: irq error status 0060 omapfb omapfb: irq err=
or
>>>>>>>> status 0060 <3>omapfb omapfb: irq error status 00e2 omapfb
>>>>>>>
>>>>>>> omapfb: irq
>>>>>>>>
>>>>>>>> error status 00e2 <3>omapfb omapfb: irq error status 00c2 omap=
fb
>>>>>>>> omapfb: irq error status 00c2 <3>omapfb omapfb: irq error
>>>>>>>
>>>>>>> status 0060
>>>>>>>>
>>>>>>>> omapfb omapfb: irq error status 0060 <3>omapfb omapfb: irq err=
or
>>>>>>>> status 00e2 omapfb omapfb: irq error status 00e2 <3>omapfb
>>>>>>>
>>>>>>> omapfb: irq
>>>>>>>>
>>>>>>>> error status 00c2 omapfb omapfb: irq error status 00c2 <3>omap=
fb
>>>>>>>> omapfb: irq error status 0060 omapfb omapfb: irq error status =
0060
>>>>>>>
>>>>>>> Sanjeev,
>>>>>>>
>>>>>>> For starters can you try with a minimal kernel (no drivers,
>>>>>>> no framebuffer, etc.)
>>>>>>>
>>>>>>> The first goal is to hit retention and off with no drivers
>>>>>>> than start moving out to address driver issues from there.
>>>>>>>
>>>>>>> Kevin
>>>>>>>
>>>>>> Here is what I was able to see with the minimal config (attached=
).
>>>>>>
>>>>>> [root@OMAP3EVM /]# echo mem > /sys/power/state
>>>>>> <6>PM: Syncing filesystems ... PM: Syncing filesystems ... done.
>>>>>> done.
>>>>>> Freezing user space processes ... Freezing user space processes =
=2E..
>>>>>> (elapsed 0.00 seconds) (elapsed 0.00 seconds) done.
>>>>>> done.
>>>>>> Freezing remaining freezable tasks ... Freezing remaining freeza=
ble
>>>>>> tasks ... (elapsed 0.01 seconds) (elapsed 0.01 seconds) done.don=
e.
>>>>>>
>>>>>> Suspending console(s) (use no_console_suspend to debug)
>>>>>> Suspending console(s) (use no_console_suspend to debug)
>>>>>>
>>>>>> <snip>un-printable characters<snip>
>>>>>>
>>>>>> Powerdomain (per_pwrdm) didn't enter target state 1
>>>>>> Could not enter target state in pm_suspend
>>>>>> Restarting tasks ... Restarting tasks ... done.
>>>>>> done.
>>>>>
>>>>> This is what I see on Beagle as well (PER is not entering retenti=
on.)
>>>>>
>>>>> At this point, the current PM debug code doesn't help further in
>>>>> determining exactly why a powerdomain did not hit its target stat=
e.
>>>>> Some device in the domain may still have its clocks enabled, or i=
ts
>>>>> idle state not set correctly.  Or, a given module may have been
>>>>> initialized by the bootloader in a way which prevents it from goi=
ng
>>>>> idle.
>>>>>
>>>>  True. I have observed on omap3evm with minimum configuration, and
>>>> booting out of ramdisk:
>>>>          with nand booting:  only per powerdomain does not enter
>>>> retention
>>>>          with mmc boot:  core and per dont enter retention
>>>>
>>>>   it could do with clocks set the bootloaders that is preventing i=
t from
>>>>   entering ret/off.
>>>
>>> To tackle this you should have CONFIG_OMAP_RESET_CLOCKS enabled in
>>> config.
>>>
>>>>   what do you mean by idle state not set correctly? are you referr=
ing
>>>> to auto-idle bit?
>>>
>>> Not sure what Kevin meant there, but if the problem was in the
>>> autoidle bit in *_SYSCONFIG, I would expect also CORE pwrdm to
>>> fail. Anyway it's also worth of checking the statuses of PER module=
s
>>> *_SYSCONFIG registers.
>>>
>>>>
>>>>> We need some improved PM debug capabilities in the kernel to pinp=
oint
>>>>> exactly the module that is causing the problem.
>>>>>
>>>>   Apart from PM debug, are you using any other module/methods to
>>>>   debug?
>>>
>>> State of PRCM registers can be quickly checked from
>>> /sys/kernel/debug/pm_debug/registers/current (assuming you have mou=
nt
>>> debugfs in /sys/kernel/debug and PM_DEBUG is enabled in config).
>>>
>>> --
>>> Jouni H=F6gander
>>>
>>>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
