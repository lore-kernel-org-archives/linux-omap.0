From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH 6/9] mfd: palmas: shift the palmas_sleep_requestor_info
 structure definition to the header file
Date: Wed, 18 Jun 2014 10:34:55 +0530
Message-ID: <53A11DF7.3060903@ti.com>
References: <1401272423-25761-1-git-send-email-j-keerthy@ti.com> <1401272423-25761-7-git-send-email-j-keerthy@ti.com> <20140617163339.GQ29841@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140617163339.GQ29841@lee--X1>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com
List-Id: linux-omap@vger.kernel.org

On Tuesday 17 June 2014 10:03 PM, Lee Jones wrote:
> On Wed, 28 May 2014, Keerthy wrote:
>
>> shift the palmas_sleep_requestor_info structure definition to the header file.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>   drivers/mfd/palmas.c       |   10 ----------
>>   include/linux/mfd/palmas.h |   10 ++++++++++
>>   2 files changed, 10 insertions(+), 10 deletions(-)
> Acked-by: Lee Jones <lee.jones@linaro.org>

Thanks.

>
>> diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
>> index 485d755..f1f31d5 100644
>> --- a/drivers/mfd/palmas.c
>> +++ b/drivers/mfd/palmas.c
>> @@ -25,16 +25,6 @@
>>   #include <linux/mfd/palmas.h>
>>   #include <linux/of_device.h>
>>   
>> -#define PALMAS_EXT_REQ (PALMAS_EXT_CONTROL_ENABLE1 |	\
>> -			PALMAS_EXT_CONTROL_ENABLE2 |	\
>> -			PALMAS_EXT_CONTROL_NSLEEP)
>> -
>> -struct palmas_sleep_requestor_info {
>> -	int id;
>> -	int reg_offset;
>> -	int bit_pos;
>> -};
>> -
>>   #define EXTERNAL_REQUESTOR(_id, _offset, _pos)		\
>>   	[PALMAS_EXTERNAL_REQSTR_ID_##_id] = {		\
>>   		.id = PALMAS_EXTERNAL_REQSTR_ID_##_id,	\
>> diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
>> index 150a6314..8d68452 100644
>> --- a/include/linux/mfd/palmas.h
>> +++ b/include/linux/mfd/palmas.h
>> @@ -88,6 +88,16 @@ struct palmas {
>>   	u8 pwm_muxed;
>>   };
>>   
>> +#define PALMAS_EXT_REQ (PALMAS_EXT_CONTROL_ENABLE1 |	\
>> +			PALMAS_EXT_CONTROL_ENABLE2 |	\
>> +			PALMAS_EXT_CONTROL_NSLEEP)
>> +
>> +struct palmas_sleep_requestor_info {
>> +	int id;
>> +	int reg_offset;
>> +	int bit_pos;
>> +};
>> +
>>   struct regs_info {
>>   	char	*name;
>>   	char	*sname;
