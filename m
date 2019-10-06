From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH] serial: 8250_omap: Fix gpio check for auto RTS and CTS
Date: Sun, 6 Oct 2019 13:21:03 +0200
Message-ID: <CAGm1_ksBaEN0OWR+dTwT9SgoybtnchcCKasjXf5ybP2fZfRF7A@mail.gmail.com>
References: <20191006023254.23841-1-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191006023254.23841-1-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: linux-serial@vger.kernel.org, adam.ford@logicpd.com, Linux-OMAP <linux-omap@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Vignesh R <vigneshr@ti.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Douglas Anderson <dianders@chromium.org>, kernel list <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Nuno_Gon=C3=A7alves?= <nunojpg@gmail.com>, Giulio Benetti <giulio.benetti@benettiengineering.com>, Stefan Roese <sr@denx.de>
List-Id: linux-omap@vger.kernel.org

Hi Adam,

On Sun, Oct 6, 2019 at 4:33 AM Adam Ford <aford173@gmail.com> wrote:
>
> There are two checks to see if the manual gpio is configured, but
> these the check is seeing if the structure is NULL instead it
> should check to see if there are CTS and/or RTS pins defined.
>
> This patch uses checks for those individual pins instead of
> checking for the structure itself.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
>
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index c68e2b3a1634..836e736ae188 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -141,7 +141,7 @@ static void omap8250_set_mctrl(struct uart_port *port, unsigned int mctrl)
>
>         serial8250_do_set_mctrl(port, mctrl);
>
> -       if (!up->gpios) {
> +       if (!mctrl_gpio_to_gpiod(up->gpios, UART_GPIO_RTS)) {
>                 /*
>                  * Turn off autoRTS if RTS is lowered and restore autoRTS
>                  * setting if RTS is raised
> @@ -456,7 +456,8 @@ static void omap_8250_set_termios(struct uart_port *port,
>         up->port.status &= ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS | UPSTAT_AUTOXOFF);
>
>         if (termios->c_cflag & CRTSCTS && up->port.flags & UPF_HARD_FLOW &&
> -           !up->gpios) {
> +           !mctrl_gpio_to_gpiod(up->gpios, UART_GPIO_RTS) &&
> +           !mctrl_gpio_to_gpiod(up->gpios, UART_GPIO_CTS)) {
>                 /* Enable AUTOCTS (autoRTS is enabled when RTS is raised) */
>                 up->port.status |= UPSTAT_AUTOCTS | UPSTAT_AUTORTS;
>                 priv->efr |= UART_EFR_CTS;

Looks good to me but !up->gpios must remain as otherwise, we will get
NULL pointer dereference. What do you think?

Also adding some more people who can be interested in testing this approach.

Cheers,
Yegor
