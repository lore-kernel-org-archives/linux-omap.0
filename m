From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RE: [RFC PATCH v4] Consolidate SRAM support
Date: Wed, 29 Jun 2011 18:42:22 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D7941B6@dbde02.ent.ti.com>
References: <20110512174546.GB8633@n2100.arm.linux.org.uk>
	<1306371777-20431-1-git-send-email-plagnioj@jcrosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1306371777-20431-1-git-send-email-plagnioj@jcrosoft.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "Hilman, Kevin" <khilman@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Sascha Hauer <kernel@pengutronix.de>, Russell King <rmk+kernel@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Jean-Christophe,

On Thu, May 26, 2011 at 06:32:57, Jean-Christophe PLAGNIOL-VILLARD wrote:
> From: Russell King - ARM Linux <linux@arm.linux.org.uk>
> 
> We have two SoCs using SRAM, both with their own allocation systems,
> and both with their own ways of copying functions into the SRAM.
> 
> Let's unify this before we have additional SoCs re-implementing this
> obviously common functionality themselves.
> 
> For this use the generic allocator and the newly introduce
> gen_pool_add_virt and gen_pool_virt_to_phys
> 
> Uio_pruss should probably take the SRAM pool pointer via
> platform data so that it doesn't have to include Davinci specific
> includes.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>

Is this patch slated to be merged for v3.1?
I did not find it in linux-next.

There is some further cleanup done by Ben
Gardiner for DaVinci which depends on this patch.

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index f4b7dfa..5ec5e5f 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -848,6 +848,7 @@ config ARCH_DAVINCI
>  	bool "TI DaVinci"
>  	select GENERIC_CLOCKEVENTS
>  	select ARCH_REQUIRE_GPIOLIB
> +	select GENERIC_ALLOCATOR
>  	select ZONE_DMA
>  	select HAVE_IDE
>  	select CLKDEV_LOOKUP

Just noticed that GENERIC_ALLOCATOR is already selected
For DaVinci (it is right below the CLKDEV_LOOKUP selection)
so this part of the patch can be dropped.

Thanks,
Sekhar
