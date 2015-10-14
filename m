From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 20/25] dmaengine: edma: Simplify the interrupt handling
Date: Wed, 14 Oct 2015 15:50:39 +0530
Message-ID: <20151014102039.GK27370@localhost>
References: <1443088932-21731-1-git-send-email-peter.ujfalusi@ti.com>
 <1443088932-21731-21-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1443088932-21731-21-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: nsekhar@ti.com, linux@arm.linux.org.uk, olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 24, 2015 at 01:02:07PM +0300, Peter Ujfalusi wrote:

> +	if (edesc->cyclic) {
> +		vchan_cyclic_callback(&edesc->vdesc);
> +		spin_unlock(&echan->vchan.lock);
> +		return;
> +	} else if (edesc->processed == edesc->pset_nr) {
> +		dev_dbg(dev, "Transfer completed on channel %d\n",
> +			echan->ch_num);

perhaps not a great choice for a print, we would ideally want to complete
the cookie and then print

> +	sh_ipr = edma_shadow0_read_array(ecc, SH_IPR, 0);
> +	if (!sh_ipr) {
> +		sh_ipr = edma_shadow0_read_array(ecc, SH_IPR, 1);
> +		if (!sh_ipr)
> +			return IRQ_NONE;
> +		sh_ier = edma_shadow0_read_array(ecc, SH_IER, 1);
> +		bank = 1;
> +	} else {
> +		sh_ier = edma_shadow0_read_array(ecc, SH_IER, 0);
> +		bank = 0;
> +	}
> +
> +	do {
> +		u32 slot;
> +		u32 channel;
> +
> +		dev_dbg(ecc->dev, "IPR%d %08x\n", bank, sh_ipr);

Too much debug prints...

> +	edma_read_slot(ecc, echan->slot[0], &p);
> +	/*
> +	 * Issue later based on missed flag which will be sure
> +	 * to happen as:
> +	 * (1) we finished transmitting an intermediate slot and
> +	 *     edma_execute is coming up.
> +	 * (2) or we finished current transfer and issue will
> +	 *     call edma_execute.
> +	 *
> +	 * Important note: issuing can be dangerous here and
> +	 * lead to some nasty recursion when we are in a NULL
> +	 * slot. So we avoid doing so and set the missed flag.
> +	 */
> +	if (p.a_b_cnt == 0 && p.ccnt == 0) {
> +		dev_dbg(dev, "Error on null slot, setting miss\n");

Shouldn't this be err ?

> +		} else if (edma_read(ecc, EDMA_QEMR)) {
> +			dev_dbg(ecc->dev, "QEMR %02x\n",
> +				edma_read(ecc, EDMA_QEMR));
> +			for (i = 0; i < 8; i++) {
> +				if (edma_read(ecc, EDMA_QEMR) & BIT(i)) {
> +					/* Clear the corresponding IPR bits */
> +					edma_write(ecc, EDMA_QEMCR, BIT(i));
> +					edma_shadow0_write(ecc, SH_QSECR,
> +							   BIT(i));
> +
> +					/* NOTE:  not reported!! */

what does this mean?

-- 
~Vinod
