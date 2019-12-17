From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 12/14] dmaengine: ti: omap-dma: Use cpu notifier to block
 idle for omap2
Date: Mon, 16 Dec 2019 16:27:16 -0800
Message-ID: <20191217002716.GT35479@atomide.com>
References: <20191217001925.44558-1-tony@atomide.com>
 <20191217001925.44558-13-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20191217001925.44558-13-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Vinod Koul <vinod.koul@intel.com>, Vinod Koul <vkoul@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [191217 00:20]:
> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
> +	case CPU_CLUSTER_PM_ENTER:
> +		while (1) {
> +			lch = find_next_bit(od->lch_bitmap, od->lch_count,
> +					    lch + 1);
> +			if (lch >= od->lch_count)
> +				break;
> +			c = od->lch_map[lch];
> +			if (!c)
> +				continue;
> +			if (omap_dma_chan_read(c, CCR) & CCR_ENABLE) {
> +				pr_info("XXX %s: lch%i busy\n", __func__, lch);
> +				return NOTIFY_BAD;

Oops the pr_info line here can be dropped :)

Regards,

Tony
