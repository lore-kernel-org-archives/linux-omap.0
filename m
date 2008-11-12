From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH PM-20081106] OMAP3: UART: Make sure that uart clocks are enabled when needed
Date: Wed, 12 Nov 2008 15:35:04 +0200
Message-ID: <871vxhm5iv.fsf@trdhcp146196.ntc.nokia.com>
References: <87od0ldw9c.fsf@trdhcp146196.ntc.nokia.com>
	<1226489259-1018-1-git-send-email-jouni.hogander@nokia.com>
	<8763mtm6j8.fsf@trdhcp146196.ntc.nokia.com>
	<8bf247760811120525y6130d4cdne70bfd1d999610e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:36729 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbYKLNfJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2008 08:35:09 -0500
In-Reply-To: <8bf247760811120525y6130d4cdne70bfd1d999610e@mail.gmail.com> (ext
	Sriram V.'s message of "Wed, 12 Nov 2008 18:55:34 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Sriram V <vshrirama@gmail.com>
Cc: linux-omap@vger.kernel.org

"ext Sriram V" <vshrirama@gmail.com> writes:

> Hi jouni,
>    Does the branch "PM-20081106" work for you?
>
>    When i try to do a "echo mem > /sys/power/state" on omap3evm.
>
>    the system hangs. Does Suspend-Resume work on this branch?

Yes, but you need to apply this patch (or something similiar). Have
you done it and still seeing problems?

>
>
> [root@OMAP3EVM /proc]# echo mem > /sys/power/state
> <6>PM: Syncing filesystems ... PM: Syncing filesystems ... done.
> done.
> Freezing user space processes ... Freezing user space processes ...
> (elapsed 0.00 seconds) (elapsed 0.00 seconds) done.
> done.
> Freezing remaining freezable tasks ... Freezing remaining freezable
> tasks ... (elapsed 0.00 seconds) (elapsed 0.00 seconds) done.done.
>
> Suspending console(s) (use no_console_suspend to debug)
> Suspending console(s) (use no_console_suspend to debug)
>
> ---- system hangs----
>
>
> With Regards,
> Sriram
>
>
>
> On Wed, Nov 12, 2008 at 6:43 PM, H=C3=B6gander Jouni
> <jouni.hogander@nokia.com> wrote:
>> "ext Jouni Hogander" <jouni.hogander@nokia.com> writes:
>>
>>> Current implementation makes it possible that printouts are
>>> written into UART while its clocks are disabled. This causes freeze=
=2E
>>
>> Now I got how this new uart clock handling works. Event thought this
>> fix is not too sensible it actually does what is needed.
>>
>> So the problem is that uart clocks are enabled in prcm_interrupt. No=
w
>> if some other interrupt handler is run before prcm_interrupt_handler
>> and it tries to printout something to uart -> system freezes.
>>
>> Kevin, you should ensure some way that uart clocks are enabled right
>> away after wakeup. This patch presents one possibile
>> implementation. Another way could be to move uart_check_wakeup to be
>> run in idle loop rather than in interrupt handler.
>>
>>>
>>> This patch contains possible fix for this.
>>>
>>> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
>>> ---
>>>  arch/arm/mach-omap2/pm34xx.c             |    6 ++++++
>>>  arch/arm/mach-omap2/serial.c             |   30 ++++++++++++++++++=
++++++++++++
>>>  arch/arm/plat-omap/include/mach/serial.h |    2 ++
>>>  3 files changed, 38 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm3=
4xx.c
>>> index d480c39..3838a19 100644
>>> --- a/arch/arm/mach-omap2/pm34xx.c
>>> +++ b/arch/arm/mach-omap2/pm34xx.c
>>> @@ -320,6 +320,7 @@ void omap_sram_idle(void)
>>>       /* PER */
>>>       per_next_state =3D pwrdm_read_next_pwrst(per_pwrdm);
>>>       if (per_next_state < PWRDM_POWER_ON) {
>>> +             omap_uart_prepare_idle(2);
>>>               omap2_gpio_prepare_for_retention();
>>>               if (per_next_state =3D=3D PWRDM_POWER_OFF)
>>>                       omap3_per_save_context();
>>> @@ -328,6 +329,8 @@ void omap_sram_idle(void)
>>>       /* CORE */
>>>       core_next_state =3D pwrdm_read_next_pwrst(core_pwrdm);
>>>       if (core_next_state < PWRDM_POWER_ON) {
>>> +             omap_uart_prepare_idle(0);
>>> +             omap_uart_prepare_idle(1);
>>>               if (core_next_state =3D=3D PWRDM_POWER_OFF) {
>>>                       prm_set_mod_reg_bits(OMAP3430_AUTO_OFF,
>>>                                            OMAP3430_GR_MOD,
>>> @@ -386,6 +389,8 @@ void omap_sram_idle(void)
>>>                       prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF,
>>>                                              OMAP3430_GR_MOD,
>>>                                              OMAP3_PRM_VOLTCTRL_OFF=
SET);
>>> +             omap_uart_resume_idle(0);
>>> +             omap_uart_resume_idle(1);
>>>       }
>>>
>>>       /* PER */
>>> @@ -394,6 +399,7 @@ void omap_sram_idle(void)
>>>               if (per_prev_state =3D=3D PWRDM_POWER_OFF)
>>>                       omap3_per_restore_context();
>>>               omap2_gpio_resume_after_retention();
>>> +             omap_uart_resume_idle(2);
>>>       }
>>>
>>>       /* Enable smartreflex after WFI */
>>> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/ser=
ial.c
>>> index 65cce87..ef30d8d 100644
>>> --- a/arch/arm/mach-omap2/serial.c
>>> +++ b/arch/arm/mach-omap2/serial.c
>>> @@ -249,6 +249,36 @@ static void omap_uart_idle_timer(unsigned long=
 data)
>>>       omap_uart_allow_sleep(uart);
>>>  }
>>>
>>> +void omap_uart_prepare_idle(int num)
>>> +{
>>> +     struct omap_uart_state *uart;
>>> +
>>> +     if (!clocks_off_while_idle)
>>> +             return;
>>> +
>>> +     list_for_each_entry(uart, &uart_list, node) {
>>> +             if (num =3D=3D uart->num && uart->can_sleep) {
>>> +                     omap_uart_disable_clocks(uart);
>>> +                     return;
>>> +             }
>>> +     }
>>> +}
>>> +
>>> +void omap_uart_resume_idle(int num)
>>> +{
>>> +     struct omap_uart_state *uart;
>>> +
>>> +     if (!clocks_off_while_idle)
>>> +             return;
>>> +
>>> +     list_for_each_entry(uart, &uart_list, node) {
>>> +             if (num =3D=3D uart->num) {
>>> +                     omap_uart_enable_clocks(uart);
>>> +                     return;
>>> +             }
>>> +     }
>>> +}
>>> +
>>>  void omap_uart_check_wakeup(void)
>>>  {
>>>       struct omap_uart_state *uart;
>>> diff --git a/arch/arm/plat-omap/include/mach/serial.h b/arch/arm/pl=
at-omap/include/mach/serial.h
>>> index 11ff540..254a775 100644
>>> --- a/arch/arm/plat-omap/include/mach/serial.h
>>> +++ b/arch/arm/plat-omap/include/mach/serial.h
>>> @@ -44,6 +44,8 @@
>>>  extern void omap_serial_init(void);
>>>  extern int omap_uart_can_sleep(void);
>>>  extern void omap_uart_check_wakeup(void);
>>> +extern void omap_uart_prepare_idle(int num);
>>> +extern void omap_uart_resume_idle(int num);
>>>  #endif
>>>
>>>  #endif
>>> --
>>> 1.6.0.1
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-oma=
p" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> --
>> Jouni H=C3=B6gander
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
