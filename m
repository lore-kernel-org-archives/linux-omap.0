From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: new PM branch available
Date: Fri, 23 Jan 2009 09:48:32 -0800
Message-ID: <871vut7w27.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02F51109B5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.184]:51700 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755189AbZAWRsi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2009 12:48:38 -0500
Received: by rn-out-0910.google.com with SMTP id k40so1133592rnd.17
        for <linux-omap@vger.kernel.org>; Fri, 23 Jan 2009 09:48:36 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02F51109B5@dbde02.ent.ti.com> (Rajendra Nayak's message of "Fri\, 23 Jan 2009 17\:30\:24 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: =?iso-8859-1?Q?H=F6gander?= Jouni <jouni.hogander@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Nayak, Rajendra" <rnayak@ti.com> writes:

> =20
>
>> -----Original Message-----
>> From: H=F6gander Jouni [mailto:jouni.hogander@nokia.com]=20
>> Sent: Friday, January 23, 2009 4:52 PM
>> To: Nayak, Rajendra
>> Cc: Kevin Hilman; linux-omap@vger.kernel.org
>> Subject: Re: new PM branch available
>>=20
>> "ext Nayak, Rajendra" <rnayak@ti.com> writes:
>>=20
>> >> I did some testing today on my 3.0GP 3430SDP. This is with=20
>> the omap_3430sdp_min_defconfig.
>> >>
>> >> 1) Idle.
>> >> echo -n 1 > /sys/power/clocks_off_while_idle
>> >> echo -n 1 > /sys/power/enable_off
>> >> Could not hit RET. something seems to be still active. Not=20
>> sure if it could be something
>> >> to do with this error that's thrown while bootup
>> >>
>> >> <6>Disabling unused clock "dpll5_ck"
>> >> Disabling unused clock "dpll5_ck"
>> >> <3>clock: dpll5_ck failed transition to 'locked'
>> >> clock: dpll5_ck failed transition to 'locked'
>> >>=20
>> >> This is the same results I see on my SDP.
>> >>=20
>> >> Looking at the registers, I am pretty sure it is the D2D=20
>> clockdomain
>> >> that still has activity, but due to very poor Stacked-mode=20
>> docs and no
>> >> responses to the D2D questions asked to TI I have not been able t=
o
>> >> figure this one out.
>> >>=20
>> >> Help debugging this would be greatly appreciated.
>> >
>> > I looked some more into this today and saw that the hang is=20
>> indeed caused
>> > due to some kind of debug console going dead. The system=20
>> was still looping in the
>> > idle thread. I could even do a telnet remotely to my board and tak=
e
>> > some debug dumps..
>>=20
>> This might help you:
>
> Yup, this does help. There's no hang now either in idle or in suspend=
=2E

Rajendra,

Is CORE hitting retention for you?  while UART wakeups are now working,
CORE is still not hitting retention.

Kevin

> Not sure why this was affecting only the SDP while the pm branch seem=
s
> to function without this for beagle and other omap3 platforms?
>
>>=20
>> diff --git a/arch/arm/mach-omap2/pm34xx.c=20
>> b/arch/arm/mach-omap2/pm34xx.c
>> index b2db0ba..266e4f5 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -401,6 +401,8 @@ void omap_sram_idle(void)
>>                         omap3_prcm_restore_context();
>>                         omap3_sram_restore_context();
>>                 }
>> +               omap_uart_resume_idle(0);
>> +               omap_uart_resume_idle(1);
>>                 if (core_next_state =3D=3D PWRDM_POWER_OFF)
>>                         prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF,
>>                                                OMAP3430_GR_MOD,
>>=20
>> --=20
>> Jouni H=F6gander
>>=20
>>=20
>>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
