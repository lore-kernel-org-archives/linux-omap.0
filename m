From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH]  H4 / 2430SDP ethernet IRQ flags fix
Date: Thu, 16 Nov 2006 01:25:23 +0200
Message-ID: <20061115232522.GG21064@atomide.com>
References: <77C7F7CB1230A74A9D19C0C111E6EDBE01D91956@DLEE09.ent.ti.com>
	<77C7F7CB1230A74A9D19C0C111E6EDBE01D9199A@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <77C7F7CB1230A74A9D19C0C111E6EDBE01D9199A@DLEE09.ent.ti.com>
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
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

* Syed Mohammed, Khasim <x0khasim@ti.com> [061110 21:42]:
> 
> Hi Tony,
> 
> The attached patch configures the Ethernet IRQ flag on H4 / 2430SDP to
> IRQF_TRIGGER_LOW
> 
> This has been tested and validated on 2430 SDP and H4 board.
> 
> Thanks & Regards,
> Khasim

Content-Description: ethernet_fix_H4_2430.patch
> This patch configures the Ethernet IRQ flag on H4 / 2430SDP to IRQF_TRIGGER_LOW.
> 
> Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>
> 
> Files changed:
>  smc91x.h |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> ==============================================================================
> diff -purN linux-omap/drivers/net/smc91x.h dev-linux-omap-2.6.git/drivers/net/smc91x.h
> --- linux-omap/drivers/net/smc91x.h	2006-11-02 00:16:21.000000000 -0600
> +++ dev-linux-omap-2.6.git/drivers/net/smc91x.h	2006-11-10 13:22:53.000000000 -0600
> @@ -193,11 +193,12 @@ SMC_outw(u16 val, void __iomem *ioaddr, 
>  #include <asm/arch/cpu.h>
>  
>  #define	SMC_IRQ_FLAGS (( \
> -		   machine_is_omap_h2() \
> +		machine_is_omap_h2() \
>  		|| machine_is_omap_h3() \
> -		|| machine_is_omap_h4() \
>  		|| (machine_is_omap_innovator() && !cpu_is_omap1510()) \
> -	) ? IRQF_TRIGGER_FALLING : IRQF_TRIGGER_RISING)
> +		)? IRQF_TRIGGER_FALLING : \
> +		((machine_is_omap_h4() || machine_is_omap_2430sdp())? \
> +		IRQF_TRIGGER_LOW : IRQF_TRIGGER_RISING))
>  
>  
>  #elif	defined(CONFIG_SH_SH4202_MICRODEV)

Well it's getting messy, and now we need to patch it when new machines
are added.

How about something like the following patch? Does the following patch
work for you?

Regards,

Tony

--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch-omap-smc-trigger

smc91x: Clean up omap interrupt level

Since omap1 does not have level GPIO interrupts, all omap1 class
processors should use falling edge, except for Innovator which
routes the interrupt via FPGA and needs rising edge. All omap2
class processors should use low level interrupt.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/drivers/net/smc91x.h
+++ b/drivers/net/smc91x.h
@@ -192,13 +192,12 @@ #define SMC_outsw(a, r, p, l)	writesw((a
 #include <asm/mach-types.h>
 #include <asm/arch/cpu.h>
 
-#define	SMC_IRQ_FLAGS (( \
-		   machine_is_omap_h2() \
-		|| machine_is_omap_h3() \
-		|| machine_is_omap_h4() \
-		|| (machine_is_omap_innovator() && !cpu_is_omap1510()) \
-	) ? IRQF_TRIGGER_FALLING : IRQF_TRIGGER_RISING)
-
+#ifdef CONFIG_ARCH_OMAP1
+#define	SMC_IRQ_FLAGS	(machine_is_omap_innovator() ? IRQF_TRIGGER_RISING : \
+				IRQF_TRIGGER_FALLING)
+#else
+#define SMC_IRQ_FLAGS		IRQF_TRIGGER_LOW
+#endif
 
 #elif	defined(CONFIG_SH_SH4202_MICRODEV)
 

--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--bg08WKrSYDhXBjb5--
