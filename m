From: Alexey Pelykh <alexey.pelykh@gmail.com>
Subject: Re: [PATCH] Revert "OMAP/serial: Fix incorrect Rx FIFO threshold
 setting, LSR validation on Tx, and Tx FIFO IRQ generation"
Date: Mon, 1 Apr 2013 11:31:40 +0300
Message-ID: <CAOmKuSpttQJmrL=Htiz-Zc4voAF7CnG_GQYAO2onKpauwYjtvw@mail.gmail.com>
References: <alpine.DEB.2.00.1304010519260.28273@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1304010519260.28273@utopia.booyaka.com>
Sender: linux-serial-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Actually, I've tested my patch on DM3730, and, at least, can prove
that original settings of UART are incorrect according to TRM of
processor. What settings of UART you were using to reproduce issue?
I'd like to kindly ask you to describe your test environment, since
I've never experiences issues that you've described nor in debug
console, nor in regular UART usage.

On Mon, Apr 1, 2013 at 8:25 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> This reverts commit 1776fd059c40907297d6c26c51876575d63fd9e2.
>
> Commit 1776fd059c40 causes UART sluggishness on the OMAP37xx EVM.
> This can be demonstrated by pasting in a ten-character string, like
> "ffffffffff", at the serial console.  The string will be echoed back
> two to three characters at a time, with about a one-second pause
> between groups.  This causes one of the OMAP PM validation tests to
> time out:
>
> http://www.pwsan.com/omap/testlogs/test_v3.9-rc5/20130331205513/pm/37xxevm/37xxevm_log.txt
>
> With commit 1776fd059c40 reverted, the test succeeds:
>
> http://www.pwsan.com/omap/testlogs/serial_fix_37xx_v3.9-rc/20130331230517/pm/37xxevm/37xxevm_log.txt
>
> This problem has been present since v3.9-rc1, but was incorrectly
> suspected to be due to commit 6aa9707099c4b25700940eb3d016f16c4434360d
> ("lockdep: check that no locks held at freeze time"), due to limitations
> in my local testbed.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Alexey Pelykh <alexey.pelykh@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>
> Alexey, care to make another attempt for 3.11 at fixing the issue you were
> originally debugging, but one that also works on OMAP37xx EVM?  It would
> be good to cc the <linux-omap@vger.kernel.org> on your OMAP work.  If you
> don't have a 37xx EVM, someone there might be able to help you test.
>
>  drivers/tty/serial/omap-serial.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index 4dc4140..9915e4d 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -59,7 +59,6 @@
>
>  /* SCR register bitmasks */
>  #define OMAP_UART_SCR_RX_TRIG_GRANU1_MASK              (1 << 7)
> -#define OMAP_UART_SCR_TX_TRIG_GRANU1_MASK              (1 << 6)
>  #define OMAP_UART_SCR_TX_EMPTY                 (1 << 3)
>
>  /* FCR register bitmasks */
> @@ -321,6 +320,9 @@ static void transmit_chars(struct uart_omap_port *up, unsigned int lsr)
>         struct circ_buf *xmit = &up->port.state->xmit;
>         int count;
>
> +       if (!(lsr & UART_LSR_THRE))
> +               return;
> +
>         if (up->port.x_char) {
>                 serial_out(up, UART_TX, up->port.x_char);
>                 up->port.icount.tx++;
> @@ -862,7 +864,7 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
>         serial_out(up, UART_IER, up->ier);
>         serial_out(up, UART_LCR, cval);         /* reset DLAB */
>         up->lcr = cval;
> -       up->scr = 0;
> +       up->scr = OMAP_UART_SCR_TX_EMPTY;
>
>         /* FIFOs and DMA Settings */
>
> @@ -886,6 +888,8 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
>         serial_out(up, UART_MCR, up->mcr | UART_MCR_TCRTLR);
>         /* FIFO ENABLE, DMA MODE */
>
> +       up->scr |= OMAP_UART_SCR_RX_TRIG_GRANU1_MASK;
> +
>         /* Set receive FIFO threshold to 16 characters and
>          * transmit FIFO threshold to 16 spaces
>          */
> --
> 1.7.10.4
>
