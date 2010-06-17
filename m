From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [pm-wip/uart][PATCH 5/5 v2] Serial: Avoid using hwmod lookup using  name string
Date: Thu, 17 Jun 2010 14:33:30 -0700
Message-ID: <87631hl4yd.fsf@deeprootsystems.com>
References: <2335.10.24.255.18.1276697669.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:58777 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757568Ab0FQVdd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jun 2010 17:33:33 -0400
Received: by pxi12 with SMTP id 12so157825pxi.19
        for <linux-omap@vger.kernel.org>; Thu, 17 Jun 2010 14:33:33 -0700 (PDT)
In-Reply-To: <2335.10.24.255.18.1276697669.squirrel@dbdmail.itg.ti.com> (Govindraj R.'s message of "Wed\, 16 Jun 2010 19\:44\:29 +0530 \(IST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> Avoid using hwmod lookup using name string rather
> retreive port info using the hwmod class interface.
>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>

Govindraj,

I quite like this change, but am still having problems applying it.  I
think it's because of some whitespace differences between our trees.

I manually applied this to do some testing, but can you look into 
what is going on here?  Some thoughts on what is going on below...

> ---
>  arch/arm/mach-omap2/serial.c |   71 ++++++++++++++++++-----------------------
>  1 files changed, 31 insertions(+), 40 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 128e19b..0380ac8 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -56,8 +56,6 @@
>   */
>  #define DEFAULT_TIMEOUT 0
>
> -#define MAX_UART_HWMOD_NAME_LEN		16
> -
>  struct omap_uart_state {
>  	int num;
>  	int can_sleep;
> @@ -601,52 +599,45 @@ static void serial_out_override(struct uart_port *up, int offset, int value)
>  }
>  #endif
>
> -void __init omap_serial_early_init(void)
> +static int omap_serial_port_init(struct omap_hwmod *oh, void *user)
>  {
> -	int i = 0;
> +	struct omap_uart_state *uart;
> +	static int i;
>
> -	do {
> -		char oh_name[MAX_UART_HWMOD_NAME_LEN];
> -		struct omap_hwmod *oh;
> -		struct omap_uart_state *uart;
> +	uart = kzalloc(sizeof(struct omap_uart_state), GFP_KERNEL);
> +	if (WARN_ON(!uart))
> +		return -ENOMEM;
>
> -		snprintf(oh_name, MAX_UART_HWMOD_NAME_LEN,
> -			 "uart%d", i + 1);
> -		oh = omap_hwmod_lookup(oh_name);
> -		if (!oh)
> -			break;
> +	uart->oh = oh;
> +	uart->num = i++;
> +	list_add_tail(&uart->node, &uart_list);
> +	num_uarts++;
>

For some reason, all the empty lines that are part of this patch are
missing the leading space.  In a diff, the place where the '+' or '-'
would go on these empty lines normally has a space so that all the lines
are similarily indented.

All of the blank lines in this patch are similarily affected, resulting in
a patch that doesn't apply cleanly.

So you can see what I mean, I've attached a diff that I generated
after manually applying this patch.  If you do a diff between your
patch and the attached patch (using a tool that shows whitespace
differences) you'll see what I mean.

Kevin

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index da9fee6..d22fca1 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -568,52 +568,45 @@ static void serial_out_override(struct uart_port *up, int offset, int value)
 }
 #endif
 
-void __init omap_serial_early_init(void)
+static int omap_serial_port_init(struct omap_hwmod *oh, void *user)
 {
-	int i = 0;
+	struct omap_uart_state *uart;
+	static int i;
 
-	do {
-		char oh_name[MAX_UART_HWMOD_NAME_LEN];
-		struct omap_hwmod *oh;
-		struct omap_uart_state *uart;
+	uart = kzalloc(sizeof(struct omap_uart_state), GFP_KERNEL);
+	if (WARN_ON(!uart))
+		return -ENOMEM;
 
-		snprintf(oh_name, MAX_UART_HWMOD_NAME_LEN,
-			 "uart%d", i + 1);
-		oh = omap_hwmod_lookup(oh_name);
-		if (!oh)
-			break;
+	uart->oh = oh;
+	uart->num = i++;
+	list_add_tail(&uart->node, &uart_list);
+	num_uarts++;
 
-		uart = kzalloc(sizeof(struct omap_uart_state), GFP_KERNEL);
-		if (WARN_ON(!uart))
-			return;
+	/*
+	 * During UART early init, device need to be probed
+	 * to determine SoC specific init before omap_device
+	 * is ready.  Therefore, don't allow idle here
+	 */
 
-		uart->oh = oh;
-		uart->num = i++;
-		list_add_tail(&uart->node, &uart_list);
-		num_uarts++;
+	uart->oh->flags |= HWMOD_INIT_NO_IDLE;
 
-		/* 
-		 * NOTE: omap_hwmod_init() has not yet been called,
-		 *       so no hwmod functions will work yet.
-		 */
+	/*
+	 * Since UART hwmod is idle/enabled inside the
+	 * idle loop, interrupts are already disabled and
+	 * thus no locking is needed.  Since the mutex-based
+	 * locking in hwmod might sleep, allowing locking
+	 * may introduce problems.
+	 */
 
-		/* 
-		 * During UART early init, device need to be probed
-		 * to determine SoC specific init before omap_device
-		 * is ready.  Therefore, don't allow idle here
-		 */
-		uart->oh->flags |= HWMOD_INIT_NO_IDLE;
-
-		/* 
-		 * Since UART hwmod is idle/enabled inside the
-		 * idle loop, interrupts are already disabled and
-		 * thus no locking is needed.  Since the mutex-based
-		 * locking in hwmod might sleep, allowing locking
-		 * may introduce problems.
-		 */
-		uart->oh->flags |= HWMOD_NO_IDLE_LOCKING;
+	uart->oh->flags |= HWMOD_NO_IDLE_LOCKING;
 
-	} while (1);
+	return 0;
+}
+
+void __init omap_serial_early_init(void)
+{
+	omap_hwmod_for_each_by_class("uart",
+		omap_serial_port_init, NULL);
 }
 
 /**
