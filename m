From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 9/8 v2] ARM OMAP2+ GPMC: fix programming/showing reserved
 timing parameters
Date: Wed, 25 Feb 2015 18:09:26 +0200
Message-ID: <54EDF3B6.1030805@ti.com>
References: <1424808331-17592-1-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-2-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-3-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-4-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-5-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-6-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-7-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-8-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-9-git-send-email-rabel@cit-ec.uni-bielefeld.de> <54EDA77F.4030008@ti.com> <54EDE77D.6020604@cit-ec.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54EDE77D.6020604@cit-ec.uni-bielefeld.de>
Sender: linux-kernel-owner@vger.kernel.org
To: rabel@cit-ec.uni-bielefeld.de, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

Robert,

On 25/02/15 17:17, Robert Abel wrote:
> Hi Roger,
> 
> On 25 Feb 2015 11:44, Roger Quadros wrote:
>> typo ATTCHEDDEVICEPAGELENGTH->ATTACHEDDEVICEPAGELENGTH 
> Yep.
>>> +/** DEVICESIZE Max Value */
>>> +#define GPMC_CONFIG1_DEVICESIZE_MAX     GPMC_CONFIG1_DEVICESIZE_16
>> Shouldn't this be 1 instead? I'm hoping max value is without the shift
>> based on GPMC_CONFIG1_CLKACTIVATIONTIME_MAX.
> Yes, it should. It's a remnant from the change below...
>>> + * @max     Maximum parameter value (after optional @shift).
>> max should be absolute value, without the shift.
> Yes, forgot to change that.
>>> +#define GPMC_GET_RAW_SHIFT(reg, st, end, shift, max, field) \
>>> +    get_gpmc_timing_reg(cs, (reg), (st), (end), (max), field, GPMC_CD_FCLK, (shift), 1, 1)
>> Is it better to rename this to GPMC_GET_RAW_SHIFT_MAX() as it takes the max parameter.
> Ok.
>>> +    GPMC_GET_RAW_SHIFT(GPMC_CS_CONFIG1, 23, 24, 4, 2, "burst-length");
>> want to define GPMC_CONFIG1_BURSTLENGTH_MAX?
> Yes, for consistency. Originally, i was not going to create defines for limits used only in one place, as opposed to WAITMONITORINGTIME and CLKACTIVATIONTIME.
>>> -    GPMC_GET_TICKS_CD(GPMC_CS_CONFIG1, 18, 19, "wait-monitoring-ns", GPMC_CD_CLK);
>>> -    GPMC_GET_TICKS(GPMC_CS_CONFIG1, 25, 26, "clk-activation-ns");
>>> +    GPMC_GET_TICKS_CD_MAX(GPMC_CS_CONFIG1, 18, 19, GPMC_CONFIG1_WAIT_MON_TIME_MAX, "wait-monitoring-ns", GPMC_CD_CLK);
>> use GPMC_CONFIG1_WAITMONTIME_MAX to have consistent naming.
> I used the naming the other define had. Saw no point in changing them. They go mostly unused anyway.
> Might as well change it.

Not much of an issue. I leave it upto you.

cheers,
-roger
> 
>>> +#define GPMC_SET_ONE_CD(reg, st, end, field, cd) \
>>> +    GPMC_SET_ONE_CD_MAX(reg, st, end, 0, field, GPMC_CD_FCLK)
>> last parameter should be (cd) instead of GPMC_CD_FCLK.
> Ah, copy-paste, there you are again. Luckily this define goes unused, because all GPMC_SET_ONE_CD became GPMC_SET_ONE_CD_MAX anyway.
> So I'll delete that. Quite a keen eye, though ;)
> 
> Regards,
> 
> Robert
