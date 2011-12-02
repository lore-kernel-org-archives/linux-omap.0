From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC][PATCH 1/1] OMAP: voltage: add a hook for normal regulator calls
Date: Fri, 02 Dec 2011 14:27:57 -0800
Message-ID: <87iplymwwi.fsf@ti.com>
References: <1321547303-21807-1-git-send-email-vaibhav.bedia@ti.com>
	<B5906170F1614E41A8A28DE3B8D12143032D30@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:60267 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755248Ab1LBW2A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Dec 2011 17:28:00 -0500
Received: by mail-iy0-f175.google.com with SMTP id k25so5158714iah.20
        for <linux-omap@vger.kernel.org>; Fri, 02 Dec 2011 14:28:00 -0800 (PST)
In-Reply-To: <B5906170F1614E41A8A28DE3B8D12143032D30@DBDE01.ent.ti.com>
	(Vaibhav Bedia's message of "Fri, 25 Nov 2011 06:29:37 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kattekola, Ravikumar" <rk@ti.com>

"Bedia, Vaibhav" <vaibhav.bedia@ti.com> writes:

> Hi,
>
> On Thu, Nov 17, 2011 at 21:58:23, Bedia, Vaibhav wrote:
>> TI processors in TI81x and AM33x family work with PMICs like
>> TPS65910/1 which are not part of the TWL series. These processors
>> also do not have a voltage controller/processor module.
>> 
>> In order to invoke the normal regulator calls from the voltage
>> layer the following changes are done to struct voltagedomain
>> 	- Add a flag use_regulator for the SoC voltagedomain
>> 	  code to indicate its intention of using a PMIC which
>> 	  is not controlled by VC/VP
>> 	- Add a regulator_init callback which the platform code
>> 	  can utilise for any custom init sequence before making
>> 	  use of the regulator. Platform code is also expected
>> 	  to set the voltdm->scale function in the init callback
>> 
>> Signed-off-by: Ravikumar Kattekola <rk@ti.com>
>> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
>> ---
>>  arch/arm/mach-omap2/voltage.c |    5 +++++
>>  arch/arm/mach-omap2/voltage.h |    4 ++++
>>  2 files changed, 9 insertions(+), 0 deletions(-)
>> 
>> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
>> index 1f8fdf7..ca4ef9e 100644
>> --- a/arch/arm/mach-omap2/voltage.c
>> +++ b/arch/arm/mach-omap2/voltage.c
>> @@ -280,6 +280,11 @@ int __init omap_voltage_late_init(void)
>>  			voltdm->scale = omap_vp_forceupdate_scale;
>>  			omap_vp_init(voltdm);
>>  		}
>> +
>> +		if (voltdm->use_regulator) {
>> +			if(voltdm->regulator_init)
>> +				voltdm->regulator_init(voltdm);
>> +		}
>>  	}
>>  
>>  	return 0;
>> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
>> index 16a1b09..21c810f 100644
>> --- a/arch/arm/mach-omap2/voltage.h
>> +++ b/arch/arm/mach-omap2/voltage.h
>> @@ -88,6 +88,10 @@ struct voltagedomain {
>>  
>>  	u32 nominal_volt;
>>  	struct omap_volt_data *volt_data;
>> +
>> +	bool use_regulator;
>> +	struct regulator *regulator;
>> +	int (*regulator_init) (struct voltagedomain *voltdm);
>>  };
>>  
>
> Any comments on this approach? 

Sorry, I didn't see this patch before, and I don't see it in the
linux-omap archives either.  Not sure what happened there...

> This enables us to make use of generic regulators calls from the
> voltage layer. 

>From this patch, I don't see how the regulator API is being used from
the voltage layer, so I don't fully understand what you're trying to
achieve.

IOW, why should the voltagedomain code be calling the regulator API?

The voltage domain code was designed with the opposite goal: namely,
that a regulator driver would be calling the voltage domain layer, not
vice versa.

> Since TI81xx and AM33xx do not have VC/VP we need something like this
> for implementing DVFS.

This patch (and changelog) does not make that very clear, since it only
adds an init-time hook.

Kevin
