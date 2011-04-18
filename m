From: =?iso-8859-1?Q?=22Ander=F6=2C_Oskar=22?= <Oskar.Andero@sonyericsson.com>
Subject: RE: [PATCH] arm: omap2: enable smc instruction for sleep34xx
Date: Mon, 18 Apr 2011 17:51:29 +0200
Message-ID: <00D61D20F3A8774CBC77798B3FBC427082058F986D@seldmbx02.corpusers.net>
References: <1301581164-26538-1-git-send-email-oskar.andero@sonyericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1301581164-26538-1-git-send-email-oskar.andero@sonyericsson.com>
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
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "'linux@arm.linux.org.uk'" <linux@arm.linux.org.uk>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

(+ some extra CC's)

> Subject: [PATCH] arm: omap2: enable smc instruction for sleep34xx
> 
> This fixes broken build when using gcc 4.5.
> 
> Signed-off-by: Oskar Andero <oskar.andero@sonyericsson.com>
> ---
>  arch/arm/mach-omap2/Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-
> omap2/Makefile
> index a45cd64..512b152 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -68,7 +68,7 @@ obj-$(CONFIG_OMAP_SMARTREFLEX)          +=
> sr_device.o smartreflex.o
>  obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+= smartreflex-class3.o
> 
>  AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
> -AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a
> +AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-
> a$(plus_sec)
> 
>  ifeq ($(CONFIG_PM_VERBOSE),y)
>  CFLAGS_pm_bus.o				+= -DDEBUG
> --
> 1.7.3.4
Ping!

Anyone else that gets bitten by the following when compiling omap2plus_defconfig with gcc 4.5:
arch/arm/mach-omap2/sleep34xx.S:150: Error: selected processor does not support ARM mode `smc #1'

-Oskar
