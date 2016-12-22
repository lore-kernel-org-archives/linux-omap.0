From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [BISECTED] v4.9: OMAP MMC regression
Date: Thu, 22 Dec 2016 22:58:43 +0200
Message-ID: <20161222205843.md4uggwyegcfuk3j@raspberrypi-2.musicnaut.iki.fi>
References: <20161217220120.xgyzq2hwxn3lsmm2@raspberrypi-2.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20161217220120.xgyzq2hwxn3lsmm2@raspberrypi-2.musicnaut.iki.fi>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Vinod Koul <vinod.koul@intel.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Sun, Dec 18, 2016 at 12:01:21AM +0200, Aaro Koskinen wrote:
> OMAP MMC is silently missing when booting v4.9 on Nokia 770 (OMAP1).
> 
> Bisected to:
> 
> commit 2d1a9a946faebfedd660a1f1c2b90984fff41f91
> Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Date:   Wed Jul 20 11:50:29 2016 +0300
> 
>     dmaengine: omap-dma: Dynamically allocate memory for lch_map
> 
> Reveting the commit makes MMC to appear and work again...

This commit basically reduces dma_requests count to 17 (from 127)
on OMAP1.

This cannot be correct, since OMAP1 MMC is using requests (from
omap1_init_mmc):

                        rx_req = 22;
                        tx_req = 21;
[...]
                        rx_req = 55;
                        tx_req = 54;

MMC probe will fail because omap_dma_filter_fn() will fail during
dma_request_chan().

I think 2d1a9a946faebfedd660a1f1c2b90984fff41f91 should be reverted.
I cannot anymore boot my 770 with >= 4.9 kernel.

A.
