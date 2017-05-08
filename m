From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v3 1/2] thermal: core: Allow orderly_poweroff to be called
 only once
Date: Mon, 8 May 2017 09:50:05 +0530
Message-ID: <dbe1dfc1-9774-ca92-cded-42b691e36db7@ti.com>
References: <1492147105-26692-1-git-send-email-j-keerthy@ti.com>
 <20170507210219.GB25628@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170507210219.GB25628@atrey.karlin.mff.cuni.cz>
Sender: linux-pm-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org



On Monday 08 May 2017 02:32 AM, Pavel Machek wrote:
>> thermal_zone_device_check --> thermal_zone_device_update -->
>> handle_thermal_trip --> handle_critical_trips --> orderly_poweroff
>>
>> The above sequence happens every 250/500 mS based on the configuration.
>> The orderly_poweroff function is getting called every 250/500 mS.
>> With a full fledged file system it takes at least 5-10 Seconds to
>> power off gracefully.
>>
>> In that period due to the thermal_zone_device_check triggering
>> periodically the thermal work queues bombard with
>> orderly_poweroff calls multiple times eventually leading to
>> failures in gracefully powering off the system.
>>
>> Make sure that orderly_poweroff is called only once.
> 
> Pretty please, can we do it in the core code, not in thermal/? There
> are other reasons kernel may want to shut the system down, like for
> example critical battery, and if both thermal _and_ bad battery
> happen, we want just one shutdown...

Pavel,

Thermal fix is still valid. As it is having multiple calls.
I can work on fixing the core code as well.

BTW the latest of this series is v6:

https://patchwork.kernel.org/patch/9684929/


- Keerthy

> 
>> Reported-by: Keerthy <j-keerthy@ti.com>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
> 
> And here probably we need your full name.
> 
> Thanks,
> 								Pavel
> 
