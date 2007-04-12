From: "George G. Davis" <gdavis@mvista.com>
Subject: Re: [PATCH] serial: Add driver for OMAP UARTs
Date: Thu, 12 Apr 2007 09:37:10 -0400
Message-ID: <20070412133710.GA9104@mvista.com>
References: <20070409204433.GA23320@mail.solidboot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070409204433.GA23320@mail.solidboot.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Juha =?iso-8859-1?B?WXJq9mzk?= <juha.yrjola@solidboot.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 09, 2007 at 11:44:33PM +0300, Juha Yrj=F6l=E4 wrote:
> --- /dev/null
> +++ b/drivers/serial/omap.c
> @@ -0,0 +1,893 @@


> +static int serial_omap_startup(struct uart_port *port)
> +{
> +	struct uart_omap_port *up =3D (struct uart_omap_port *)port;
> +	unsigned long flags;
> +	int retval;
> +
> +	enable_uart_clocks(up);
> +
> +	/*
> +	 * Allocate the IRQ
> +	 */
> +	retval =3D request_irq(up->port.irq, serial_omap_irq, 0, up->name, up=
);
> +	if (retval) {
> +		disable_uart_clocks(up);
> +		return retval;
> +	}
> +


> +}
> +
> +static void serial_omap_shutdown(struct uart_port *port)
> +{


> +	disable_uart_clocks(up);
> +
> +	clk_put(up->fclk);
> +	if (up->iclk !=3D NULL)
> +		clk_put(up->iclk);
> +}


You should probably move {enable,disable}_uart_clocks() calls into the
uart_ops .pm function, serial_omap_pm() (which is currently a stub : ),
assuming clocks can be controlled per serial port.  In fact, if clocks
are controlled per serial port, then you may discover problems if you
do not move clock handling into the .pm function, e.g. try this when
one or more serial ports are not in use:

	cat /proc/tty/serial

If one or more serial ports are disabled, results should be garbage and
or the system may hang depending on behavior when serial port clocks
are disabled.  I expect you will need to s/serial/OMAP serial/ in the
above example but more on that below.


> +struct uart_ops serial_omap_pops =3D {
> +	.tx_empty	=3D serial_omap_tx_empty,
> +	.set_mctrl	=3D serial_omap_set_mctrl,
> +	.get_mctrl	=3D serial_omap_get_mctrl,
> +	.stop_tx	=3D serial_omap_stop_tx,
> +	.start_tx	=3D serial_omap_start_tx,
> +	.stop_rx	=3D serial_omap_stop_rx,
> +	.enable_ms	=3D serial_omap_enable_ms,
> +	.break_ctl	=3D serial_omap_break_ctl,
> +	.startup	=3D serial_omap_startup,
> +	.shutdown	=3D serial_omap_shutdown,
> +	.set_termios	=3D serial_omap_set_termios,
> +	.pm		=3D serial_omap_pm,
> +	.type		=3D serial_omap_type,
> +	.release_port	=3D serial_omap_release_port,
> +	.request_port	=3D serial_omap_request_port,
> +	.config_port	=3D serial_omap_config_port,
> +	.verify_port	=3D serial_omap_verify_port,
> +};
> +
> +static struct uart_driver serial_omap_reg =3D {
> +	.owner		=3D THIS_MODULE,
> +	.driver_name	=3D "OMAP serial",

You may want to reconsider ".driver_name" otherwise I suspect this may
appear as:

	"/proc/tty/driver/OMAP serial"

Yuck.  : )

> +	.dev_name	=3D "ttyS",
> +	.major		=3D TTY_MAJOR,
> +	.minor		=3D 64,
> +	.nr		=3D 3,
> +	.cons		=3D OMAP_CONSOLE,
> +};

--
Regards,
George
