From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] dmaengine: ti-dma-crossbar: Fix event mapping for
 TPCC_EVT_MUX_60_63
Date: Fri, 22 Dec 2017 17:48:17 +0530
Message-ID: <20171222121817.GV18649@localhost>
References: <20171219105116.24335-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20171219105116.24335-1-peter.ujfalusi@ti.com>
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
Cc: dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, vigneshr@ti.com
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 19, 2017 at 12:51:16PM +0200, Peter Ujfalusi wrote:
> From: Vignesh R <vigneshr@ti.com>
> 
> Register layout of a typical TPCC_EVT_MUX_M_N register is such that the
> lowest numbered event is at the lowest byte address and highest numbered
> event at highest byte address. But TPCC_EVT_MUX_60_63 register layout is
> different,  in that the lowest numbered event is at the highest address
> and highest numbered event is at the lowest address. Therefore, modify
> ti_am335x_xbar_write() to handle TPCC_EVT_MUX_60_63 register
> accordingly.

Applied, thanks

-- 
~Vinod
