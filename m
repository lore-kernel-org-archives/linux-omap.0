From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 0/7] Fix module-mode enable sequence on OMAP4
Date: Fri, 24 Jun 2011 06:23:37 -0700
Message-ID: <4E048FD9.6060501@ti.com>
References: <1308917193-16912-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:55993 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752895Ab1FXNXo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 09:23:44 -0400
Received: by pzk28 with SMTP id 28so1933986pzk.36
        for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 06:23:42 -0700 (PDT)
In-Reply-To: <1308917193-16912-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: paul@pwsan.com, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org

On 6/24/2011 5:06 AM, Benoit Cousson wrote:
> Hi Paul&  Rajendra,
>
> Here is an updated version of the series started by Rajendra.
> I had to update it because this series is mandatory for the hwmod
> modulemodule control series.
> I rebased it on top of the various fixes done on hwmod framework
> and to take advantage of the new clkdm attribute in omap_hwmod.
> I thus added 2 new APIs to handle clockdomain from hwmod instead
> of using the clockdomain done for clock.
>
> I drop the clockdomain control for optional clocks that is not
> mandatory.

There were also some locking issues with this series pointed out
by Todd, for which I did a RFC patch to add a per-clkdm lock.
Any thoughts on that? We might need that or something similar to
prevent concurrent clkdm states being programmed, now that they
are done from hwmod (with a per-hwmod lock held) instead of being
earlier done from clk framework with a global lock held.

>
>
> On OMAP4, the PRCM recommended sequence for enabling a module after
> power-on-reset is:
>
> -1- Force clkdm to SW_WKUP
> -2- Configure desired module mode to "enable" or "auto"
> -3- Wait for the desired module idle status to be FUNC
> -4- Program clkdm in HW_AUTO(if supported)
>
> This sequence applies to all older OMAPs' as well, however since
> they use 'autodeps', it makes sure that no clkdm is in IDLE, and
> hence not requiring a force SW_WKUP when a module is being enabled.
>
> OMAP4 does not need to support autodeps, because of the dynamic
> dependency feature, wherein the HW takes care of waking up a
> clockdomain from idle and hence the module, whenever an interconnect
> access happens to the given module.
>
> Implementing the sequence for OMAP4 requires some of the clockdomain
> handling that is currently done in clock framework to be done as part
> of hwmod framework since the step -3- above to "Wait for the desired
> module idle status to be FUNC" is done as part of hwmod framework.
>
> This series moves the clockdomain handling into hwmod framework and
> implements the above sequence for OMAP4.
>
> Lastly, with this series drivers which are yet to be adapted to PM
> runtime and still rely on clock calls to enable/disable the respective
> *main* clocks are expected to be broken. MMC is one such which even
> breaks boot, and hence the series has a TEMP workaround patch added
> which keeps l3init clockdomain always force-enabled.
> This TEMP patch will gate all CORE low power transitions but should
> at least allow MPU low power transitions to work.
>
> The series is based on for_3.0.1/4_hwmod_modulemode and tested on
> OMAP4430 ES2.1 + SDP. It should not affect OMAP2&  3, but some
> testing are definitively needed.
>
> The patches are available here:
> git://gitorious.org/omap-pm/linux.git for_3.0.1/5_hwmod_clkdm_fixes
>
> Regards,
> Benoit
>
>
> v1:
>      http://www.spinics.net/lists/linux-omap/msg52265.html
>
>
> Benoit Cousson (1):
>    OMAP2+: clockdomain: Add 2 APIs to control clockdomain from hwmod framework
>
> Nayak, Rajendra (6):
>    OMAP2+: clockdomain: Add an api to read idle mode
>    OMAP2+: clockdomain: Add SoC support for clkdm_is_idle
>    OMAP2+: PM: Initialise sleep_switch to a non-valid value
>    OMAP2+: PM: idle clkdms only if already in idle
>    OMAP4: PM: TEMP: Prevent l3init from idling/force sleep
>    OMAP2+: hwmod: Follow the recommended PRCM module enable sequence
>
>   arch/arm/mach-omap2/clock.c                 |   17 +---
>   arch/arm/mach-omap2/clockdomain.c           |  171 ++++++++++++++++++++++-----
>   arch/arm/mach-omap2/clockdomain.h           |    6 +
>   arch/arm/mach-omap2/clockdomain2xxx_3xxx.c  |   12 ++
>   arch/arm/mach-omap2/clockdomain44xx.c       |   16 ++--
>   arch/arm/mach-omap2/clockdomains44xx_data.c |    2 +-
>   arch/arm/mach-omap2/omap_hwmod.c            |   28 ++++-
>   arch/arm/mach-omap2/pm.c                    |    6 +-
>   8 files changed, 200 insertions(+), 58 deletions(-)
>

