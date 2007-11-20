From: Kevin Hilman <khilman@mvista.com>
Subject: Re: Unhandled fault: external abort
Date: Tue, 20 Nov 2007 08:23:17 -0800
Message-ID: <1195575797.6227.4.camel@vence.hilman.org>
References: <D0D7E940253EF8428A27241F8E3CABA3A88DFA@zeus.Combra.se>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <D0D7E940253EF8428A27241F8E3CABA3A88DFA@zeus.Combra.se>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Carl Benson <Carl.Benson@combra.se>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org


On Tue, 2007-11-20 at 16:37 +0100, Carl Benson wrote:
> Hi. Trying to boot latest OMAP kernel from GIT tree (as of 2007-11-20) on an 3430 SDP ES1.0 board and get an "Unhandled fault: external abort on non-linefetch" and "Internal error 1028". 
> 
> PC is at serial_in+0x6c/0xac which in my kernel suggest the error occuring from executing line 366 from drivers/serial/8250.c:

I have this same problem.

The problem is because the bootloader is not enabling all the clocks
required for UART3 to work on OMAP3.

To get yourself booting, you can just disable the 3rd UART until we fix
this problem.  Try the patch below:

Kevin


Index: 3430-dev/arch/arm/mach-omap2/board-3430sdp.c
===================================================================
--- 3430-dev.orig/arch/arm/mach-omap2/board-3430sdp.c
+++ 3430-dev/arch/arm/mach-omap2/board-3430sdp.c
@@ -301,7 +301,7 @@ static void __init omap_3430sdp_init_irq
 }
 
 static struct omap_uart_config sdp3430_uart_config __initdata = {
-	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
+	.enabled_uarts	= ((1 << 0) | (1 << 1) /* | (1 << 2) */),
 };
 
 static struct omap_board_config_kernel sdp3430_config[] = {
