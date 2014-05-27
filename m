From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH 4/5] mfd: palmas: Add tps65917 support
Date: Tue, 27 May 2014 14:09:24 +0530
Message-ID: <53844F3C.9040507@ti.com>
References: <1401098197-647-1-git-send-email-j-keerthy@ti.com> <1401098197-647-5-git-send-email-j-keerthy@ti.com> <20140527083804.GB5875@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140527083804.GB5875@lee--X1>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com
List-Id: linux-omap@vger.kernel.org

On Tuesday 27 May 2014 02:08 PM, Lee Jones wrote:
> On Mon, 26 May 2014, Keerthy wrote:
>
>> Add tps65917 PMIC support. tps65917 is a subset of palmas PMIC.
>> Some of the register definitions and the interrupt mappings
>> are different.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>   drivers/mfd/palmas.c |  177 ++++++++++++++++++++++++++++++++++++++++++++++++--
> Much nicer.  You just saved yourself(/the subsystem) 420 lines!
>
> I have a single nit.  Once it's fixed-up you can apply my:
>
>    Acked-by: Lee Jones <lee.jones@linaro.org>

Thanks.

>
>>   1 file changed, 172 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
>> index d280d78..e4684cc 100644
>> --- a/drivers/mfd/palmas.c
>> +++ b/drivers/mfd/palmas.c
> [...]
>
>>   static const struct of_device_id of_palmas_match_tbl[] = {
>>   	{
>>   		.compatible = "ti,palmas",
>> -		.data = &palmas_features,
>> +		.data = &palmas_data,
>>   	},
>>   	{
>>   		.compatible = "ti,tps659038",
>> -		.data = &tps659038_features,
>> +		.data = &tps659038_data,
>>   	},
>> +	{
>> +		.compatible = "ti,tps65917",
>> +		.data = &tps65917_data,
>> +	},
>> +
> Please get rid of this line.

Oops. I will knock off this line and submit.


>>   	{ },
>>   };
>>   MODULE_DEVICE_TABLE(of, of_palmas_match_tbl);
