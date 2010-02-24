From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [PATCH] omap2/3/4: serial: Don't init UART4 for 3630 still
Date: Wed, 24 Feb 2010 05:24:03 -0600
Message-ID: <A24693684029E5489D1D202277BE8944538C6D8E@dlee02.ent.ti.com>
References: <1267002144-21944-1-git-send-email-saaguirre@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48054 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756744Ab0BXLYI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Feb 2010 06:24:08 -0500
In-Reply-To: <1267002144-21944-1-git-send-email-saaguirre@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre, Sergio" <saaguirre@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>, "Sonasath, Moiz" <m-sonasath@ti.com>


> -----Original Message-----
> From: Aguirre, Sergio
> Sent: Wednesday, February 24, 2010 3:02 AM
> To: Tony Lindgren
> Cc: linux-omap@vger.kernel.org; Pandita, Vikram; Sonasath, Moiz; Aguirre,
> Sergio
> Subject: [PATCH] omap2/3/4: serial: Don't init UART4 for 3630 still
> 
> The patch named:
>   "omap2/3/4: Fix mach-omap2/serial.c for multiboot"
> 
> Which added UART4 init also for 36xx based boards, broke zoom3
> booting.
> 
> In theory, for zoom3 case, we should have UART4 + external debugboard
> UART running with no issues. But unless the real issue is fixed,
> this patch is crucial for Zoom3 booting.

Just FYI,

I tried by changing id field in board-zoom-debugboard.c for external UART to -1, which in theory would add a ttyS4, but somehow it didn't worked for me...

I guess the proper fix will be to have:

ttyS0 - OMAP3_UART1
ttyS1 - OMAP3_UART2
ttyS2 - OMAP3_UART3
ttyS3 - OMAP3_UART4
ttyS4 - ZOOM_UART

Any Zoom debugboard expert that wants to comment on this?

Regards,
Sergio

> 
> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> ---
>  arch/arm/mach-omap2/serial.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index b79bc89..c4a810b 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -764,7 +764,7 @@ void __init omap_serial_init(void)
>  {
>  	int i, nr_ports;
> 
> -	if (!(cpu_is_omap3630() || cpu_is_omap4430()))
> +	if (!cpu_is_omap4430())
>  		nr_ports = 3;
>  	else
>  		nr_ports = ARRAY_SIZE(omap_uart);
> --
> 1.6.3.3

