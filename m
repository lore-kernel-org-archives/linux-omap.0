From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH 3/3] regulator: twl: Regulator mode should not depend on
 regulator enabled state
Date: Sun, 24 Apr 2016 20:01:34 +0300
Message-ID: <571CFBEE.6050608@gmail.com>
References: <1458980895-10240-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1458980895-10240-4-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160424161155.GD8880@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160424161155.GD8880@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: tony@atomide.com, lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org, pali.rohar@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 24.04.2016 19:11, Pavel Machek wrote:
> On Sat 2016-03-26 10:28:15, Ivaylo Dimitrov wrote:
>> When machine constraints are applied, regulator framework first sets
>> initial mode (if any) and then enables the regulator if needed. The current
>> code in twl4030reg_set_mode always checks if the regulator is enabled
>> before applying the mode. That results in -EACCES error returned for
>> "always-on" regulators which have "initial-mode" set in the board DTS. Fix
>> that by removing the unneeded check.
>
> Should we keep the check for the regulators that are _not_ always-on?
>

I don't think so, as there is no other way to set mode to a regulator 
but through regulator framework and board DTS (for twl4030 that is) - 
and this is done only once during boot, see 
https://lkml.org/lkml/2016/4/17/78 as well. So, no matter if the 
regulator is always-on or not, that check is redundant IMO.

Ivo



>
>> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
>> ---
>>   drivers/regulator/twl-regulator.c | 8 --------
>>   1 file changed, 8 deletions(-)
>>
>> diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
>> index be8d05e..d8f6ad6 100644
>> --- a/drivers/regulator/twl-regulator.c
>> +++ b/drivers/regulator/twl-regulator.c
>> @@ -371,7 +371,6 @@ static int twl4030reg_set_mode(struct regulator_dev *rdev, unsigned mode)
>>   {
>>   	struct twlreg_info	*info = rdev_get_drvdata(rdev);
>>   	unsigned		message;
>> -	int			status;
>>
>>   	/* We can only set the mode through state machine commands... */
>>   	switch (mode) {
>> @@ -385,13 +384,6 @@ static int twl4030reg_set_mode(struct regulator_dev *rdev, unsigned mode)
>>   		return -EINVAL;
>>   	}
>>
>> -	/* Ensure the resource is associated with some group */
>> -	status = twlreg_grp(rdev);
>> -	if (status < 0)
>> -		return status;
>> -	if (!(status & (P3_GRP_4030 | P2_GRP_4030 | P1_GRP_4030)))
>> -		return -EACCES;
>> -
>>   	return twl4030_send_pb_msg(message);
>>   }
>>
>
