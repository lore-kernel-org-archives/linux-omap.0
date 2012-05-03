From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 18/18][V3] ARM: OMAP3: cpuidle - set global variables
 static
Date: Fri, 04 May 2012 01:02:20 +0200
Message-ID: <4FA30E7C.8090900@linaro.org>
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org> <1335276339-11135-19-git-send-email-daniel.lezcano@linaro.org> <878vh9ko3j.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:53659 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756775Ab2ECXCW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 19:02:22 -0400
Received: by were53 with SMTP id e53so1423807wer.19
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 16:02:21 -0700 (PDT)
In-Reply-To: <878vh9ko3j.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, tony@atomide.com, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On 05/03/2012 10:26 PM, Kevin Hilman wrote:
> Daniel Lezcano<daniel.lezcano@linaro.org>  writes:
>
>> and check the powerdomain lookup is successful.
>>
>> Signed-off-by: Daniel Lezcano<daniel.lezcano@linaro.org>
>> Reviewed-by: Jean Pihet<j-pihet@ti.com>
>> ---
>>   arch/arm/mach-omap2/cpuidle34xx.c |    5 ++++-
>>   1 files changed, 4 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2=
/cpuidle34xx.c
>> index 0d28596..116a0d8 100644
>> --- a/arch/arm/mach-omap2/cpuidle34xx.c
>> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
>> @@ -73,7 +73,7 @@ static struct omap3_idle_statedata omap3_idle_data=
[] =3D {
>>   	},
>>   };
>>
>> -struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
>> +static struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
>>
>>   static int _cpuidle_allow_idle(struct powerdomain *pwrdm,
>>   				struct clockdomain *clkdm)
>> @@ -252,6 +252,9 @@ static int omap3_enter_idle_bm(struct cpuidle_de=
vice *dev,
>>   	 *        its own code.
>>   	 */
>>
>> +	if (!mpu_pd || !core_pd || !per_pd || !cam_pd)
>> +		return -ENODEV;
>> +
>
> Why check here?  cam_pd is actually used just above this code.
>
> Also, this is in the fast path.  This should just be checked once at
> init time instead of every idle path.
>
> For those reasons, I've dropped this part of the patch (updated patch
> below.)

Hmm, weird this part should have been in the init function, I likely=20
missed a big fuzz I think when porting the patchset to the latest kerne=
l=20
version. Thanks for fixing it.

> If desired, you can send an additional patch that adds this error
> checking at init time and then refuses to register the driver if any =
of
> the pwrdms don't exist.

Yes, I will do it.

   -- Daniel

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
