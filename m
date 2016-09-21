From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 0/2] ARM: cleanup PCI specific configs
Date: Wed, 21 Sep 2016 22:47:47 +0200
Message-ID: <3547319.cIOFfkHalq@wuerfel>
References: <1473848346-17905-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1473848346-17905-1-git-send-email-kishon@ti.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux@armlinux.org.uk, bcousson@baylibre.com, tony@atomide.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, k.kozlowski@samsung.com, magnus.damm@gmail.com, horms@verge.net.au, shawnguo@kernel.org, nicolas.ferre@atmel.com, nsekhar@ti.com, kgene@kernel.org, khalasa@piap.pl, kernel@pengutronix.de, ssantosh@kernel.org, fabio.estevam@nxp.com, alexandre.belloni@free-electrons.com, plagnioj@jcrosoft.com, shiraz.linux.kernel@gmail.com, vireshk@kernel.org, arm@kernel.org
List-Id: linux-omap@vger.kernel.org

On Wednesday, September 14, 2016 3:49:04 PM CEST Kishon Vijay Abraham I wrote:
> This series was initially sent to add support for two PCIe
> ports in dra7. This included selecting PCI_DOMAINS config
> in SOC_DRA7XX.
> 
> However from the review, PCI_DOMAINS can instead be selected
> from ARCH_MULTIPLATFORM. This is fixed in this series along
> with removing PCI_DOMAINS from other configs.
> 
> Changes from v3:
> *) Added *Acked-by:*
> *) Fixed $subject to not have *Fix*
> 
> Kishon Vijay Abraham I (2):
>   ARM: stop *MIGHT_HAVE_PCI* config from being selected redundantly
>   ARM: select PCI_DOMAINS config from ARCH_MULTIPLATFORM
> 

Applied both to next/cleanup now.

	Arnd
