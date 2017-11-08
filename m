From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH RESEND] dmaengine: ti-dma-crossbar: Correct am335x/am43xx
 mux value type
Date: Wed, 8 Nov 2017 19:52:33 +0530
Message-ID: <20171108142232.GY3187@localhost>
References: <20171108100225.25024-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171108100225.25024-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 08, 2017 at 12:02:25PM +0200, Peter Ujfalusi wrote:
> The used 0x1f mask is only valid for am335x family of SoC, different family
> using this type of crossbar might have different number of electable
> events. In case of am43xx family 0x3f mask should have been used for
> example.
> Instead of trying to handle each family's mask, just use u8 type to store
> the mux value since the event offsets are aligned to byte offset.
> 
> Fixes: 42dbdcc6bf965 ("dmaengine: ti-dma-crossbar: Add support for crossbar on AM33xx/AM43xx")
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Vinod,
> 
> this patch somehow got missed, I have sent it in May:
> https://patchwork.kernel.org/patch/9736747/

not sure how, but applied now

-- 
~Vinod
