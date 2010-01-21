From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/2] DSPBRIDGE: pm: use old implementation for opps
Date: Thu, 21 Jan 2010 01:47:03 -0600
Message-ID: <4B580677.10503@ti.com>
References: <1264025953-4620-1-git-send-email-nm@ti.com> <1264025953-4620-2-git-send-email-nm@ti.com> <1264025953-4620-3-git-send-email-nm@ti.com> <4B58046B.9040804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46138 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752958Ab0AUHrI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jan 2010 02:47:08 -0500
In-Reply-To: <4B58046B.9040804@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>

Dasgupta, Romit had written, on 01/21/2010 01:38 AM, the following:
>>  arch/arm/mach-omap2/dspbridge.c |   59 ++++++++++++++++++++++++++++++++++++++-
>>  1 files changed, 58 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/dspbridge.c b/arch/arm/mach-omap2/dspbridge.c
>> index 26b860f..120d8a2 100644
>> --- a/arch/arm/mach-omap2/dspbridge.c
>> +++ b/arch/arm/mach-omap2/dspbridge.c
>> @@ -42,7 +42,64 @@ static struct dspbridge_platform_data dspbridge_pdata __initdata = {
>>  static int get_opp_table(struct dspbridge_platform_data *pdata)
>>  {
>>  #ifdef CONFIG_BRIDGE_DVFS
>> -	/* Do nothing now  - fill based on PM implementation */
>> +	/* legacy values for 3430 */
>> +	u32 vdd1_dsp_freq[6][4] = {
>> +		{0, 0, 0, 0},
>> +		/*OPP1*/
>> +		{0, 90000, 0, 86000},
>> +		/*OPP2*/
>> +		{0, 180000, 80000, 170000},
>> +		/*OPP3*/
>> +		{0, 360000, 160000, 340000},
>> +		/*OPP4*/
>> +		{0, 396000, 325000, 376000},
>> +		/*OPP5*/
>> +		{0, 430000, 355000, 430000},
>> +	};
>> +	struct omap_opp vdd1_rate_table_bridge[] = {
>> +		{0, 0, 0},
>> +		/*OPP1*/
>> +		{S125M, VDD1_OPP1, 0},
>> +		/*OPP2*/
>> +		{S250M, VDD1_OPP2, 0},
>> +		/*OPP3*/
>> +		{S500M, VDD1_OPP3, 0},
>> +		/*OPP4*/
>> +		{S550M, VDD1_OPP4, 0},
>> +		/*OPP5*/
>> +		{S600M, VDD1_OPP5, 0},
>> +	};
>> +	pdata->dsp_num_speeds = VDD1_OPP5;
> Why dont you use ARRAY_SIZE - 1 ?
This is a 1-1 transposition of old code here. further improvement 
patches is a good thing to have (though I find the usage of ARRAY_SIZE 
still wont make it cpu independent).

>> +	pdata->mpu_speeds = kzalloc(sizeof(u32) * pdata->dsp_num_speeds,
>> +			GFP_KERNEL);
> I understand pdata->dsp_num_speeds == pdata->mpu_num_speeds. But don't you think
> passing pdata->mpu_num_speeds makes more sense here?
thanks for catching this -> yeah, it is right to use mpu_num_speeds 
(even though the nums are the same)

>> +	if (!pdata->mpu_speeds) {
>> +		pr_err("unable to allocate memory for the mpu"
>> +		"frequencies\n");
>> +		return -ENOMEM;
>> +	}
> As I mentioned in my earlier email. You return to the caller here but you free
> pdata->dsp_freq_table in the caller even if pdata->dsp_freq_table is not allocated.
yes, that is coz kfree is NULL safe. you can verify that by writing a 
simple code and testing on checkpatch:
if (ptr)
	kfree(ptr);

> 
>> +	pdata->dsp_freq_table = kzalloc(
>> +			sizeof(struct dsp_shm_freq_table) *
>> +			(pdata->dsp_num_speeds + 1), GFP_KERNEL);
>> +	if (!pdata->dsp_freq_table) {
>> +		pr_err("unable to allocate memory for the dsp"
>> +		"frequencies\n");
>> +		return -ENOMEM;
>> +	}
>> +	for (i = 0; i < 6; i++)
> Why are you hard coding numeric 6 here?
carry over of old code - intention is *not* to optimize this.

> 
>> +		pdata->mpu_speed[i] = vdd1_rate_table_bridge[i].rate;
>> +	pdata->mpu_max_speed = pdata->mpu_speed[VDD1_OPP5];
> You can use ARRAY_SIZE.
>> +	pdata->mpu_min_speed = pdata->mpu_speed[VDD1_OPP1];
>> +	pdata->dsp_num_speeds = VDD1_OPP5;
> Same..ARRAY_SIZE...
intention was to retain the old logic here.
>> +	for (i = 0; i <= pdata->dsp_num_speeds; i++) {
>> +		pdata->dsp_freq_table[i].u_volts =
>> +				vdd1_dsp_freq[i][0];
>> +		frequency = pdata->dsp_freq_table[i].dsp_freq =
>> +			frequency = vdd1_dsp_freq[i][1];
>> +		pdata->dsp_freq_table[i].thresh_min_freq =
>> +			vdd1_dsp_freq[i][2];
>> +		pdata->dsp_freq_table[i].thresh_max_freq =
>> +			vdd1_dsp_freq[i][3];
>> +	}
>>  #endif
>>  	return 0;
>>  }


-- 
Regards,
Nishanth Menon
