From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [pm-wip/uart][PATCH] Serial: Avoid populating uart_list in early  init phase
Date: Fri, 25 Jun 2010 09:23:02 -0700
Message-ID: <871vbvt72x.fsf@deeprootsystems.com>
References: <61551.192.168.10.88.1277384156.squirrel@dbdmail.itg.ti.com>
	<87zkykxdqe.fsf@deeprootsystems.com>
	<17901.10.24.255.17.1277473301.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:61935 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605Ab0FYQXH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 12:23:07 -0400
Received: by pvg2 with SMTP id 2so927157pvg.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Jun 2010 09:23:07 -0700 (PDT)
In-Reply-To: <17901.10.24.255.17.1277473301.squirrel@dbdmail.itg.ti.com>
	(Govindraj R.'s message of "Fri, 25 Jun 2010 19:11:41 +0530 (IST)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> Leave the uart_list empty and keep the omap hwmod info
> in a seperate uart_oh list and if board file calls
> serial init use this uart_oh list info to fill uart_list.
> The board file can also call just init_port to initialise
> a single uart instance, so make init_port flexible to handle
> individual uart instance by avoiding filling uart_list
> in any non port_init function.
>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
> As per earlier dicussion:
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg31157.html

Thanks.

Your inline patch is still getting mangled somehow.  It looks like
you're using a webmail client (SquirrelMail) that seems to be altering
the whitespace in the patch.  The attached .zip worked fine.  Please
spend some time figuring out how to use git send-email directly

However, I just discovered another snag...

I did some more testing on Zoom3 and discovered that because we do the
HWMOD_INIT_NO_IDLE, and omap_serial_init[_port] is never called on Zoom3
(since it only uses debug board UART) the UART hwmods are left active 
are never disabled (since they are not used.)  This prevents retention :(

So, here's an idea... (I know, you're growing more and more to not like
my ideas that are going around in circles... sorry about that)

The ultimate goal is fix up all this serial.c hackery by getting your
OMAP serial driver upstream and moving PM handling there, so lets focus
on that instead of continuing to make this hacky layer perfect.

So for now, lets accept that with our current serial.c layer, we have to
always initialize all the UARTs for our PM core to work.  Currently,
Zoom2/3 are the only ones not doing that, so lets just change that until
we get your OMAP serial driver merged.

The patch below does it for Zoom3, can you test and do similar for
Zoom2?  Note that the default console will need to be changed to ttyS4
(Zoom3) and ttyS3 (Zoom2) after this patch.

Thanks,

Kevin

diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
index 1d7f827..9307f58 100644
--- a/arch/arm/mach-omap2/board-zoom-debugboard.c
+++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
@@ -96,7 +96,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 
 static struct platform_device zoom_debugboard_serial_device = {
 	.name			= "serial8250",
-	.id			= PLAT8250_DEV_PLATFORM,
+	.id			= PLAT8250_DEV_PLATFORM + 4,
 	.dev			= {
 		.platform_data	= serial_platform_data,
 	},
diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index 3314704..ff3b144 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -65,6 +65,7 @@ static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 static void __init omap_zoom_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
+	omap_serial_init();
 	zoom_peripherals_init();
 	zoom_debugboard_init();
 
