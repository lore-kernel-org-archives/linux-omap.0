From: Ville Tervo <ville.tervo@nokia.com>
Subject: Re: [PATCH] serial: Add driver for OMAP UARTs
Date: Tue, 10 Apr 2007 15:28:10 +0300
Message-ID: <20070410122810.GF2841@null.research.nokia.com>
References: <20070409204433.GA23320@mail.solidboot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070409204433.GA23320@mail.solidboot.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Juha,

Some reviewing and testing done. Some comments.

> +	/* Reset the UART */
> +	serial_out(up, UART_OMAP_MDR1, 0x07);
> +	udelay(50);
> +	serial_out(up, UART_OMAP_MDR1, 0x00);

I think that this doesn't really reset UART. And the result is some
garbage coming from serial port after opening it.

serial_out(up, UART_OMAP_SYSC, 0x02);
udelay(50);

should be used instead?


> +	if (co->index == -1 || co->index >= serial_omap_reg.nr ||
> +	    serial_omap_console_ports[co->index] == NULL)
> +		co->index = 0;

I don't understand what is point in this code but following observation.
Kernel hits null pointer if this code is in and multible ports are
enabled from bootloader.

Without this code multible ports work fine.

-- 
Ville
