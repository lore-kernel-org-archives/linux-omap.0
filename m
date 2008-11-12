From: "Sriram V" <vshrirama@gmail.com>
Subject: Re: [PATCH PM-20081106] OMAP3: UART: Make sure that uart clocks are enabled when needed
Date: Wed, 12 Nov 2008 21:28:18 +0530
Message-ID: <8bf247760811120758m7d4ab607yde1288b053a7834f@mail.gmail.com>
References: <87od0ldw9c.fsf@trdhcp146196.ntc.nokia.com>
	 <1226489259-1018-1-git-send-email-jouni.hogander@nokia.com>
	 <8763mtm6j8.fsf@trdhcp146196.ntc.nokia.com>
	 <8bf247760811120525y6130d4cdne70bfd1d999610e@mail.gmail.com>
	 <871vxhm5iv.fsf@trdhcp146196.ntc.nokia.com>
	 <8bf247760811120540k52fb6132u4b61e28407b799ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:14215 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751AbYKLP6V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2008 10:58:21 -0500
Received: by fg-out-1718.google.com with SMTP id 19so434318fgg.17
        for <linux-omap@vger.kernel.org>; Wed, 12 Nov 2008 07:58:19 -0800 (PST)
In-Reply-To: <8bf247760811120540k52fb6132u4b61e28407b799ec@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,
   I just tried to find the source of the problem with PM-20081106 bran=
ch.
   Am trying to debug this issue now.


   I tried to do a check to find which commit caused the problem.
   I find that it is something to do with uart pm support.


  The patch commit 1e274e917472dba6c216b67c3afb3e7abe6e77e4
   OMAP3: PM: Allow UARTs to be unclocked when inactive

   introduces this issue.


Regards,
sriram




