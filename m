From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 08/14] dmaengine: ti: omap-dma: Add device tree match
 data and use it for cpu_pm
Date: Mon, 23 Dec 2019 13:13:58 +0530
Message-ID: <20191223074358.GX2536@vkoul-mobl>
References: <20191217001925.44558-1-tony@atomide.com>
 <20191217001925.44558-9-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20191217001925.44558-9-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Vinod Koul <vinod.koul@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 16-12-19, 16:19, Tony Lindgren wrote:
> With old DMA code disabled for handling DMA requests for device tree based
> SoCs, we can move omap3 specific context save and restore to the dmaengine
> driver.
> 
> Let's do this by adding cpu_pm notifier handling to save and restore context,
> and enable it based on device tree match data. This way we can use the match
> data later to configure more SoC specific features later on too.
> 
> Note that we only clear the channels in use while the platform code also
> clears reserved channels 0 and 1 on high-security SoCs. Based on testing
> on n900, this is not needed though and the system idles just fine.
> 
> With the dmaengine driver handling context save and restore, we must now
> remove the old custom calls for context save and restore.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
