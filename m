From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 2/4] ARM OMAP2+ GPMC: always program GPMCFCLKDIVIDER
Date: Tue, 24 Feb 2015 13:53:25 +0200
Message-ID: <54EC6635.2010407@ti.com>
References: <1424101741-24152-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>	<1424101741-24152-2-git-send-email-rabel@cit-ec.uni-bielefeld.de>	<1424101741-24152-3-git-send-email-rabel@cit-ec.uni-bielefeld.de>	<54E2F803.3070901@ti.com>	<CAMdRc4F9B0ft-ExgQ1vHqwXMiONwWKn3FPCRDyHsjgGe1Dn_1w@mail.gmail.com>	<54E34786.1010102@ti.com>	<CAMdRc4F1Ja2Y96W_VESuS=tueYE8Q+iWmoiJW2dj+6-HeDzNqQ@mail.gmail.com>	<54E34F73.2080108@ti.com> <CAMdRc4Gj5MM9TdjiQtCqHcy4b3wAKB2Sx4MfncUNnsrntWRz1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMdRc4Gj5MM9TdjiQtCqHcy4b3wAKB2Sx4MfncUNnsrntWRz1Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Abel <rabel@cit-ec.uni-bielefeld.de>
Cc: khilman@deeprootsystems.com, Tony Lindgren <tony@atomide.com>, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, Linux Kernel Maling List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 23/02/15 23:38, Robert Abel wrote:
> On Tue, Feb 17, 2015 at 3:25 PM, Roger Quadros <rogerq@ti.com> wrote:
>> one more thing to note is that just specifying sync-clk-ps in DT is not enough for
>> asynchronous devices.
>>
>> The driver doesn't set gpmc_t->sync_clk if "gpmc,sync-read" or "gpmc,sync-write"
>> was not set in the DT, which would be the case for asynchronous devices.
> 
> You're mistaken. It's always parsed, no matter what. See [1]. But I

You are right.

> did implement your suggestion of computing the divider in the mean
> time. I'm going to send the patches rebased to 3.19 tomorrow, after I
> tested them.
> 
>> What is your proposal to make things better? And what is your use case that doesn't
>> work with existing setup?
> 
> Well, the current setup was obviously inspired by an asynchronous-only
> use-case, where all the timings are in seconds and get converted
> on-the-fly. Of course, currently, there is no support to re-compute
> them once the gpmc_fclk changes frequency, but I guess that's what the
> TODO about the clock framework is about?

Yes.
> 
> Anyway, my synchronous use-case is inherently... synchronous.
> Synchronous protocols shouldn't be specified in ns at all. They should
> directly be specified in clock ticks. This is also advantageous, as
> changes in gpmc_fclk don't need to propagate to the registers.
> 
I haven't looked much at synchronous memories except oneNAND which has both
asynchronous and synchronous modes. In the datasheet, synchronous timings are
specified in seconds and change depending on device speed grade.
So seems to be the case with the Spansion NOR flash you mentioned.

IMO the DT entries should directly match the unit specified
in the memory device datasheet. Translations are best left to sw.

> My main grief with the current setup is its dependency on the
> *unknown* gpmc_fclk period at startup when the DT is processed and
> GPMC code is called. For instance, my private DT currently operates on
> the assumption of 166 Mhz L3 clk (and therefore gpmc_fclk), so all my
> timings are in multiples of 6 ns. Should now a colleague of mine think
> it would be a splendid idea to change this frequency by means of
> bootloader options [to save power, to process data even faster, etc],
> everything would break, because the L3 might have to be clocked at 100
> MHz (due to divider limits along the clock tree for example) thus
> making my gpmc_fclk period 10ns. Now all my synchronous timings are
> wrong, because all DT values round to different clock ticks.

gpmc_fclk is L3 bus clock and is not configurable by the driver
but preset at boot time or might be scaled by cpufreq driver.
GPMC_CLK is configurable to some extent by the divisor.

If some parameters of newer devices are specified in CLK ticks instead of seconds
then I agree that we need to add new DT bindings to specify them.
Can you specify which parameters are specified in CLKs in the device you are using.

> 
> One solution would obviously be very verbose: Split synchronous and
> asynchronous timings completely. Have a time-ns and a time-tck (where
> time is waitmonitoring, or readaccess etc) setting for different use
> cases. This would work for truly asynchronous (read _and_ write
> asynchronous) as well as truly synchronous (read _and_ write
> synchronous) setups.
> 
> This 'simple' model breaks for parts where one form of access is
> synchronous while the other is asynchronous, e.g. Spansion WS/NS/VS
> parts, see [2] pg. 10. There's no easy solution for mixed timings,
> because some timing parameters are shared between synchronous and
> asynchronous accesses (WAITMONITORINGTIME, CSONTIME, ADVONTIME,
> WRDATAONADMUXBUS etc.). One obvious solution is to try to slow the
> synchronous side down until asynchronous timings can be met, but that
> would make for very slow accesses in most cases.

There was a hackish way this was made to work with OneNAND devices.
It still needs a major cleanup.

The oneNAND driver starts up with asynchronous timings and then calculates
the synchronous timings on the fly based on device speed grade.
http://lxr.free-electrons.com/source/arch/arm/mach-omap2/gpmc-onenand.c#L345

> 
> For instance, I originally started out thinking the GPMC would run at
> 100 MHz externally -- because it's the max frequency rating -- only to
> be surprised when the clock looked weird on the GPMC_CLK pin, because
> it was at 166 MHz. I'm not sure how to completely remedy this, but
> specifying timings in ns in DT and then depending on the correct board
> frequency is kind of shady... :(

Right. I get the picture now. Let's address the issues one by one.

- for deterministic gpmc_fclk, gpmc,sync-clk-ps allows you to specify the
external GPMC_CLK period. 
GPMC driver doesn't have control of gpmc_fclk frequency but it
should try to set GPMC_CLK as close as possible to the specified DT
gpmc,sync-clk-ps by using the fclk divider.

- Identify what parameters are better specified in GPMC_CLK ticks instead
of seconds and provide DT bindings for them

- If gpmc_fclk changes due to whatever reasons, the driver must be notified
and it must reset GPMC_CLK to match the DT value and configure affected timings.

cheers,
-roger
