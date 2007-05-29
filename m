From: Amit Kucheria <amit.kucheria@nokia.com>
Subject: Re: [PATCH 3/11] Add OMAP3 support
Date: Tue, 29 May 2007 14:16:26 +0300
Message-ID: <1180437386.17658.0.camel@amit-laptop>
References: <9C23CDD79DA20A479D4615857B2E2C47FF0E2F@dlee13.ent.ti.com>
Reply-To: amit.kucheria@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47FF0E2F@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "ext Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 2007-05-29 at 01:21 -0500, ext Syed Mohammed, Khasim wrote:
> Add OMAP3 support in arch/arm/Makefile and mm/Kconfig
> 
> Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>
> 
> Files Changed:
>  Makefile   |    1 +
>  mm/Kconfig |    2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> =======================================================================
> diff -purN linux-omap/arch/arm/Makefile val_3430_GIT/arch/arm/Makefile
> --- linux-omap/arch/arm/Makefile	2007-05-16 14:32:39.000000000 -0500
> +++ val_3430_GIT/arch/arm/Makefile	2007-05-25 23:06:30.000000000 -0500
> @@ -121,6 +121,7 @@ endif
>   machine-$(CONFIG_ARCH_IXP23XX)    := ixp23xx
>   machine-$(CONFIG_ARCH_OMAP1)	   := omap1
>   machine-$(CONFIG_ARCH_OMAP2)	   := omap2
> + machine-$(CONFIG_ARCH_OMAP3)		:= omap2
                                             ^^^^^
Surely you mean omap3 here?

/Amit
