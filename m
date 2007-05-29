From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 8/11] Compiling dsp-common if DSP is enabled.
Date: Tue, 29 May 2007 09:55:28 -0700
Message-ID: <20070529165528.GC26322@atomide.com>
References: <9C23CDD79DA20A479D4615857B2E2C47FF0E34@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47FF0E34@dlee13.ent.ti.com>
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

* Syed Mohammed, Khasim <x0khasim@ti.com> [070528 23:22]:
> 
> Compile dsp_common only if DSP is enabled.
> 
> Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>
> 
> Files Changed:
>  Makefile |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> =======================================================================
> diff -purN linux-omap/arch/arm/plat-omap/dsp/Makefile val_3430_GIT/arch/arm/plat-omap/dsp/Makefile
> --- linux-omap/arch/arm/plat-omap/dsp/Makefile	2006-11-20 21:54:05.000000000 -0600
> +++ val_3430_GIT/arch/arm/plat-omap/dsp/Makefile	2007-05-28 13:30:09.000000000 -0500
> @@ -4,7 +4,7 @@
>  
>  # The target object and module list name.
>  
> -obj-y := dsp_common.o
> +obj-$(CONFIG_OMAP_DSP) := dsp_common.o
>  
>  obj-$(CONFIG_OMAP_DSP) += dsp.o

We should compile DSP for omap1 (and aybe 24xx?) to keep
audio McBSP clock functioning. And eventually we should have common
dsp init that works for all of them.

What if you just add an early return to dsp init code for now with
a revisit comment?

Regards,

Tony
