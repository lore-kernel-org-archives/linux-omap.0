From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] - onenand - OMAP3 support - Kconfig update
Date: Mon, 19 Nov 2007 06:39:40 -0600
Message-ID: <fdc276aa7637f6efc0edd5aa15e1d0c4@felipebalbi.com>
References: <00c601c82aa7$faf8e620$ec8818ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <00c601c82aa7$faf8e620$ec8818ac@ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Sameer <x0081444@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, 19 Nov 2007 18:00:32 +0530, "Sameer" <x0081444@ti.com> wrote:
> Hi,
> This patch enables the onenand Kconfig for OMAP3.
> 
> Regards,
> -Sameer
> 
> Signed-off-by: Sameer <sameersu@ti.com>
> ---
>  drivers/mtd/onenand/Kconfig |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> Index: linux-omap-git/drivers/mtd/onenand/Kconfig
> ===================================================================
> --- linux-omap-git.orig/drivers/mtd/onenand/Kconfig
> +++ linux-omap-git/drivers/mtd/onenand/Kconfig
> @@ -28,10 +28,10 @@ config MTD_ONENAND_GENERIC
>           Support for OneNAND flash via platform device driver.
> 
>  config MTD_ONENAND_OMAP2
> -       tristate "OneNAND on OMAP2 support"
> -       depends on MTD_ONENAND && ARCH_OMAP2
> +       tristate "OneNAND on OMAP2/OMAP3 support"
> +       depends on MTD_ONENAND && (ARCH_OMAP2 || ARCH_OMAP3)
>         help
> -         Support for a OneNAND flash device connected to an OMAP2 CPU
> +         Support for a OneNAND flash device connected to an OMAP2/OMAP3
> CPU
>           via the GPMC memory controller.
> 

It looks good to me and I can say it's working although maybe Tony or any
body else
can comment better on it.

In any case I ack this patch as it's working for me ;-)

> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com