On Wed, Nov 12, 2008 at 7:10 PM, Sriram V <vshrirama@gmail.com> wrote:
> Hi jouni,
> I have disabled all the drivers except i2c and network also.
> i have applied your patch and still seeing problems.
>
> doing a echo mem > /sys/power/state makes the system to hang.
>
> does this work for you?
>
>
> Regards,
> sriram
>
>
> On Wed, Nov 12, 2008 at 7:05 PM, H=F6gander Jouni
> <jouni.hogander@nokia.com> wrote:
>> "ext Sriram V" <vshrirama@gmail.com> writes:
>>
>>> Hi jouni,
>>>    Does the branch "PM-20081106" work for you?
>>>
>>>    When i try to do a "echo mem > /sys/power/state" on omap3evm.
>>>
>>>    the system hangs. Does Suspend-Resume work on this branch?
>>
>> Yes, but you need to apply this patch (or something similiar). Have
>> you done it and still seeing problems?
>>
>>>
>>>
>>> [root@OMAP3EVM /proc]# echo mem > /sys/power/state
>>> <6>PM: Syncing filesystems ... PM: Syncing filesystems ... done.
>>> done.
>>> Freezing user space processes ... Freezing user space processes ...
>>> (elapsed 0.00 seconds) (elapsed 0.00 seconds) done.
>>> done.
>>> Freezing remaining freezable tasks ... Freezing remaining freezable
>>> tasks ... (elapsed 0.00 seconds) (elapsed 0.00 seconds) done.done.
>>>
>>> Suspending console(s) (use no_console_suspend to debug)
>>> Suspending console(s) (use no_console_suspend to debug)
>>>
>>> ---- system hangs----
>>>
>>>
>>> With Regards,
>>> Sriram
>>>
>>>
>>>
>>> On Wed, Nov 12, 2008 at 6:43 PM, H=F6gander Jouni
>>> <jouni.hogander@nokia.com> wrote:
>>>> "ext Jouni Hogander" <jouni.hogander@nokia.com> writes:
>>>>
>>>>> Current implementation makes it possible that printouts are
>>>>> written into UART while its clocks are disabled. This causes free=
ze.
>>>>
>>>> Now I got how this new uart clock handling works. Event thought th=
is
>>>> fix is not too sensible it actually does what is needed.
>>>>
>>>> So the problem is that uart clocks are enabled in prcm_interrupt. =
Now
>>>> if some other interrupt handler is run before prcm_interrupt_handl=
er
>>>> and it tries to printout something to uart -> system freezes.
>>>>
>>>> Kevin, you should ensure some way that uart clocks are enabled rig=
ht
>>>> away after wakeup. This patch presents one possibile
>>>> implementation. Another way could be to move uart_check_wakeup to =
be
>>>> run in idle loop rather than in interrupt handler.
>>>>
>>>>>
>>>>> This patch contains possible fix for this.
>>>>>
>>>>> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
>>>>> ---
>>>>>  arch/arm/mach-omap2/pm34xx.c             |    6 ++++++
>>>>>  arch/arm/mach-omap2/serial.c             |   30 ++++++++++++++++=
++++++++++++++
>>>>>  arch/arm/plat-omap/include/mach/serial.h |    2 ++
>>>>>  3 files changed, 38 insertions(+), 0 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/p=
m34xx.c
>>>>> index d480c39..3838a19 100644
>>>>> --- a/arch/arm/mach-omap2/pm34xx.c
>>>>> +++ b/arch/arm/mach-omap2/pm34xx.c
>>>>> @@ -320,6 +320,7 @@ void omap_sram_idle(void)
>>>>>       /* PER */
>>>>>       per_next_state =3D pwrdm_read_next_pwrst(per_pwrdm);
>>>>>       if (per_next_state < PWRDM_POWER_ON) {
>>>>> +             omap_uart_prepare_idle(2);
>>>>>               omap2_gpio_prepare_for_retention();
>>>>>               if (per_next_state =3D=3D PWRDM_POWER_OFF)
>>>>>                       omap3_per_save_context();
>>>>> @@ -328,6 +329,8 @@ void omap_sram_idle(void)
>>>>>       /* CORE */
>>>>>       core_next_state =3D pwrdm_read_next_pwrst(core_pwrdm);
>>>>>       if (core_next_state < PWRDM_POWER_ON) {
>>>>> +             omap_uart_prepare_idle(0);
>>>>> +             omap_uart_prepare_idle(1);
>>>>>               if (core_next_state =3D=3D PWRDM_POWER_OFF) {
>>>>>                       prm_set_mod_reg_bits(OMAP3430_AUTO_OFF,
>>>>>                                            OMAP3430_GR_MOD,
>>>>> @@ -386,6 +389,8 @@ void omap_sram_idle(void)
>>>>>                       prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF,
>>>>>                                              OMAP3430_GR_MOD,
>>>>>                                              OMAP3_PRM_VOLTCTRL_O=
=46FSET);
>>>>> +             omap_uart_resume_idle(0);
>>>>> +             omap_uart_resume_idle(1);
>>>>>       }
>>>>>
>>>>>       /* PER */
>>>>> @@ -394,6 +399,7 @@ void omap_sram_idle(void)
>>>>>               if (per_prev_state =3D=3D PWRDM_POWER_OFF)
>>>>>                       omap3_per_restore_context();
>>>>>               omap2_gpio_resume_after_retention();
>>>>> +             omap_uart_resume_idle(2);
>>>>>       }
>>>>>
>>>>>       /* Enable smartreflex after WFI */
>>>>> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/s=
erial.c
>>>>> index 65cce87..ef30d8d 100644
>>>>> --- a/arch/arm/mach-omap2/serial.c
>>>>> +++ b/arch/arm/mach-omap2/serial.c
>>>>> @@ -249,6 +249,36 @@ static void omap_uart_idle_timer(unsigned lo=
ng data)
>>>>>       omap_uart_allow_sleep(uart);
>>>>>  }
>>>>>
>>>>> +void omap_uart_prepare_idle(int num)
>>>>> +{
>>>>> +     struct omap_uart_state *uart;
>>>>> +
>>>>> +     if (!clocks_off_while_idle)
>>>>> +             return;
>>>>> +
>>>>> +     list_for_each_entry(uart, &uart_list, node) {
>>>>> +             if (num =3D=3D uart->num && uart->can_sleep) {
>>>>> +                     omap_uart_disable_clocks(uart);
>>>>> +                     return;
>>>>> +             }
>>>>> +     }
>>>>> +}
>>>>> +
>>>>> +void omap_uart_resume_idle(int num)
>>>>> +{
>>>>> +     struct omap_uart_state *uart;
>>>>> +
>>>>> +     if (!clocks_off_while_idle)
>>>>> +             return;
>>>>> +
>>>>> +     list_for_each_entry(uart, &uart_list, node) {
>>>>> +             if (num =3D=3D uart->num) {
>>>>> +                     omap_uart_enable_clocks(uart);
>>>>> +                     return;
>>>>> +             }
>>>>> +     }
>>>>> +}
>>>>> +
>>>>>  void omap_uart_check_wakeup(void)
>>>>>  {
>>>>>       struct omap_uart_state *uart;
>>>>> diff --git a/arch/arm/plat-omap/include/mach/serial.h b/arch/arm/=
plat-omap/include/mach/serial.h
>>>>> index 11ff540..254a775 100644
>>>>> --- a/arch/arm/plat-omap/include/mach/serial.h
>>>>> +++ b/arch/arm/plat-omap/include/mach/serial.h
>>>>> @@ -44,6 +44,8 @@
>>>>>  extern void omap_serial_init(void);
>>>>>  extern int omap_uart_can_sleep(void);
>>>>>  extern void omap_uart_check_wakeup(void);
>>>>> +extern void omap_uart_prepare_idle(int num);
>>>>> +extern void omap_uart_resume_idle(int num);
>>>>>  #endif
>>>>>
>>>>>  #endif
>>>>> --
>>>>> 1.6.0.1
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-o=
map" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
>>>>
>>>> --
>>>> Jouni H=F6gander
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-om=
ap" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>
>> --
>> Jouni H=F6gander
>>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
