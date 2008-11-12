From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH] OMAP3 powerdomains: remove RET from SGX power states list
Date: Wed, 12 Nov 2008 10:20:18 +0200
Message-ID: <87prl1bbjx.fsf@trdhcp146196.ntc.nokia.com>
References: <alpine.DEB.2.00.0811051152150.15612@utopia.booyaka.com>
	<20081106033327.GQ21736@atomide.com>
	<alpine.DEB.2.00.0811060401150.11718@utopia.booyaka.com>
	<87ej1na8c2.fsf@trdhcp146196.ntc.nokia.com>
	<alpine.DEB.2.00.0811100741420.23090@utopia.booyaka.com>
	<87r65i66j5.fsf@trdhcp146196.ntc.nokia.com>
	<491A0082.4040807@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:29918 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbYKLIUd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2008 03:20:33 -0500
In-Reply-To: <491A0082.4040807@deeprootsystems.com> (ext Kevin Hilman's
	message of "Tue, 11 Nov 2008 14:00:34 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: ext Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, "Stoppa Igor \\(Nokia-D/Helsinki\\)" <Igor.Stoppa@nokia.com>, r-woodruff2@ti.com, "Sawant, Anand" <sawant@ti.com>, Poussa Sakari <sakari.poussa@nokia.com>

"ext Kevin Hilman" <khilman@deeprootsystems.com> writes:

> H=C3=B6gander Jouni wrote:
>> "ext Paul Walmsley" <paul@pwsan.com> writes:
>>
>>> Hi Jouni,
>>>
>>> On Fri, 7 Nov 2008, H=C3=B6gander Jouni wrote:
>>>
>>>> What do you Paul think about patch below:
>>> I'm okay with it, but one potential problem: won't this prevent the
>>> chip from entering retention, since SGX will be set to ON?
>>
>> Yes, you are right here.
>>
>>> Anyway, if you agree this is a problem, what do you think about
>>> adding a powerdomain flag that indicates that the powerdomain next
>>> power state should be set to OFF on initialization, and then
>>> testing that in set_pwrdm_state() ?
>>
>> I wouldn't add any flags for this. The goal is finally to set all
>> next_states as OFF until someone has set some constraint which
>> prevents OFF usage. For now we need to use RET as default, because
>> drivers are not supporting OFF mode. Do you agree this?
>>
>> Easiest way here would be to add own hook for SGX in pwrdms_setup? O=
ne
>> more strcmp("*_pwrdm, pwrdm->name) :)
>>
>> What do you think?
>>
>
> Personally, I don't like these if statements (or ifdefs) in
> pwrdms_setup or the off_mode_enable hook.  And I would like to see
> them all disappear.

Should we write all the states in off_mode_enable/pwrdms_setup
and then write them again in resource_refresh/CPUidle loop.

>
> I would rather see set_pwrdm_state() be smarter by simply not trying
> to use a state that is not in its list of allowed states.

Should we then just ignore possible error value from set_pwrdm_state?
Or consider unsupported PWRDM_ST as a not an error in set_pwrdm_state? =
Just
ignore it?

>
> Kevin
>
>
>>> - Paul
>>>
>>>
>>>> From: Jouni Hogander <jouni.hogander@nokia.com>
>>>> Date: Fri, 7 Nov 2008 16:50:51 +0200
>>>> Subject: [PATCH] OMAP3: PM: Check that wanted state is supported b=
y pwrdm in pwrdms_setup
>>>>
>>>> Check that wanted sleep state is supported by powerdomain. If it i=
s
>>>> not supported, then use next highest supported state.
>>>>
>>>> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
>>>> ---
>>>>  arch/arm/mach-omap2/pm34xx.c |   11 ++++++++++-
>>>>  1 files changed, 10 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm=
34xx.c
>>>> index da098d2..d9959a8 100644
>>>> --- a/arch/arm/mach-omap2/pm34xx.c
>>>> +++ b/arch/arm/mach-omap2/pm34xx.c
>>>> @@ -515,6 +515,7 @@ static void __init prcm_setup_regs(void)
>>>>  static int __init pwrdms_setup(struct powerdomain *pwrdm)
>>>>  {
>>>>  	struct power_state *pwrst;
>>>> +	u32 next_state =3D PWRDM_POWER_RET;
>>>>   	if (!pwrdm->pwrsts)
>>>>  		return 0;
>>>> @@ -523,12 +524,20 @@ static int __init pwrdms_setup(struct powerd=
omain *pwrdm)
>>>>  	if (!pwrst)
>>>>  		return -ENOMEM;
>>>>  	pwrst->pwrdm =3D pwrdm;
>>>> -	pwrst->next_state =3D PWRDM_POWER_RET;
>>>>  	list_add(&pwrst->node, &pwrst_list);
>>>>   	if (pwrdm_has_hdwr_sar(pwrdm))
>>>>  		pwrdm_enable_hdwr_sar(pwrdm);
>>>>  +	while (!(pwrdm->pwrsts & (1 << next_state))) {
>>>> +		if (next_state > PWRDM_POWER_ON) {
>>>> +			next_state =3D pwrdm_read_next_pwrst(pwrst->pwrdm);
>>>> +			break;
>>>> +		}
>>>> +		next_state++;
>>>> +	}
>>>> +	pwrst->next_state =3D next_state;
>>>> +
>>>>  	return set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
>>>>  }
>>>>  --=20
>>>> 1.6.0.1
>>>>
>>>>
>>>
>>> - Paul
>>
>

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
