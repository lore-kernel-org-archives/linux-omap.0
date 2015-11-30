From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 0/3] dmaengine: ti-dma-crossbar: channel reserving and
 edma3-tpcc support
Date: Mon, 30 Nov 2015 20:48:06 +0530
Message-ID: <20151130151806.GE3901@localhost>
References: <1446192038-11158-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1446192038-11158-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: nsekhar@ti.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, tony@atomide.com, r.schwebel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 30, 2015 at 10:00:35AM +0200, Peter Ujfalusi wrote:
> Hi,
> 
> Changes since v1:
> - Fixed issue introduced by the bitops patch: wrong error check, also switch to
>   use find_first_zero_bit() instead of find_next_zero_bit()
> 
> Cover letter:
> 
> This series depends on the eDMA work I have done, which has been now applied:
> https://lkml.org/lkml/2015/10/16/64
> 
> DRA7 family of chips have both sDMA and eDMA. Currently only sDMA can be used
> becasue the old driver stack for eDMA did not allowed integration w/o hacks.
> 
> Due to the nature of eDMA the crossbar needs to know which eDMA events it can
> use to map incoming events towards the eDMA. In eDMA a channel is wired to be
> used with one specific event. For example eDMA event 14 can only be handled by
> eDMA channel 14.
> The eDMA itself can be shared by different processors in the system (ARM, DSP,
> etc) and since ARM/Linux is the master we need to know which channels are used
> by other cores. Also we need to mask out channels used for memcpy from the
> events we use for HW triggers.

Applied, thanks

-- 
~Vinod
