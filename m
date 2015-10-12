From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 11/25] ARM/dmaengine: edma: Merge the two drivers
 under drivers/dma/
Date: Mon, 12 Oct 2015 21:30:25 +0530
Message-ID: <20151012160024.GF27370@localhost>
References: <1443088932-21731-1-git-send-email-peter.ujfalusi@ti.com>
 <1443088932-21731-12-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1443088932-21731-12-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: nsekhar@ti.com, linux@arm.linux.org.uk, olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 24, 2015 at 01:01:58PM +0300, Peter Ujfalusi wrote:
> Move the code out from arch/arm/common and merge it inside of the dmaengine
> driver.
> This change is done with as minimal change to the code as possible to avoid
> any possibilities to introducing regression.

Is this a pure move patch or code has been modified, if latter am
disappointed that existing code style issue have not been fixed


> +static inline void edma_write(struct edma_cc *ecc, int offset, int val)
> +{
> +	__raw_writel(val, ecc->base + offset);
> +}
> +static inline void edma_modify(struct edma_cc *ecc, int offset, unsigned and,
> +			       unsigned or)

This looks bad on my 80 char screen, and few more places below

> +{
> +	unsigned val = edma_read(ecc, offset);

checkpatch should have asked you to add empty line here, many places below
too

> +	val &= and;
> +	val |= or;
> +	edma_write(ecc, offset, val);
> +}

empty line here and few more places

More later :)

-- 
~Vinod
