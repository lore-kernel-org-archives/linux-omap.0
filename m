From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [RFT PATCH v2 2/3] ARM: Fix *MIGHT_HAVE_PCI* config from being
 selected redundantly
Date: Tue, 2 Aug 2016 11:52:35 +0530
Message-ID: <57A03C2B.2080407@ti.com>
References: <1470049950-4697-1-git-send-email-kishon@ti.com>
 <1470049950-4697-3-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1470049950-4697-3-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Krzysztof Halasa <khalasa@piap.pl>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Santosh Shilimkar <ssantosh@kernel.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Viresh Kumar <vireshk@kernel.org>, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org, nsekhar@ti.com, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, helgaas@kernel.org, Benoit Cousson <bcousson@baylibre.com>, Greg Ungerer <gerg@uclinux.org>, Fabio Estevam <fabio.estevam@nxp.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Monday 01 August 2016 04:42 PM, Kishon Vijay Abraham I wrote:
> *MIGHT_HAVE_PCI* config is already selected in ARCH_MULTIPLATFORM.
> Fix it from getting redundantly selected in all
> ARCH_MULTIPLATFORM based machines.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm/Kconfig                 |    2 --
>  arch/arm/mach-at91/Kconfig       |    1 -
>  arch/arm/mach-axxia/Kconfig      |    1 -
>  arch/arm/mach-exynos/Kconfig     |    1 -
>  arch/arm/mach-integrator/Kconfig |    1 -
>  arch/arm/mach-keystone/Kconfig   |    1 -
>  arch/arm/mach-ks8695/Kconfig     |    5 -----
>  arch/arm/mach-pxa/Kconfig        |    1 -
>  arch/arm/mach-spear/Kconfig      |    1 -
>  arch/arm/mach-versatile/Kconfig  |    1 -

Thank you everyone for reviewing this patch.
Looks like ARCH_IXP4XX, ARCH_DOVE, ARCH_KS8695, ARCH_PXA are not converted to
multiplatform. I'll fix this patch accordingly and repost the series.

Thanks
Kishon
