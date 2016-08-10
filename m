From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 0/6] dmaengine:omap-dma: Linked List transfer for
 slave_sg
Date: Wed, 10 Aug 2016 23:02:36 +0530
Message-ID: <20160810173235.GI9681@localhost>
References: <20160720085032.2955-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160720085032.2955-1-peter.ujfalusi@ti.com>
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
Cc: linux@arm.linux.org.uk, tony@atomide.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 20, 2016 at 11:50:26AM +0300, Peter Ujfalusi wrote:
> Hi,
> 
> Changes since v1:
> - dropped the patch changing the sequence of vchan_cookie_complete and
>   omap_dma_start_sg in omap_dma_callback
> - Use appropriate macros to find omap_chan and omap_desc in patch 6
> - Use per-device pool instead of per-channel pools.
> 
> The following series with the final patch will add support for sDMA Linked List
> transfer support.
> Linked List is supported by sDMA in OMAP3630+ (OMAP4/5, dra7 family).
> If the descriptor load feature is present we can create the descriptors for each
> SG beforehand and let sDMA to walk them through.
> This way the number of sDMA interrupts the kernel need to handle will drop
> dramatically.

Applied all, thanks

-- 
~Vinod
