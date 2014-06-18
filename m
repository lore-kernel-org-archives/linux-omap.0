From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH 8/9] regulator: palmas: add driver data and modularize
 the probe
Date: Wed, 18 Jun 2014 10:23:25 +0530
Message-ID: <53A11B45.4010403@ti.com>
References: <1401272423-25761-1-git-send-email-j-keerthy@ti.com> <1401272423-25761-9-git-send-email-j-keerthy@ti.com> <20140617164502.GS29841@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140617164502.GS29841@lee--X1>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com
List-Id: linux-omap@vger.kernel.org

On Tuesday 17 June 2014 10:15 PM, Lee Jones wrote:
>> add driver data and modularize the probe.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>   drivers/mfd/palmas.c                 |   42 +--
>>   drivers/regulator/palmas-regulator.c |  656 ++++++++++++++++++++--------------
>>   2 files changed, 395 insertions(+), 303 deletions(-)
>>
>> diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
> [...]
>
>> @@ -370,6 +334,8 @@ int palmas_ext_control_req_config(struct palmas *palmas,
>>   	int bit_pos;
>>   	int ret;
>>   
>> +	struct palmas_pmic_driver_data *pmic_ddata = palmas->pmic_ddata;
>> +
> Nit: I'd prefer the declarations to be grouped together, normally with
> the struct defines above the ints etc.

Ok. I will change this.

>
> [...]
>
