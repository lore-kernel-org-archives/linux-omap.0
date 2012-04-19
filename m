From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 10/17][V2] ARM: OMAP3: cpuidle - remove the 'valid' field
Date: Thu, 19 Apr 2012 16:02:02 +0200
Message-ID: <4F901ADA.1020302@linaro.org>
References: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org> <1333570371-1389-11-git-send-email-daniel.lezcano@linaro.org> <874nss8pn9.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:40327 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825Ab2DSOCH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Apr 2012 10:02:07 -0400
Received: by bkcik5 with SMTP id ik5so6391756bkc.19
        for <linux-omap@vger.kernel.org>; Thu, 19 Apr 2012 07:02:05 -0700 (PDT)
In-Reply-To: <874nss8pn9.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rob.lee@linaro.org, linaro-dev@lists.linaro.org, patches@linaro.org

On 04/10/2012 01:13 AM, Kevin Hilman wrote:
> Daniel Lezcano<daniel.lezcano@linaro.org>  writes:
>
>> With the previous changes all the states are valid, except
>> the last state which can be handled by decreasing the number
>> of states.
>>
>> Signed-off-by: Daniel Lezcano<daniel.lezcano@linaro.org>
>> Reviewed-by: Jean Pihet<j-pihet@ti.com>
>> ---

[ ... ]

>>   	if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583)) {
>> -		cx->valid =3D 0;
>> +		drv->state_count =3D OMAP3_NUM_STATES - 1;
>>   		pr_warn("%s: core off state C7 disabled due to i583\n",
>>   			__func__);
>
> I'm not too particular about this one, but it might be cleaner to jus=
t
> remove this check all together.  This errata already has a check in
> next_valid_state() so strictly speaking, it's not needed here.

Yes, right. Thanks for pointing this.


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
