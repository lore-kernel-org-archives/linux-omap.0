From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH] dmaengine: ti: edma: Enable support for polled (memcpy)
 completion
Date: Tue, 21 May 2019 12:51:31 +0530
Message-ID: <20190521072131.GB15118@vkoul-mobl>
References: <20190514080909.10306-1-peter.ujfalusi@ti.com>
 <20190521050430.GS15118@vkoul-mobl>
 <ce1a2e96-bc4b-3998-0c36-362867907177@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <ce1a2e96-bc4b-3998-0c36-362867907177@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: dmaengine@vger.kernel.org, dan.j.williams@intel.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 21-05-19, 09:16, Peter Ujfalusi wrote:
> On 21/05/2019 8.04, Vinod Koul wrote:
> > On 14-05-19, 11:09, Peter Ujfalusi wrote:

> >>  	return vchan_tx_prep(&echan->vchan, &edesc->vdesc, tx_flags);
> >> @@ -1801,6 +1804,20 @@ static enum dma_status edma_tx_status(struct dma_chan *chan,
> >>  	unsigned long flags;
> >>  
> >>  	ret = dma_cookie_status(chan, cookie, txstate);
> >> +
> >> +	if (ret != DMA_COMPLETE && echan->edesc && !echan->edesc->cyclic) {
> >> +		struct edma_cc *ecc = echan->ecc;
> >> +		int channel = EDMA_CHAN_SLOT(echan->ch_num);
> >> +		int j = (channel >> 5);
> >> +		unsigned int mask = BIT(channel & 0x1f);
> > 
> > GENMASK or define a macro instead of a magic number?
> 
> So it is better to change the other places first from where I have just
> copied this.

That would be nice as well :)

-- 
~Vinod
