From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v3] OMAP2+: disable idle early in the suspend sequence
Date: Thu, 9 Dec 2010 21:05:19 +0100
Message-ID: <AANLkTimNUjyzWP7inadpQA60tn3yp-x3bANYC8=6UPPR@mail.gmail.com>
References: <1291916398-18117-1-git-send-email-jean.pihet@newoldbits.com>
	<87r5dqaks3.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55979 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757124Ab0LIUFU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 15:05:20 -0500
Received: by vws16 with SMTP id 16so1912849vws.19
        for <linux-omap@vger.kernel.org>; Thu, 09 Dec 2010 12:05:19 -0800 (PST)
In-Reply-To: <87r5dqaks3.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Thu, Dec 9, 2010 at 7:00 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> jean.pihet@newoldbits.com writes:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> Some bad interaction between the idle and the suspend paths has been
>> identified: the idle code is called during the suspend enter and exi=
t
>> sequences. This could cause corruption or lock-up of resources.
>>
>> The solution is to move the calls to disable_hlt at the very beginni=
ng
>> of the suspend sequence (ex. in omap3_pm_begin instead of
>> omap3_pm_prepare), and the call to enable_hlt at the very end of
>> the suspend sequence (ex. in omap3_pm_end instead of omap3_pm_finish=
).
>>
>> Tested with RET and OFF on Beagle and OMAP3EVM.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>
> OK, one more time... can you Cc linux-arm-kernel as well.
Done!

> This avoids having to repost to linux-arm-kernel before final merge.
> After that, will queue in pm-next for 2.6.38.
>
> Thanks,
>
> Kevin

Jean

