From: Robert Abel <rabel@cit-ec.uni-bielefeld.de>
Subject: Re: [PATCH 2/4] ARM OMAP2+ GPMC: always program GPMCFCLKDIVIDER
Date: Tue, 17 Feb 2015 14:47:30 +0100
Message-ID: <CAMdRc4GuJKnr1Kp=2V_S4NJq09TqxF7Cb-HWmXmzkgr6ynh27Q@mail.gmail.com>
References: <1424101741-24152-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
	<1424101741-24152-2-git-send-email-rabel@cit-ec.uni-bielefeld.de>
	<1424101741-24152-3-git-send-email-rabel@cit-ec.uni-bielefeld.de>
	<54E2F803.3070901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54E2F803.3070901@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: khilman@deeprootsystems.com, Tony Lindgren <tony@atomide.com>, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, Linux Kernel Maling List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Roger,

On Tue, Feb 17, 2015 at 9:12 AM, Roger Quadros <rogerq@ti.com> wrote:
>
> Can you use the following wording from TRM instead?
>
> as per am335x TRM (spruh73i.pdf), section 7.1.3.3.8.3.2
>
> The WAITMONITORINGTIME is expressed as a number of GPMC_CLK clock cycles,
> even though the access is defined as asynchronous, and no GPMC_CLK clock
> is provided to the external device. Still, GPMCFCLKDIVIDER is used as a divider
> for the GPMC clock, so it must be programmed to define the
> correct WAITMONITORINGTIME delay.


Verbatim? Sure can. Gonna do that with a rebase to 3.19, I guess.

>
> Instead of this can we explicitly set the GPMC_CLK divider to 1 and hence
> corresponding divider bits to 0 in the asynchronous case?
> This is because the previously calculated "div" depends on synchronous clock which
> might not be properly initialized for asynchronous devices.


No, we shouldn't. If WAITREADMONITORING and/or WAITWRITEMONITORING is
enabled, sync_clk must be set in order to use WAITMONITORINGTIME
correctly. If it's not explicitly set, it's set to 0, which yields div
1 anyways.
The reason being that a fixed divider of 1 will limit a user's ability
to prolong the #WAIT-deassert --> *access delay for no good reason. If
working with a slow device, this will inconvenience users.

>
> AFAIK t->sync_clk is always 0 for asynchronous devices and gpmc_calc_divider(0)
> will return 1 and your patch will work but still we shouldn't depend on sync_clk for
> asynchronous devices so let's set this explicitly.


See above. Hardware depends on divider, divider is set by sync_clk, so
we shouldn't limit what a user can program in DT.
Having said that, I'm not aware that sync_clk is always 0 for async
devices. The code always parses it and sets the appropriate field in
gpmc_t, which is passed to gpmc_cs_set_timings.
Now, there is generally a lack of checking for optional/required DT
properties, so I didn't add extra checking.

Regards,

Robert
