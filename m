From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH] OMAP3 powerdomains: remove RET from SGX power states list
Date: Tue, 11 Nov 2008 09:55:26 +0200
Message-ID: <87r65i66j5.fsf@trdhcp146196.ntc.nokia.com>
References: <alpine.DEB.2.00.0811051152150.15612@utopia.booyaka.com>
	<20081106033327.GQ21736@atomide.com>
	<alpine.DEB.2.00.0811060401150.11718@utopia.booyaka.com>
	<87ej1na8c2.fsf@trdhcp146196.ntc.nokia.com>
	<alpine.DEB.2.00.0811100741420.23090@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:50735 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbYKKHz7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 02:55:59 -0500
In-Reply-To: <alpine.DEB.2.00.0811100741420.23090@utopia.booyaka.com> (ext
	Paul Walmsley's message of "Mon, 10 Nov 2008 07:45:02 -0700 (MST)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, "Stoppa Igor \\(Nokia-D/Helsinki\\)" <Igor.Stoppa@nokia.com>, r-woodruff2@ti.com, Kevin Hilman <khilman@deeprootsystems.com>, "Sawant, Anand" <sawant@ti.com>, Poussa Sakari <sakari.poussa@nokia.com>

"ext Paul Walmsley" <paul@pwsan.com> writes:

> Hi Jouni,
>
> On Fri, 7 Nov 2008, H=C3=B6gander Jouni wrote:
>
>> What do you Paul think about patch below:
>
> I'm okay with it, but one potential problem: won't this prevent the c=
hip=20
> from entering retention, since SGX will be set to ON?

Yes, you are right here.

>
> Anyway, if you agree this is a problem, what do you think about addin=
g a=20
> powerdomain flag that indicates that the powerdomain next power state=
=20
> should be set to OFF on initialization, and then testing that in=20
> set_pwrdm_state() ?

I wouldn't add any flags for this. The goal is finally to set all
next_states as OFF until someone has set some constraint which
prevents OFF usage. For now we need to use RET as default, because
drivers are not supporting OFF mode. Do you agree this?

Easiest way here would be to add own hook for SGX in pwrdms_setup? One
more strcmp("*_pwrdm, pwrdm->name) :)

What do you think?

>
> - Paul
>
>
>> From: Jouni Hogander <jouni.hogander@nokia.com>
>> Date: Fri, 7 Nov 2008 16:50:51 +0200
>> Subject: [PATCH] OMAP3: PM: Check that wanted state is supported by =
pwrdm in pwrdms_setup
>>=20
>> Check that wanted sleep state is supported by powerdomain. If it is
>> not supported, then use next highest supported state.
>>=20
>> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
>> ---
>>  arch/arm/mach-omap2/pm34xx.c |   11 ++++++++++-
>>  1 files changed, 10 insertions(+), 1 deletions(-)
>>=20
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34=
xx.c
>> index da098d2..d9959a8 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -515,6 +515,7 @@ static void __init prcm_setup_regs(void)
>>  static int __init pwrdms_setup(struct powerdomain *pwrdm)
>>  {
>>  	struct power_state *pwrst;
>> +	u32 next_state =3D PWRDM_POWER_RET;
>> =20
>>  	if (!pwrdm->pwrsts)
>>  		return 0;
>> @@ -523,12 +524,20 @@ static int __init pwrdms_setup(struct powerdom=
ain *pwrdm)
>>  	if (!pwrst)
>>  		return -ENOMEM;
>>  	pwrst->pwrdm =3D pwrdm;
>> -	pwrst->next_state =3D PWRDM_POWER_RET;
>>  	list_add(&pwrst->node, &pwrst_list);
>> =20
>>  	if (pwrdm_has_hdwr_sar(pwrdm))
>>  		pwrdm_enable_hdwr_sar(pwrdm);
>> =20
>> +	while (!(pwrdm->pwrsts & (1 << next_state))) {
>> +		if (next_state > PWRDM_POWER_ON) {
>> +			next_state =3D pwrdm_read_next_pwrst(pwrst->pwrdm);
>> +			break;
>> +		}
>> +		next_state++;
>> +	}
>> +	pwrst->next_state =3D next_state;
>> +
>>  	return set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
>>  }
>> =20
>> --=20
>> 1.6.0.1
>>=20
>>=20
>
>
> - Paul

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