>
>> ---
>> v1:
>> =A0Support for OMAP3 only.
>> =A0Tested on board.
>>
>> v2:
>> =A0Added support for OMAP2 and OMAP4.
>> =A0Compile tested only for OMAP2 and OMAP4.
>> =A0Tested on board for OMAP3.
>>
>> v3:
>> =A0Rebased on Kevin's latest 'OMAP2+: PM/serial: fix console semapho=
re acquire during suspend', cf. http://marc.info/?l=3Dlinux-omap&m=3D12=
9184804805075&w=3D2
>> =A0Removed the empty _pm_prepare and _pm_finish functions.
>>
>> =A0arch/arm/mach-omap2/pm24xx.c | =A0 16 ++--------------
>> =A0arch/arm/mach-omap2/pm34xx.c | =A0 15 ++-------------
>> =A0arch/arm/mach-omap2/pm44xx.c | =A0 16 ++--------------
>> =A03 files changed, 6 insertions(+), 41 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24=
xx.c
>> index 1e031d0..6cde8ed 100644
>> --- a/arch/arm/mach-omap2/pm24xx.c
>> +++ b/arch/arm/mach-omap2/pm24xx.c
>> @@ -301,14 +301,8 @@ out:
>>
>> =A0static int omap2_pm_begin(suspend_state_t state)
>> =A0{
>> - =A0 =A0 suspend_state =3D state;
>> - =A0 =A0 return 0;
>> -}
>> -
>> -static int omap2_pm_prepare(void)
>> -{
>> - =A0 =A0 /* We cannot sleep in idle until we have resumed */
>> =A0 =A0 =A0 disable_hlt();
>> + =A0 =A0 suspend_state =3D state;
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> @@ -349,22 +343,16 @@ static int omap2_pm_enter(suspend_state_t stat=
e)
>> =A0 =A0 =A0 return ret;
>> =A0}
>>
>> -static void omap2_pm_finish(void)
>> -{
>> - =A0 =A0 enable_hlt();
>> -}
>> -
>> =A0static void omap2_pm_end(void)
>> =A0{
>> =A0 =A0 =A0 suspend_state =3D PM_SUSPEND_ON;
>> + =A0 =A0 enable_hlt();
>> =A0 =A0 =A0 return;
>> =A0}
>>
>> =A0static struct platform_suspend_ops omap_pm_ops =3D {
>> =A0 =A0 =A0 .begin =A0 =A0 =A0 =A0 =A0=3D omap2_pm_begin,
>> - =A0 =A0 .prepare =A0 =A0 =A0 =A0=3D omap2_pm_prepare,
>> =A0 =A0 =A0 .enter =A0 =A0 =A0 =A0 =A0=3D omap2_pm_enter,
>> - =A0 =A0 .finish =A0 =A0 =A0 =A0 =3D omap2_pm_finish,
>> =A0 =A0 =A0 .end =A0 =A0 =A0 =A0 =A0 =A0=3D omap2_pm_end,
>> =A0 =A0 =A0 .valid =A0 =A0 =A0 =A0 =A0=3D suspend_valid_only_mem,
>> =A0};
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34=
xx.c
>> index 648b8c5..5bf344a 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -529,12 +529,6 @@ out:
>> =A0}
>>
>> =A0#ifdef CONFIG_SUSPEND
>> -static int omap3_pm_prepare(void)
>> -{
>> - =A0 =A0 disable_hlt();
>> - =A0 =A0 return 0;
>> -}
>> -
>> =A0static int omap3_pm_suspend(void)
>> =A0{
>> =A0 =A0 =A0 struct power_state *pwrst;
>> @@ -597,14 +591,10 @@ static int omap3_pm_enter(suspend_state_t unus=
ed)
>> =A0 =A0 =A0 return ret;
>> =A0}
>>
>> -static void omap3_pm_finish(void)
>> -{
>> - =A0 =A0 enable_hlt();
>> -}
>> -
>> =A0/* Hooks to enable / disable UART interrupts during suspend */
>> =A0static int omap3_pm_begin(suspend_state_t state)
>> =A0{
>> + =A0 =A0 disable_hlt();
>> =A0 =A0 =A0 suspend_state =3D state;
>> =A0 =A0 =A0 omap_uart_enable_irqs(0);
>> =A0 =A0 =A0 return 0;
>> @@ -614,15 +604,14 @@ static void omap3_pm_end(void)
>> =A0{
>> =A0 =A0 =A0 suspend_state =3D PM_SUSPEND_ON;
>> =A0 =A0 =A0 omap_uart_enable_irqs(1);
>> + =A0 =A0 enable_hlt();
>> =A0 =A0 =A0 return;
>> =A0}
>>
>> =A0static struct platform_suspend_ops omap_pm_ops =3D {
>> =A0 =A0 =A0 .begin =A0 =A0 =A0 =A0 =A0=3D omap3_pm_begin,
>> =A0 =A0 =A0 .end =A0 =A0 =A0 =A0 =A0 =A0=3D omap3_pm_end,
>> - =A0 =A0 .prepare =A0 =A0 =A0 =A0=3D omap3_pm_prepare,
>> =A0 =A0 =A0 .enter =A0 =A0 =A0 =A0 =A0=3D omap3_pm_enter,
>> - =A0 =A0 .finish =A0 =A0 =A0 =A0 =3D omap3_pm_finish,
>> =A0 =A0 =A0 .valid =A0 =A0 =A0 =A0 =A0=3D suspend_valid_only_mem,
>> =A0};
>> =A0#endif /* CONFIG_SUSPEND */
>> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44=
xx.c
>> index 54544b4..6aff996 100644
>> --- a/arch/arm/mach-omap2/pm44xx.c
>> +++ b/arch/arm/mach-omap2/pm44xx.c
>> @@ -31,12 +31,6 @@ struct power_state {
>> =A0static LIST_HEAD(pwrst_list);
>>
>> =A0#ifdef CONFIG_SUSPEND
>> -static int omap4_pm_prepare(void)
>> -{
>> - =A0 =A0 disable_hlt();
>> - =A0 =A0 return 0;
>> -}
>> -
>> =A0static int omap4_pm_suspend(void)
>> =A0{
>> =A0 =A0 =A0 do_wfi();
>> @@ -59,28 +53,22 @@ static int omap4_pm_enter(suspend_state_t suspen=
d_state)
>> =A0 =A0 =A0 return ret;
>> =A0}
>>
>> -static void omap4_pm_finish(void)
>> -{
>> - =A0 =A0 enable_hlt();
>> - =A0 =A0 return;
>> -}
>> -
>> =A0static int omap4_pm_begin(suspend_state_t state)
>> =A0{
>> + =A0 =A0 disable_hlt();
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> =A0static void omap4_pm_end(void)
>> =A0{
>> + =A0 =A0 enable_hlt();
>> =A0 =A0 =A0 return;
>> =A0}
>>
>> =A0static struct platform_suspend_ops omap_pm_ops =3D {
>> =A0 =A0 =A0 .begin =A0 =A0 =A0 =A0 =A0=3D omap4_pm_begin,
>> =A0 =A0 =A0 .end =A0 =A0 =A0 =A0 =A0 =A0=3D omap4_pm_end,
>> - =A0 =A0 .prepare =A0 =A0 =A0 =A0=3D omap4_pm_prepare,
>> =A0 =A0 =A0 .enter =A0 =A0 =A0 =A0 =A0=3D omap4_pm_enter,
>> - =A0 =A0 .finish =A0 =A0 =A0 =A0 =3D omap4_pm_finish,
>> =A0 =A0 =A0 .valid =A0 =A0 =A0 =A0 =A0=3D suspend_valid_only_mem,
>> =A0};
>> =A0#endif /* CONFIG_SUSPEND */
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
