From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v2 3/3] tty: serial: omap-serial: wakeup latency
 constraint is in microseconds, not milliseconds
Date: Fri, 27 Jan 2012 12:49:51 +0530
Message-ID: <CAAL8m4xSHTaSFjvHoFcxg3w8cm3M8qibRrhf+NMV2MZVNCt0Nw@mail.gmail.com>
References: <20120126024903.31613.24730.stgit@dusk> <20120126025052.31613.37828.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:39472 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751889Ab2A0HUN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jan 2012 02:20:13 -0500
In-Reply-To: <20120126025052.31613.37828.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, "Govindraj.R" <govindraj.raja@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Alan Cox <alan@linux.intel.com>

On Thu, Jan 26, 2012 at 8:20 AM, Paul Walmsley <paul@pwsan.com> wrote:
> The receive FIFO wakeup latency estimate in the omap-serial driver is
> three orders of magnitude too small. =A0This effectively prevents the
> MPU from going to a low-power state when CONFIG_CPU_IDLE=3Dy. =A0This=
 is a
> major power management regression and masks some other FIFO-related
> bugs in the driver.
>
> Fix by correcting the most egregious problem in the RX wakeup latency
> estimate. =A0There are several other flaws in the estimator; these wi=
ll
> be fixed by a separate patch series intended for 3.4.
>
> The difference in low-power states with this patch can be observed vi=
a
> debugfs in pm_debug/count.
>
> This estimate does not have any effect when CONFIG_CPU_IDLE=3Dn.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Govindraj.R <govindraj.raja@ti.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Alan Cox <alan@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>

Acked-by: Govindraj.R <govindraj.raja@ti.com>

> ---
> =A0drivers/tty/serial/omap-serial.c | =A0 =A03 +--
> =A01 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/om=
ap-serial.c
> index 11fa156..72fa783 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -740,8 +740,7 @@ serial_omap_set_termios(struct uart_port *port, s=
truct ktermios *termios,
> =A0 =A0 =A0 =A0quot =3D serial_omap_get_divisor(port, baud);
>
> =A0 =A0 =A0 =A0/* calculate wakeup latency constraint */
> - =A0 =A0 =A0 up->calc_latency =3D (1000000 * up->port.fifosize) /
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1000 *=
 baud / 8);
> + =A0 =A0 =A0 up->calc_latency =3D (USEC_PER_SEC * up->port.fifosize)=
 / (baud / 8);
> =A0 =A0 =A0 =A0up->latency =3D up->calc_latency;
> =A0 =A0 =A0 =A0schedule_work(&up->qos_work);
>
>
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
