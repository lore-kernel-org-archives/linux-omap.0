From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH 1/11] Add VFP support for ARM V7 - OMAP 3430 support
Date: Tue, 29 May 2007 12:09:33 +0530
Message-ID: <5d5443650705282339i479d448fm7c4910d971ae0cad@mail.gmail.com>
References: <9C23CDD79DA20A479D4615857B2E2C47FF0E2D@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47FF0E2D@dlee13.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On 5/29/07, Syed Mohammed, Khasim <x0khasim@ti.com> wrote:
>
> Add VFP support for ARM V7, derived from ARM's Cortex patch
>
> Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>
>
> Files Changed:
>  Kconfig         |   16 ++++++++++++++--
>  vfp/vfp.h       |    5 +++++
>  vfp/vfphw.S     |   21 ++++++++++++++++++++-
>  vfp/vfpmodule.c |    8 ++++++++
>  4 files changed, 47 insertions(+), 3 deletions(-)
>
> =======================================================================
> diff -purN linux-omap/arch/arm/Kconfig val_3430_GIT/arch/arm/Kconfig
> --- linux-omap/arch/arm/Kconfig 2007-05-25 13:27:02.000000000 -0500
> +++ val_3430_GIT/arch/arm/Kconfig       2007-05-25 23:05:30.000000000 -0500
> @@ -393,7 +393,7 @@ config ARCH_OMAP
>         select GENERIC_TIME
>         select GENERIC_CLOCKEVENTS
>         help
> -         Support for TI's OMAP platform (OMAP1 and OMAP2).
> +         Support for TI's OMAP platform (OMAP1, OMAP2 and OMAP3).
>
>  endchoice
>
> @@ -925,7 +925,7 @@ config FPE_FASTFPE
>
>  config VFP
>         bool "VFP-format floating point maths"
> -       depends on CPU_V6 || CPU_ARM926T
> +       depends on CPU_V6 || CPU_ARM926T || CPU_V7
>         help
>           Say Y to include VFP support code in the kernel. This is needed
>           if your hardware includes a VFP unit.
> @@ -935,6 +935,18 @@ config VFP
>
>           Say N if your target does not have VFP hardware.
>
> +config VFPv3
> +       bool
> +       depends on VFP
> +       default y if CPU_V7
> +

Could you please check that ARMv7 and VFPv3 code is latest and same as
available on http://www.linux-arm.og/git ?

Catalin seems to update this tree with his new patches and better than
taking patch from arm.com/linux .

-- 
--Trilok Soni
