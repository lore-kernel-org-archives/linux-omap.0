From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH V3 0/8] ARM: OMAP4: Add PMU Support
Date: Tue, 11 Sep 2012 12:18:58 +0530
Message-ID: <CAMQu2gzP-QjT+opTzk_nZKedqdBuQw=0sam+Uc9sJSYNBRMngg@mail.gmail.com>
References: <1347290626-21164-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:42503 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751388Ab2IKGtU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Sep 2012 02:49:20 -0400
Received: by vcdd16 with SMTP id d16so217775vcd.1
        for <linux-omap@vger.kernel.org>; Mon, 10 Sep 2012 23:49:19 -0700 (PDT)
In-Reply-To: <1347290626-21164-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>

Jon,

On Mon, Sep 10, 2012 at 8:53 PM, Jon Hunter <jon-hunter@ti.com> wrote:
> This series adds PMU support for OMAP4 devices. This is based upon Will Deacons
> series [1] and re-based upon the latest arm-soc next/cleanup branch (3.6-rc3)
> that includes Will's series. It has been re-based upon this series because
> of the dependency on Sudeep KarkadaNagesha's change (ARM: pmu: remove
> arm_pmu_type enumeration) [2] that modifies the OMAP PMU code.
>
> This series is also dependent upon some clock fixes for OMAP3 [3] and OMAP4 [4]
> for PMU to operate correctly on OMAP3 and OMAP4.
>
> This series also converts OMAP2/3 devices to use HWMOD to create the PMU device
> and add a new file to mach-omap2 directory called pmu.c where the PMU devices
> are created.
>
> Testing:
> - Verified that PMU is working on OMAP2420 H4, OMAP3430 Beagle Board, OMAP4430
>   Panda and OMAP4460 Panda.
> - Tested on the above boards with CPU-idle enabled to ensure that PMU is working
>   with power management. For OMAP3430 verified that CORE retention state is
>   entered again after stopping PMU events.
>
> V3 changes:
> - Will Deacon has taken the PMU runtime PM adaption patch in his series and so
>   not included here [1].
> - Dropped my fix for managing the EMU power domain on OMAP4 in favour of Paul's
>   implementation [4]. Paul is planning to submit for v3.7.
> - Added HWMOD data for OMAP3 DEBUG sub-system. The DEBUG sub-system was always
>   being enabled on OMAP3 devices when using PMU and hence, hinding the fact
>   that PMU is dependent upon the DEBUG sub-system on OMAP3 for it to work.
>
> [1] git://git.kernel.org/pub/sicm/linux/kernel/git/will/linux.git perf/updates
> [2] http://www.spinics.net/lists/arm-kernel/msg188726.html
> [3] http://marc.info/?l=linux-omap&m=134333691309305&w=2
> [4] http://marc.info/?l=linux-arm-kernel&m=134383567112518&w=2
>
> Cc: Ming Lei <ming.lei@canonical.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
>
> Jon Hunter (6):
>   ARM: OMAP3: Add debugss HWMOD data
>   ARM: OMAP2+: PMU: Convert OMAP2/3 devices to use HWMOD
>   ARM: OMAP4: Re-map the CTIs IRQs from MPU to DEBUGSS
>   ARM: OMAP2+: PMU: Add runtime PM support
>   ARM: OMAP4: Enable PMU for OMAP4460/70
>   ARM: OMAP2+: PMU: Add QoS constraint
>
> Ming Lei (2):
>   ARM: OMAP4430: Create PMU device via HWMOD
>   ARM: OMAP4: Route PMU IRQs to CTI IRQs
>
Thanks for persisting with the PMU series and great work to get it working
across almost all OMAPs supporting PMU. I have acked few patches
already from the series. Just quickly rescanned full series and also tried it
on OMAP4 SDP. PMU counters seems to work fine with it.

Feel free to add my ack for the entire series.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
