From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 4/5] OMAP: Zoom2: Fix serial break
Date: Sat, 22 Aug 2009 16:46:22 +0200
Message-ID: <87ocq7vrcx.fsf@deeprootsystems.com>
References: <1250878266-10632-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:12327 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755252AbZHVOqY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 Aug 2009 10:46:24 -0400
Received: by ey-out-2122.google.com with SMTP id 22so352206eye.37
        for <linux-omap@vger.kernel.org>; Sat, 22 Aug 2009 07:46:25 -0700 (PDT)
In-Reply-To: <1250878266-10632-1-git-send-email-vikram.pandita@ti.com> (Vikram Pandita's message of "Fri\, 21 Aug 2009 13\:11\:06 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

Vikram Pandita <vikram.pandita@ti.com> writes:

> Fix the break in Zoom2 Quad uart debug port support.
>
> Patch by Kevin Hilman fd455ea899b5a14 caused a break as it introuduced
> per port PLATFORM id and Zoom2 was not tested with this change.

...because working zoom2 UART support was not yet upstream.

> For Zoom2 serial port, add platform id as 4
>
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> cc: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/board-zoom-debugboard.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
> index f8b0726..4dd714d 100644
> --- a/arch/arm/mach-omap2/board-zoom-debugboard.c
> +++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
> @@ -97,7 +97,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
>  
>  static struct platform_device zoom2_debugboard_serial_device = {
>  	.name			= "serial8250",
> -	.id			= PLAT8250_DEV_PLATFORM1,
> +	.id			= PLAT8250_DEV_FOURPORT,

Using FOURPORT isn't right either.  Just use a number.

If you're OK with the version below, I'll pull it into my fixes queue.
I've also updated the changelog to explain the problem instead of just
"fix the break..."  This fix messages are not useful when looking back
through the changelog history.

I don't currently have access to a Zoom2, so this has not been tested.

Kevin


commit c52bc1989540d1305aa5372a73bc6096636c8432
Author: Vikram Pandita <vikram.pandita@ti.com>
Date:   Fri Aug 21 13:11:06 2009 -0500

    OMAP: Zoom2: update serial platform_data id for external UART
    
    Now that on-chip UARTs each have separate platform_data, the external
    UART needs an non-conflicting ID.  Since there are 3 on-chip UARTs,
    the Zoom2 external UART will be registered after as the fourth.
    
    Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
    Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
index bac5c43..66fe940 100644
--- a/arch/arm/mach-omap2/board-zoom-debugboard.c
+++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
@@ -94,7 +94,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 
 static struct platform_device zoom2_debugboard_serial_device = {
 	.name			= "serial8250",
-	.id			= PLAT8250_DEV_PLATFORM1,
+	.id			= 3,
 	.dev			= {
 		.platform_data	= serial_platform_data,
 	},
