From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] dmaengine: omap-dma: Enable packed accesses for cyclic
 transfers
Date: Mon, 5 Oct 2015 16:32:58 +0100
Message-ID: <20151005153258.GF13501@vkoul-mobl.iind.intel.com>
References: <1442233865-10412-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442233865-10412-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, misael.lopez@ti.com
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 14, 2015 at 03:31:05PM +0300, Peter Ujfalusi wrote:
> From: Misael Lopez Cruz <misael.lopez@ti.com>
> 
> The L3 throughput can be higher than expected when packed access
> is not enabled.  The ratio depends on the number of bytes in a
> transaction and the EMIF interface width.
> 
> The throughput was measured for the following settings/cases:
> 
> * Case 1: Burst size of 64 bytes, packed access disabled
> * Case 2: Burst size of 64 bytes, packed access enabled
> * Case 3: Burst disabled, packed access disabled
> 
> Throughput measurements were done during McASP-based audio
> playback on the Jacinto6 EVM using the omapconf tool [1]:
> $ omapconf trace bw -m sdma_rd
> 
>  ---------------------------------------------------------
>                                   Throughput (MB/s)
>   Audio parameters            Case 1    Case 2    Case 3
>  ---------------------------------------------------------
>   44.1kHz, 16-bits, stereo      1.41      0.18      1.41
>   44.1kHz, 32-bits, stereo      1.41      0.35      1.41
>   44.1kHz, 16-bits, 4-chan      2.82      0.35      2.82
>   44.1kHz, 16-bits, 6-chan      4.23      0.53      4.23
>   44.1kHz, 16-bits, 8-chan      5.64      0.71      5.64
>  ---------------------------------------------------------
> 
> From above measurements, case 2 is the only one that delivers
> the expected throughput for the given audio parameters.  For
> that reason, the packed accesses are now enabled.
> 
> It's worth to mention that packed accesses cannot be enabled
> for all addressing modes. In cyclic transfers, it can be
> enabled in the source for MEM_TO_DEV and in dest for DEV_TO_MEM,
> as they use post-increment mode which supports packed accesses.
> 
> Peter Ujfalusi:
> From the TRM regarding to this:
> "NOTE: Except in the constant addressing mode, the source or
> destination must be specified as packed for burst transactions
> to occur."
> 
> So w/o the packed setting the burst on the MEM side was not
> enabled, this explains the numbers.
> 
> [1] https://github.com/omapconf/omapconf
> 

Applied, thanks

-- 
~Vinod
