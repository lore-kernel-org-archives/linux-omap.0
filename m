From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: new PM branch available
Date: Fri, 23 Jan 2009 13:21:34 +0200
Message-ID: <877i4mgtdt.fsf@trdhcp146196.ntc.nokia.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02F5110938@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:41255 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754878AbZAWLUY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2009 06:20:24 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02F5110938@dbde02.ent.ti.com>
	(ext Nayak's message of "Fri, 23 Jan 2009 15:49:30 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Nayak, Rajendra" <rnayak@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"ext Nayak, Rajendra" <rnayak@ti.com> writes:

>> I did some testing today on my 3.0GP 3430SDP. This is with the omap_=
3430sdp_min_defconfig.
>>
>> 1) Idle.
>> echo -n 1 > /sys/power/clocks_off_while_idle
>> echo -n 1 > /sys/power/enable_off
>> Could not hit RET. something seems to be still active. Not sure if i=
t could be something
>> to do with this error that's thrown while bootup
>>
>> <6>Disabling unused clock "dpll5_ck"
>> Disabling unused clock "dpll5_ck"
>> <3>clock: dpll5_ck failed transition to 'locked'
>> clock: dpll5_ck failed transition to 'locked'
>>=20
>> This is the same results I see on my SDP.
>>=20
>> Looking at the registers, I am pretty sure it is the D2D clockdomain
>> that still has activity, but due to very poor Stacked-mode docs and =
no
>> responses to the D2D questions asked to TI I have not been able to
>> figure this one out.
>>=20
>> Help debugging this would be greatly appreciated.
>
> I looked some more into this today and saw that the hang is indeed ca=
used
> due to some kind of debug console going dead. The system was still lo=
oping in the
> idle thread. I could even do a telnet remotely to my board and take
> some debug dumps..

This might help you:

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.=
c
index b2db0ba..266e4f5 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -401,6 +401,8 @@ void omap_sram_idle(void)
                        omap3_prcm_restore_context();
                        omap3_sram_restore_context();
                }
+               omap_uart_resume_idle(0);
+               omap_uart_resume_idle(1);
                if (core_next_state =3D=3D PWRDM_POWER_OFF)
                        prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF,
                                               OMAP3430_GR_MOD,

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
