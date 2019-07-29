From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v5 0/3] dmaengine: ti: edma: Polled completion support
Date: Mon, 29 Jul 2019 13:03:19 +0530
Message-ID: <20190729073319.GK12733@vkoul-mobl.Dlink>
References: <20190716082655.1620-1-peter.ujfalusi@ti.com>
 <20190729064209.GF12733@vkoul-mobl.Dlink>
 <fe201b5b-916d-1889-31b0-dcac20733b65@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <fe201b5b-916d-1889-31b0-dcac20733b65@ti.com>
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

On 29-07-19, 10:24, Peter Ujfalusi wrote:
> Vinod,
> 
> On 29/07/2019 9.42, Vinod Koul wrote:
> > On 16-07-19, 11:26, Peter Ujfalusi wrote:
> >> Hi,
> >>
> >> Changes since v4:
> >> - Split the DMA_COMPLETE and !txstate check as Vinod suggested
> >>
> >> Change since v3:
> >> - fix DMA pointer tracking for memcpy
> >> - completion polling is only done when it is asked by not providing
> >>   DMA_PREP_INTERRUPT for memcpy
> >>
> >> Changes since v2:
> >> - Fix typo in the comment for patch 0
> >>
> >> Changes since v1:
> >> - Cleanup patch for the array register handling
> >> - typo fixed in patch2 commit message
> >>
> >> The code around the array register access was pretty confusing for the first
> >> look, so clean them up first then use the cleaner way in the polled handling.
> >>
> >> When a DMA client driver does not set the DMA_PREP_INTERRUPT because it
> >> does not want to use interrupts for DMA completion or because it can not
> >> rely on DMA interrupts due to executing the memcpy when interrupts are
> >> disabled it will poll the status of the transfer.
> >>
> >> Since we can not tell from any EDMA register that the transfer is
> >> completed, we can only know that the paRAM set has been sent to TPTC for
> >> processing we need to check the residue of the transfer, if it is 0 then
> >> the transfer is completed.
> >>
> >> The polled completion can bve tested by applying:
> >> https://patchwork.kernel.org/patch/10966499/
> 
> Should I resend this patch so the polled mode can be tested in upstream?

Yes sure

-- 
~Vinod
