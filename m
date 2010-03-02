From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [PATCH] OMAP: Zoom3: Fix Zoom3 booting issue
Date: Tue, 2 Mar 2010 10:11:06 -0600
Message-ID: <A24693684029E5489D1D202277BE894453B624B1@dlee02.ent.ti.com>
References: <1267536955-31268-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44178 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753651Ab0CBQLK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Mar 2010 11:11:10 -0500
In-Reply-To: <1267536955-31268-1-git-send-email-manjugk@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, Tony Lindgren <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>

Manju,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Manjunatha GK
> Sent: Tuesday, March 02, 2010 7:36 AM
> To: linux-omap@vger.kernel.org
> Cc: G, Manjunath Kondaiah; Tony Lindgren; Shilimkar, Santosh; Raja,
> Govindraj
> Subject: [PATCH] OMAP: Zoom3: Fix Zoom3 booting issue
> 
> The commit id "5550bc33a1a9002976022cc794fe8c52ad9a0021" seems to be
> broken
> zoom3 boot which adds support for UART4 on OMAP4 and OMAP3630.
> 
> But, it looks like OMAP3630 UART4 interface and functional clock nodes
> needs
> to be added for omap3630. Thus limiting no. of UART's for 3630 to 3 to
> prevent
> boot up issues until clock nodes are added for UART4 on OMAP3630.

I already tried a similar patch here:

http://patchwork.kernel.org/patch/81692/

But as it is really not solving anything, and Tony rejected it, I started working on the needed bits to get UART4 enabled, therefore I have came up with this patch series:

- [RFC v3][PATCH 0/6] OMAP3630: UART4 startup (+ new bugfix!) [1]

Also, I'm working in my spare time on a cleanup proposal [2], which I'll repost today, given some comments from Kevin.

So, if you want to boot, take series [1] and [2], and then you should be able to boot with ttyS0.

Regards,
Sergio

---
[1] http://marc.info/?l=linux-omap&m=126730356232287&w=2
[2] http://marc.info/?l=linux-omap&m=126746974103007&w=2

> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Manjunatha GK <manjugk@ti.com>
> Signed-off-by: Govindraj R <govindraj.raja@ti.com>
> ---
>  arch/arm/mach-omap2/serial.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index b79bc89..ac22a4e 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -764,7 +764,12 @@ void __init omap_serial_init(void)
>  {
>  	int i, nr_ports;
> 
> -	if (!(cpu_is_omap3630() || cpu_is_omap4430()))
> +	/* Limit no.of UART ports to three for OMAP3630 since
> +	 * clock nodes are yet to be updated for 3630 UART4.
> +	 * TODO: update clock nodes for 3630 UART4 and then enable
> +	 * check for !(cpu_is_omap3630())
> +	 */
> +	if (!cpu_is_omap4430())
>  		nr_ports = 3;
>  	else
>  		nr_ports = ARRAY_SIZE(omap_uart);
> --
> 1.6.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
