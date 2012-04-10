From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v3 4/9] ARM: OMAP2+: gpmc-nand: populate gpmc configs
Date: Tue, 10 Apr 2012 14:24:58 -0500
Message-ID: <4F84890A.30500@ti.com>
References: <cover.1333640054.git.afzal@ti.com> <6c120ab77d0900a6f977246bc58fb37c62280371.1333640054.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6c120ab77d0900a6f977246bc58fb37c62280371.1333640054.git.afzal@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: tony@atomide.com, khilman@ti.com, linux@arm.linux.org.uk, dwmw2@infradead.org, sameo@linux.intel.com, grinberg@compulab.co.il, mike@compulab.co.il, nm@ti.com, artem.bityutskiy@linux.intel.com, vimal.newwork@gmail.com, dbaryshkov@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Afzal,

On 04/05/2012 10:46 AM, Afzal Mohammed wrote:
> Currently gpmc is configured in platform for nand.
> As configuring gpmc has been moved to gpmc driver,
> populate details needed for the driver to configure
> gpmc. gpmc driver would configure based on this
> information.
>
> Signed-off-by: Afzal Mohammed<afzal@ti.com>
> ---
>   arch/arm/mach-omap2/gpmc-nand.c        |   97 ++++++++++++++------------------
>   arch/arm/plat-omap/include/plat/nand.h |    8 ++-
>   2 files changed, 48 insertions(+), 57 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
> index 386dec8..85de31f 100644
> --- a/arch/arm/mach-omap2/gpmc-nand.c
> +++ b/arch/arm/mach-omap2/gpmc-nand.c
> @@ -21,24 +21,38 @@
>   #include<plat/board.h>
>   #include<plat/gpmc.h>
>
> -static struct resource gpmc_nand_resource = {
> -	.flags		= IORESOURCE_MEM,
> +
> +#define	GPMC_NAND_CONFIG_NUM	4

Where does 4 come from?

Jon
