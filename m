From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm:irqchip: IRQCHIP_DECLARE macro is now accessible
Date: Tue, 7 Jul 2015 23:40:42 -0700
Message-ID: <20150708064042.GU10705@atomide.com>
References: <1436299411-12329-1-git-send-email-joel@porquet.org>
 <559C64F2.9070803@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <559C64F2.9070803@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Joel Porquet <joel@porquet.org>, linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Kukjin Kim <kgene@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Krzysztof Kozlowski <k.kozlowski@samsung.com> [150707 16:49]:
> On 08.07.2015 05:02, Joel Porquet wrote:
> > The IRQCHIP_DECLARE macro migrated to 'include/linux/irqchip.h', making it
> > globally accessible.
> > 
> > See commit 91e20b5040c67c51aad88cf87db4305c5bd7f79d
> > ("irqchip: Move IRQCHIP_DECLARE macro to include/linux/irqchip.h").
> > 
> > This patch adds inclusions of 'include/linux/irqchip.h' and replaces uses of
> > macro OF_DECLARE_2 with IRQCHIP_DECLARE.
> > 
> > Signed-off-by: Joel Porquet <joel@porquet.org>
> > ---
> >  arch/arm/mach-exynos/suspend.c       | 3 ++-
> >  arch/arm/mach-imx/gpc.c              | 7 ++-----
> >  arch/arm/mach-omap2/omap-wakeupgen.c | 7 ++-----
> >  3 files changed, 6 insertions(+), 11 deletions(-)
> > 
> 
> For Exynos:
> Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

For omap changes:

Acked-by: Tony Lindgren <tony@atomide.com>
