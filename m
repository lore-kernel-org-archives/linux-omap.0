From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/4] OMAP2xxx clock/CPUFreq: fix compilation errors;
 clean up
Date: Tue, 5 Jan 2010 10:06:59 -0800
Message-ID: <20100105180659.GD12378@atomide.com>
References: <20100105173347.15485.42853.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50465 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754041Ab0AESG7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 13:06:59 -0500
Content-Disposition: inline
In-Reply-To: <20100105173347.15485.42853.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [100105 09:35]:
> Hello,
> 
> This series fixes several compilation errors for OMAP2xxx chips when
> CONFIG_CPU_FREQ is set.  These were reported and partially fixed
> by Felipe Balbi <felipe.balbi@nokia.com>.
> 
> Considerable work is still needed to fully support dynamic frequency
> changes on OMAP2xxx-series chips.  Readers interested in such a
> project are encouraged to review the Maemo Diablo RX-34 and RX-44
> kernel source at:
> 
>     http://repository.maemo.org/pool/diablo/free/k/kernel-source-diablo/
> 
> Boot-tested on N800 with n8x0_defconfig with CONFIG_CPU_FREQ; compile-tested
> for 2430SDP.
> 
> This second version also incorporates some comments from Felipe.

These look good to me, can you please send them one more time with
LAKML Cc'd for a quick review there?

Regards,

Tony

> 
> 
> - Paul
> 
> ---
> 
> Felipe Balbi (1):
>       OMAP2xxx clock: clk2xxx.c doesn't compile if CPUFREQ is enabled
> 
> Paul Walmsley (3):
>       OMAP2xxx OPP: clean up comments in OPP data
>       OMAP2 clock: dynamically allocate CPUFreq frequency table
>       OMAP clock/CPUFreq: avoid leaking the CPUFreq frequency table
> 
> 
>  arch/arm/mach-omap2/clock2xxx.c         |   57 ++++++++++++++++++++++++++-----
>  arch/arm/mach-omap2/opp2420_data.c      |   38 +++++++++++----------
>  arch/arm/mach-omap2/opp2430_data.c      |   30 ++++++++--------
>  arch/arm/plat-omap/clock.c              |   10 +++++
>  arch/arm/plat-omap/cpu-omap.c           |    1 +
>  arch/arm/plat-omap/include/plat/clock.h |    2 +
>  6 files changed, 96 insertions(+), 42 deletions(-)
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
