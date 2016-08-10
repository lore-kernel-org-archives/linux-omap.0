From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [RFT RESEND PATCH v3 3/3] ARM: select PCI_DOMAINS config from
 ARCH_MULTIPLATFORM
Date: Wed, 10 Aug 2016 15:23:43 +0200
Message-ID: <cf4a7376-1cd4-aeb4-cbf0-7dbbc3575137@samsung.com>
References: <1470832400-11929-1-git-send-email-kishon@ti.com>
 <1470832400-11929-4-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1470832400-11929-4-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Russell King <linux@armlinux.org.uk>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Shawn Guo <shawnguo@kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, nsekhar@ti.com, Rob Herring <robh+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Kukjin Kim <kgene@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Santosh Shilimkar <ssantosh@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Krzysztof Halasa <khalasa@piap.pl>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, Viresh Kumar <vireshk@kernel.org>
List-Id: linux-omap@vger.kernel.org

On 08/10/2016 02:33 PM, Kishon Vijay Abraham I wrote:
> PCI_DOMAINS config should be selected for any SoCs
> having more than a single PCIe controller. Without PCI_DOMAINS
> config, only one PCIe controller gets registered.
> 
> Select PCI_DOMAINS in ARCH_MULTIPLATFORM if PCI is selected, since
> it doesn't harm even if a platform has a single PCIe port.
> Also remove PCI_DOMAINS being selected from other platform
> specific configs.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm/Kconfig               |    1 +
>  arch/arm/mach-axxia/Kconfig    |    1 -
>  arch/arm/mach-cns3xxx/Kconfig  |    1 -
>  arch/arm/mach-exynos/Kconfig   |    1 -
>  arch/arm/mach-imx/Kconfig      |    2 --
>  arch/arm/mach-keystone/Kconfig |    1 -
>  arch/arm/mach-shmobile/Kconfig |    1 -
>  7 files changed, 1 insertion(+), 7 deletions(-)

For Exynos5440 output is equal and we do not use PCI on other SoCs, so:

Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
