From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v2 0/2] dmaengine: ti: omap-dma: Improved polling support
Date: Mon, 29 Jul 2019 12:05:15 +0530
Message-ID: <20190729063515.GE12733@vkoul-mobl.Dlink>
References: <20190716082459.1222-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190716082459.1222-1-peter.ujfalusi@ti.com>
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

On 16-07-19, 11:24, Peter Ujfalusi wrote:
> Hi,
> 
> changes since v1:
> - New preparation cleanup patch
> - Simplified code for the main patch to be easier to read
> 
> This series fine-tunes the omap-dma polled memcpy support to be inline with how
> the EDMA driver is handling it.
> 
> The polled completion can be tested by applying:
> https://patchwork.kernel.org/patch/10966499/
> 
> and run the dmatest with polled = 1 on boards where sDMA is used.
> 
> Or boot up any dra7 family device with display enabled. The workaround for DMM
> errata i878 uses polled DMA memcpy.

Applied, thanks

-- 
~Vinod
