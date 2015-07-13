From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH] arm:irqchip: IRQCHIP_DECLARE macro is now accessible
Date: Mon, 13 Jul 2015 23:20:35 +0800
Message-ID: <20150713152035.GD26642@tiger>
References: <1436299411-12329-1-git-send-email-joel@porquet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436299411-12329-1-git-send-email-joel@porquet.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Porquet <joel@porquet.org>
Cc: linux-kernel@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-samsung-soc@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Kukjin Kim <kgene@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 07, 2015 at 04:02:53PM -0400, Joel Porquet wrote:
> The IRQCHIP_DECLARE macro migrated to 'include/linux/irqchip.h', making it
> globally accessible.
> 
> See commit 91e20b5040c67c51aad88cf87db4305c5bd7f79d
> ("irqchip: Move IRQCHIP_DECLARE macro to include/linux/irqchip.h").
> 
> This patch adds inclusions of 'include/linux/irqchip.h' and replaces uses of
> macro OF_DECLARE_2 with IRQCHIP_DECLARE.
> 
> Signed-off-by: Joel Porquet <joel@porquet.org>
> ---
...
>  arch/arm/mach-imx/gpc.c              | 7 ++-----

Acked-by: Shawn Guo <shawnguo@kernel.org>

How will this patch be sent to upstream?

Shawn
