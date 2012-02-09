From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH RFC] OMAP: serial: Remove the hardcode serial_omap_console_ports
 array.
Date: Thu, 9 Feb 2012 19:28:31 +0530
Message-ID: <CAAL8m4yU5KPqO11FY2Rwpuqns+EBtGuAMna0gxcYwK0QZ1fSjA@mail.gmail.com>
References: <1328795296-22935-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:54946 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753780Ab2BIN6w convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Feb 2012 08:58:52 -0500
In-Reply-To: <1328795296-22935-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Govindraj Raja <govindraj.raja@ti.com>

On Thu, Feb 9, 2012 at 7:18 PM, Shubhrajyoti D <shubhrajyoti@ti.com> wr=
ote:
> Currently the array serial_omap_console_ports is hard coded to 4.
> Make it depend on the macro OMAP_MAX_HSUART_PORTS(which is 4) which
> the maximum uart count.
>
> Cc: Govindraj Raja <govindraj.raja@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Acked-by: Govindraj.R <govindraj.raja@ti.com>

> ---
> =A0drivers/tty/serial/omap-serial.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/om=
ap-serial.c
> index 1c24269..c570696 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -1021,7 +1021,7 @@ static int serial_omap_poll_get_char(struct uar=
t_port *port)
>
> =A0#ifdef CONFIG_SERIAL_OMAP_CONSOLE
>
> -static struct uart_omap_port *serial_omap_console_ports[4];
> +static struct uart_omap_port *serial_omap_console_ports[OMAP_MAX_HSU=
ART_PORTS];
>
> =A0static struct uart_driver serial_omap_reg;
>
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-seria=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
