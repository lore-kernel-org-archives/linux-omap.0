From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 1/4] part 2 of omap intc changes for v3.18 merge window
Date: Thu, 25 Sep 2014 23:58:32 +0200
Message-ID: <201409252358.33038.arnd@arndb.de>
References: <pull-1411070912-460910>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1411070912-460910>
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
Cc: linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thursday 18 September 2014, Tony Lindgren wrote:
> The following changes since commit 55601c9f24670ba926ebdd4d712ac3b177232330:
> 
>   arm: omap: intc: switch over to linear irq domain (2014-09-11 13:05:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/intc-part2-for-v3.18
> 
> for you to fetch changes up to 64d5947b9ee1284b38b8e212e7c94024452b2bb4:
> 
>   irqchip: omap-intc: remove unnecessary comments (2014-09-16 14:45:01 -0700)
> 
> ----------------------------------------------------------------
> Second part of omap intc interrupt controller changes to
> move it to drivers.
> 
> ----------------------------------------------------------------
> Felipe Balbi (10):
>       arm: omap2: n8x0: move i2c devices to DT
>       irqchip: add irq-omap-intc.h header
>       arm: omap: irq: move irq.c to drivers/irqchip/
>       irqchip: omap-intc: minor improvement to omap_irq_pending()
>       irqchip: omap-intc: comment style cleanup
>       irqchip: omap-intc: remove unnecesary of_address_to_resource() call
>       irqchip: omap-intc: enable IP protection
>       irqchip: omap-intc: enable TURBO idle mode
>       irqchip: omap-intc: correct maximum number or MIR registers
>       irqchip: omap-intc: remove unnecessary comments
> 
>  arch/arm/boot/dts/omap2420-n810.dts                |  7 +++
>  arch/arm/boot/dts/omap2420-n8x0-common.dtsi        |  6 ++
>  arch/arm/mach-omap2/Kconfig                        |  1 +
>  arch/arm/mach-omap2/Makefile                       |  3 +-
>  arch/arm/mach-omap2/board-n8x0.c                   | 26 +--------
>  arch/arm/mach-omap2/common-board-devices.h         |  5 ++
>  arch/arm/mach-omap2/common.h                       | 10 +---
>  arch/arm/mach-omap2/pdata-quirks.c                 |  2 +
>  drivers/irqchip/Kconfig                            |  5 ++
>  drivers/irqchip/Makefile                           |  1 +
>  .../irq.c => drivers/irqchip/irq-omap-intc.c       | 64 +++++++++++++---------
>  include/linux/irqchip/irq-omap-intc.h              | 32 +++++++++++
>  12 files changed, 101 insertions(+), 61 deletions(-)
>  rename arch/arm/mach-omap2/irq.c => drivers/irqchip/irq-omap-intc.c (89%)
>  create mode 100644 include/linux/irqchip/irq-omap-intc.h
> 

Pulled into next/drivers, thanks!

	Arnd
