From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] OMAP3: disable idle early in the suspend sequence
Date: Mon, 22 Nov 2010 20:40:02 +0100
Message-ID: <AANLkTinb=QoQERdrCUU4nqoEn1Ukj9d3oRyuJW0bgvKA@mail.gmail.com>
References: <1290422697-2300-1-git-send-email-j-pihet@ti.com>
	<87y68luu0c.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:60460 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756684Ab0KVTkD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 14:40:03 -0500
Received: by qyk11 with SMTP id 11so602425qyk.19
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 11:40:03 -0800 (PST)
In-Reply-To: <87y68luu0c.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jean Pihet <j-pihet@ti.com>

On Mon, Nov 22, 2010 at 6:51 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Jean Pihet <jean.pihet@newoldbits.com> writes:
>
>> Some bad interaction between the idle and the suspend paths has been
>> noticed: the idle code is called during the suspend enter and exit
>> sequences. This could cause corruption or lock-up of resources.
>
>> The solution is to move the call to disable_hlt at the very beginnin=
g
>> of the suspend sequence (in omap3_pm_begin instead of omap3_pm_prepa=
re),
>> and the call to enable_hlt at the very end of the suspend sequence
>> (in omap3_pm_end instead of omap3_pm_finish).
>>
>> Tested with RET and OFF on Beagle and OMAP3EVM.
>
> I think the description could have a little more detail. =A0Something=
 like:
>
> Idle path should be disabled during the entire suspend/resume sequenc=
e.
> Currently it is disabled in ->prepare() and re-enabled in ->finish(),
> but the suspend sequence starts with ->begin() and ends with ->end(),
> leaving windows where the suspend/resume sequence is still underway a=
nd
> idle code could execute.
>
> To fix, move idle disable and enable into ->begin() and ->end()
> respectively to ensure idle path is disabled for the entire
> suspend/resume sequence.
>
Ok thx for the suggestion.

>>
>> @@ -576,12 +575,12 @@ static int omap3_pm_enter(suspend_state_t unus=
ed)
>>
>> =A0static void omap3_pm_finish(void)
>> =A0{
>> - =A0 =A0 enable_hlt();
>> =A0}
>
> Might as well remove these empty functions now.
>
>> =A0/* Hooks to enable / disable UART interrupts during suspend */
>> =A0static int omap3_pm_begin(suspend_state_t state)
>> =A0{
>> + =A0 =A0 disable_hlt();
>> =A0 =A0 =A0 suspend_state =3D state;
>> =A0 =A0 =A0 omap_uart_enable_irqs(0);
>> =A0 =A0 =A0 return 0;
>> @@ -591,6 +590,7 @@ static void omap3_pm_end(void)
>> =A0{
>> =A0 =A0 =A0 suspend_state =3D PM_SUSPEND_ON;
>> =A0 =A0 =A0 omap_uart_enable_irqs(1);
>> + =A0 =A0 enable_hlt();
>> =A0 =A0 =A0 return;
>> =A0}
>
> Kevin
>

Ok resent!

Thx,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
