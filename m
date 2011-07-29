From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 07/13] OMAP PM: early init of the pwrdms states
Date: Fri, 29 Jul 2011 10:50:19 +0200
Message-ID: <CAORVsuUovg7px5SGC+mt7CoDcXZ8r2d09obkXqSp=g44U1G9EQ@mail.gmail.com>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
	<1311841821-10252-8-git-send-email-j-pihet@ti.com>
	<20110729080820.GB26959@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:51811 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755513Ab1G2IuU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jul 2011 04:50:20 -0400
Received: by qwk3 with SMTP id 3so1725146qwk.19
        for <linux-omap@vger.kernel.org>; Fri, 29 Jul 2011 01:50:19 -0700 (PDT)
In-Reply-To: <20110729080820.GB26959@google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, markgross@thegnar.org, broonie@opensource.wolfsonmicro.com, Jean Pihet <j-pihet@ti.com>, rnayak@ti.com

On Fri, Jul 29, 2011 at 10:08 AM, Todd Poynor <toddpoynor@google.com> w=
rote:
> On Thu, Jul 28, 2011 at 10:30:14AM +0200, jean.pihet@newoldbits.com w=
rote:
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> The powerdomains next states are initialized in pwrdms_setup as a
>> late_initcall. Because the PM QoS devices constraint can be requeste=
d
>> early in the boot sequence, the power domains next states can be
>> overwritten by pwrdms_setup.
>>
>> This patch fixes it by initializing the power domains next states
>> early at boot, so that the constraints can be applied.
>> Later in the pwrdms_setup function the currently programmed
>> next states are re-used as next state values.
>>
>> Applies to OMAP3 and OMAP4.
>>
>> Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using
>> wake-up latency constraints on MPU, CORE and PER.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> ---
> ...
>> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2=
/powerdomain.c
>> index 9af0847..63c3e7a 100644
>> --- a/arch/arm/mach-omap2/powerdomain.c
>> +++ b/arch/arm/mach-omap2/powerdomain.c
>> @@ -108,6 +108,9 @@ static int _pwrdm_register(struct powerdomain *p=
wrdm)
>> =A0 =A0 =A0 pwrdm->state =3D pwrdm_read_pwrst(pwrdm);
>> =A0 =A0 =A0 pwrdm->state_counter[pwrdm->state] =3D 1;
>>
>> + =A0 =A0 /* Early init of the next power state */
>> + =A0 =A0 pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_RET);
>> +
>
> Wanted to check that it's OK to initialize the next state of a power
> domain to RETENTION early in the boot sequence. =A0I believe patches
> have been previously discussed that set the state to ON to ensure the
> domain doesn't go to a lower state, and possibly lose context, before
> the PM subsystem is setup to handle it? =A0Not sure, thought maybe wo=
rth
> a doublecheck.
Indeed I need to check the behavior for OMAP3 & 4 which seem to
initialize the pwrdm states differently.
BTW the patch that inits all pwrdms to ON is not yet in l-o master
that is why I (lazily) submitted this one for now.

>
>
> Todd
>
>

Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
