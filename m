From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 7/8 v2] ARM OMAP2+ GPMC: calculate GPMCFCLKDIVIDER based
 on WAITMONITORINGTIME
Date: Thu, 26 Feb 2015 13:34:36 +0200
Message-ID: <54EF04CC.2060804@ti.com>
References: <1424808331-17592-1-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-2-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-3-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-4-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-5-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-6-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-7-git-send-email-rabel@cit-ec.uni-bielefeld.de> <54EDF969.1070902@ti.com> <54EE0468.6000105@cit-ec.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54EE0468.6000105@cit-ec.uni-bielefeld.de>
Sender: linux-kernel-owner@vger.kernel.org
To: rabel@cit-ec.uni-bielefeld.de, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

Robert,

On 25/02/15 19:20, Robert Abel wrote:
> Hi Roger,
> 
> On 25 Feb 2015 17:33, Roger Quadros wrote:
>> ./scripts/checkpatch.pl detects some styling errors.
> Well, there's like a million lines over 80 characters. I'm also a heathen and don't use an 80 character terminal either.
> I'll fix the more serious issues checkpatch finds, but some styling errors are even from code already in the driver.

neither do I but let's fix whatever is possible to fix
in the new code.

> 
>>>   #define GPMC_CONFIG1_WAIT_MON_IIME(val) ((val & 3) << 18)
>> Not caused by your patch but we can fix the typo
>>
>> GPMC_CONFIG1_WAIT_MON_IIME -> GPMC_CONFIG1_WAIT_MON_TIME
> I'd rather remove than fix. None of these defines is in active use anymore.

OK with me.

>>> +/**
>>> + * gpmc_calc_waitmonitoring_divider - calculate proper GPMCFCLKDIVIDER based on WAITMONITORINGTIME
>>> + * @wait_monitoring WAITMONITORINGTIME in ns.
>>> + * @return          -1 on failure to scale, else proper divider > 0.
>>> + * @note            WAITMONITORINGTIME will be _at least_ as long as desired.
>>> + *                  i.e. read timings should be kept            -> don't sample bus too early
>>> + *                  while write timings should work out as well -> data is longer on bus
>>> + */
>>> +static int gpmc_calc_waitmonitoring_divider(unsigned int wait_monitoring)
>>> +{
>>> +
>>> +    int div = gpmc_ns_to_ticks(wait_monitoring);
>>> +
>>> +    div += GPMC_CONFIG1_WAIT_MON_TIME_MAX - 1;
>>> +    div /= GPMC_CONFIG1_WAIT_MON_TIME_MAX;
>> Sorry I didn't understand how this works. :P
>>  From the TRM,
>>
>> waitmonitoringtime_ns = waitmonitoring_ticks x (gpmc_clk_div + 1) x gpmc_fclk_ns
> Using that formula:
> gpmc_clk_div + 1 = ceil(ceil(waitmonitoringtime_ns / gpmc_fclk_ns) / waitmonitoring_ticks).

Right, we need to return div = gpmc_div + 1 to take care of the (div - 1) done by the caller before
programming div.
I wouldn't mind if we update gpmc_calc_divider() and this function to return the actual div value
that needs to be programmed in the register. It is upto you.

How about mentioning the above formula in a comment for benefit of future readers?
you could also mention that reducing the formula to ticks we get.

gpmc_div + 1 = ceil(wanted_waitmonitoring_ticks/waitmonitoring_ticks)

> 
> The reason I use GPMC_CONFIG1_WAIT_MON_TIME_MAX directly, is because every other pair is identical:
> 
> We have the following cases:
> a) WAITMONITORINGTIME = 0, so div doesn't matter (we set div to 1) or
> b) WAITMONITORINGTIME = 1, with div = 1 or
> c) WAITMONITORINGTIME = 2, with div = n
> 
> WAITMONITORINGTIME is never 1 with div = n and div /= 1, because that's the same as WAITMONITORINGTIME = 2 with div = n - 1.
> Cases a) and b) are caught using the fact that div = 0 after the division.
> Case c) is handled by assuming that WAITMONITORINGTIME will always be 2 (i.e. GPMC_CONFIG1_WAIT_MON_TIME_MAX) for all divs /= 0 at that point.
> 
> Took me a while to realize that this works, too.
> 
>>> +    /*
>>> +     * See if we need to change the divider for waitmonitoringtime.
>>> +     *
>>> +     * If DT contains sync-clk-ps for truly asynchronous accesses,
>>> +     * ignore it as long as waitmonitoringtime is used.
>>> +     *
>> The comment in the $subject was more easier to understand for me than the above
>>
>> "Calculate GPMCFCLKDIVIDER independent of gpmc,sync-clk-ps in DT for
>> truly asynchronous accesses, i.e. both read and write asynchronous."
> Well, the comment in $subject was a general description. Here, we don't touch div when
> a) any access is synchronous
> b) all accesses are asynchronous, but WAITMONITORINGTIME is not used, i.e. WAITREADMONITORING and WAITWRITEMONITORING are both not set.
> 
> So, if WAITMONITORINGTIME is not used, or any access is synchronous, we program the sync-clk-ps anyways, because the GPMC won't rely on it for any timing.
> So the comment is OK, IMHO.

OK with me.

cheers,
-roger
