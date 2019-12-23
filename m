From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 10/14] dmaengine: ti: omap-dma: Pass sdma auxdata to
 driver and use it
Date: Mon, 23 Dec 2019 13:16:38 +0530
Message-ID: <20191223074638.GZ2536@vkoul-mobl>
References: <20191217001925.44558-1-tony@atomide.com>
 <20191217001925.44558-11-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20191217001925.44558-11-tony@atomide.com>
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
> We can now start passing sdma auxdata to the dmaengine driver to start
> removing the platform based sdma init.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
