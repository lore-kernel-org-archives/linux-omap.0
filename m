From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH] omap-serial: Allow IXON and IXOFF to be disabled.
Date: Fri, 15 Jul 2011 11:07:10 +0530
Message-ID: <CAAL8m4zQkOqdy0J4wKTR-OQWZDFsfBkDgJmhwhr9DPGmDQ+kBA@mail.gmail.com>
References: <1310669360-752-1-git-send-email-npelly@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:52600 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755182Ab1GOFhb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jul 2011 01:37:31 -0400
Received: by fxd18 with SMTP id 18so2227921fxd.11
        for <linux-omap@vger.kernel.org>; Thu, 14 Jul 2011 22:37:30 -0700 (PDT)
In-Reply-To: <1310669360-752-1-git-send-email-npelly@google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nick Pelly <npelly@google.com>
Cc: linux-omap@vger.kernel.org

On Fri, Jul 15, 2011 at 12:19 AM, Nick Pelly <npelly@google.com> wrote:
> Fixes logic bug that software flow control cannot be disabled, becaus=
e
> serial_omap_configure_xonxoff() is not called if both IXON and IXOFF =
bits
> are cleared.
>

Thanks, Good Point.

need to send to this patch to linux-serial@vger.kernel.org,
CC'ing "Greg Kroah-Hartman <gregkh@suse.de>"

will be merged through tty tree.

feel free to add

Acked-by: Govindraj.R <govindraj.raja@ti.com>
Tested-by: Govindraj.R <govindraj.raja@ti.com>

--
Thanks,
Govindraj.R

> Signed-off-by: Nick Pelly <npelly@google.com>
> ---
> =A0drivers/tty/serial/omap-serial.c | =A0 =A03 +--
> =A01 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/om=
ap-serial.c
> index 47cadf4..6d3ec14 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -806,8 +806,7 @@ serial_omap_set_termios(struct uart_port *port, s=
truct ktermios *termios,
>
> =A0 =A0 =A0 =A0serial_omap_set_mctrl(&up->port, up->port.mctrl);
> =A0 =A0 =A0 =A0/* Software Flow Control Configuration */
> - =A0 =A0 =A0 if (termios->c_iflag & (IXON | IXOFF))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_configure_xonxoff(up, termi=
os);
> + =A0 =A0 =A0 serial_omap_configure_xonxoff(up, termios);
>
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&up->port.lock, flags);
> =A0 =A0 =A0 =A0dev_dbg(up->port.dev, "serial_omap_set_termios+%d\n", =
up->pdev->id);
> --
> 1.7.5.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
