From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCHv3] OMAP: Enable Magic SysRq on serial console ttyOx
Date: Fri, 21 Jan 2011 15:42:57 +0530
Message-ID: <AANLkTikSznkcNwkVaPswx=zr8FFGQPVMw_AebF9ymZLE@mail.gmail.com>
References: <1295604084-27761-1-git-send-email-weber@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1295604084-27761-1-git-send-email-weber@corscience.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Weber <weber@corscience.de>
Cc: linux-omap@vger.kernel.org, manjugk@ti.com, gadiyar@ti.com, tony@atomide.com, govindraj@ti.com, gregkh@suse.de, andrei.emeltchenko@nokia.com, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jan 21, 2011 at 3:31 PM, Thomas Weber <weber@corscience.de> wro=
te:
> Magic SysRq key is not working for OMAP on new serial
> console ttyOx because SUPPORT_SYSRQ is not defined
> for omap-serial.
>
> This patch defines SUPPORT_SYSRQ in omap-serial and
> enables handling of Magic SysRq character.
>
> Further there is an issue of losing first break character.
> Removing the reset of the lsr_break_flag fixes this issue.
>
> Signed-off-by: Thomas Weber <weber@corscience.de>


Acked-by: Govindraj.R <govindraj.raja@ti.com>
Tested-by: Manjunath G Kondaiah <manjugk@ti.com>


> ---
> =A0drivers/serial/omap-serial.c | =A0 =A05 ++++-
> =A01 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/serial/omap-serial.c b/drivers/serial/omap-seria=
l.c
> index 7f2f010..699b344 100644
> --- a/drivers/serial/omap-serial.c
> +++ b/drivers/serial/omap-serial.c
> @@ -20,6 +20,10 @@
> =A0* this driver as required for the omap-platform.
> =A0*/
>
> +#if defined(CONFIG_SERIAL_OMAP_CONSOLE) && defined(CONFIG_MAGIC_SYSR=
Q)
> +#define SUPPORT_SYSRQ
> +#endif
> +
> =A0#include <linux/module.h>
> =A0#include <linux/init.h>
> =A0#include <linux/console.h>
> @@ -190,7 +194,6 @@ static inline void receive_chars(struct uart_omap=
_port *up, int *status)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (up->port.line =3D=3D=
 up->port.cons->index) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Rec=
over the break flag from console xmit */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lsr |=3D=
 up->lsr_break_flag;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->lsr=
_break_flag =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0#endif
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (lsr & UART_LSR_BI)
> --
> 1.7.4.rc2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
