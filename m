From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] ARM OMAP2+ GPMC: always program GPMCFCLKDIVIDER
Date: Mon, 23 Feb 2015 14:03:23 -0800
Message-ID: <20150223220322.GI32521@atomide.com>
References: <1424101741-24152-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
 <1424101741-24152-2-git-send-email-rabel@cit-ec.uni-bielefeld.de>
 <1424101741-24152-3-git-send-email-rabel@cit-ec.uni-bielefeld.de>
 <54E2F803.3070901@ti.com>
 <CAMdRc4F9B0ft-ExgQ1vHqwXMiONwWKn3FPCRDyHsjgGe1Dn_1w@mail.gmail.com>
 <54E34786.1010102@ti.com>
 <CAMdRc4F1Ja2Y96W_VESuS=tueYE8Q+iWmoiJW2dj+6-HeDzNqQ@mail.gmail.com>
 <54E34F73.2080108@ti.com>
 <CAMdRc4Gj5MM9TdjiQtCqHcy4b3wAKB2Sx4MfncUNnsrntWRz1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMdRc4Gj5MM9TdjiQtCqHcy4b3wAKB2Sx4MfncUNnsrntWRz1Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Abel <rabel@cit-ec.uni-bielefeld.de>
Cc: Roger Quadros <rogerq@ti.com>, khilman@deeprootsystems.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, Linux Kernel Maling List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Robert Abel <rabel@cit-ec.uni-bielefeld.de> [150223 13:42]:
> On Tue, Feb 17, 2015 at 3:25 PM, Roger Quadros <rogerq@ti.com> wrote:
> > one more thing to note is that just specifying sync-clk-ps in DT is not enough for
> > asynchronous devices.
> >
> > The driver doesn't set gpmc_t->sync_clk if "gpmc,sync-read" or "gpmc,sync-write"
> > was not set in the DT, which would be the case for asynchronous devices.
> 
> You're mistaken. It's always parsed, no matter what. See [1]. But I
> did implement your suggestion of computing the divider in the mean
> time. I'm going to send the patches rebased to 3.19 tomorrow, after I
> tested them.
> 
> > What is your proposal to make things better? And what is your use case that doesn't
> > work with existing setup?
> 
> Well, the current setup was obviously inspired by an asynchronous-only
> use-case, where all the timings are in seconds and get converted
> on-the-fly. Of course, currently, there is no support to re-compute
> them once the gpmc_fclk changes frequency, but I guess that's what the
> TODO about the clock framework is about?
> 
> Anyway, my synchronous use-case is inherently... synchronous.
> Synchronous protocols shouldn't be specified in ns at all. They should
> directly be specified in clock ticks. This is also advantageous, as
> changes in gpmc_fclk don't need to propagate to the registers.
> 
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
> 
> For instance, I originally started out thinking the GPMC would run at
> 100 MHz externally -- because it's the max frequency rating -- only to
> be surprised when the clock looked weird on the GPMC_CLK pin, because
> it was at 166 MHz. I'm not sure how to completely remedy this, but
> specifying timings in ns in DT and then depending on the correct board
> frequency is kind of shady... :(

There have been few gpmc devices that were configured to work with
changing L3 frequencies. For the related retime function, maybe take
a look at the code removed for tusb_set_sync_mode() in commit
47acde167260. Just specifying the ticks is not enough there either..

Sorry I don't have a solution to how the timings should be specified,
but both timings and ticks are needed it seems.

Regards,

Tony
 
> [1]: http://lxr.free-electrons.com/source/drivers/memory/omap-gpmc.c#L1509
> [2]: http://processors.wiki.ti.com/images/5/56/SpansionNOR-AM35x.pdf ;
> ("WS/NS/VS can be used for synchronous burst read / asynchronous
> single write")
