From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC][PATCH 0/7] OMAP4 cpuidle cleanup
Date: Wed, 21 Mar 2012 11:49:01 +0100
Message-ID: <4F69B21D.4050302@linaro.org>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org> <4F69A872.50203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39187 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758406Ab2CUKtF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 06:49:05 -0400
Received: by bkcik5 with SMTP id ik5so770338bkc.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 03:49:04 -0700 (PDT)
In-Reply-To: <4F69A872.50203@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linaro Dev <linaro-dev@lists.linaro.org>, Jean Pihet <jean.pihet@newoldbits.com>

On 03/21/2012 11:07 AM, Santosh Shilimkar wrote:
> Daniel,
>
> On Wednesday 21 March 2012 02:57 PM, Daniel Lezcano wrote:
>> This patchset is a proposition to improve a bit the code.
>> The changes are code cleanup and does not change the behavior of the
>> driver itself.
>>
>> A couple a things call my intention. Why the cpuidle device is set f=
or cpu0 only
>> and why the WFI is not used ?
>>
>> Daniel Lezcano (7):
>>    ARM: OMAP4: cpuidle - Remove unused valid field
>>    ARM: OMAP4: cpuidle - Declare the states with the driver declarat=
ion
>>    ARM: OMAP4: cpuidle - Remove the cpuidle_params_table table
>>    ARM: OMAP4: cpuidle - fix static omap4_idle_data declaration
>>    ARM: OMAP4: cpuidle - Initialize omap4_idle_data at compile time
>>    ARM: OMAP4: cpuidle - use the omap4_idle_data variable directly
>>    ARM: OMAP4: cpuidle - remove omap4_idle_data initialization at bo=
ot
>>      time
>>
> The series looks fine to me in general. This clean-up is applicable
> for OMAP3 cpuidle code as well.

Yes, I am planning to do the same for omap3.

Thanks for reviewing.

   -- Daniel

> I want Jean to look at this series because some of his earlier
> clean up has introduced those custom functions which
> are getting removed in this series.
>
> Regards
> santosh
>
>


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
