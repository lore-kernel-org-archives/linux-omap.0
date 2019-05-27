From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v3 0/2] dmaengine: ti: edma: Polled completion support
Date: Mon, 27 May 2019 12:09:32 +0530
Message-ID: <20190527063932.GE15118@vkoul-mobl>
References: <20190521093646.21836-1-peter.ujfalusi@ti.com>
 <19b0d346-5249-e832-8eea-685c8e7706e2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <19b0d346-5249-e832-8eea-685c8e7706e2@ti.com>
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

On 23-05-19, 13:57, Peter Ujfalusi wrote:
> Vinod,
> 
> On 21/05/2019 12.36, Peter Ujfalusi wrote:
> > Hi,
> > 
> > Changes since v2:
> > - Fix typo in the comment for patch 0
> > 
> > Changes since v1:
> > - Cleanup patch for the array register handling
> > - typo fixed in patch2 commit message
> > 
> > The code around the array register access was pretty confusing for the first
> > look, so clean them up first then use the cleaner way in the polled handling.
> > 
> > When a DMA client driver decides that it is not providing callback for
> > completion of a transfer (and/or does not set the DMA_PREP_INTERRUPT) but
> > it will poll the status of the transfer (in case of short memcpy for
> > example) we will not get interrupt for the completion of the transfer and
> > will not mark the transaction as done.
> > 
> > Check the event registers (ER and EER) and if the channel is inactive then
> > return wioth DMA_COMPLETE to let the client know that the transfer is
> > completed.
> 
> Please do not pick this up yet, I got report that it might cause side
> effect which I need to debug to understand.

OK dropped for queue

-- 
~Vinod
