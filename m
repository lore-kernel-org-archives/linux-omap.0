From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCHv2] OMAP: Enable Magic SysRq on serial console ttyOx
Date: Wed, 19 Jan 2011 15:01:39 +0530
Message-ID: <AANLkTin0-joNuqxqL79j0wqPk_A5mtAgzEY=X=PeH=+C@mail.gmail.com>
References: <1295426461-12459-1-git-send-email-weber@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1295426461-12459-1-git-send-email-weber@corscience.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Weber <weber@corscience.de>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, "Govindraj.R" <govindraj.raja@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Andrei Emeltchenko <andrei.emeltchenko@nokia.com>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 19, 2011 at 2:11 PM, Thomas Weber <weber@corscience.de> wro=
te:
> Magic SysRq key is not working for OMAP on new serial
> console ttyOx because SUPPORT_SYSRQ is not defined
> for omap-serial.
>
> This patch defines SUPPORT_SYSRQ in omap-serial and
> enables handling of Magic SysRq character.
>
> Signed-off-by: Thomas Weber <weber@corscience.de>

Looks fine to me.

Acked-by: Govindraj.R <govindraj.raja@ti.com>

> ---
> Changes from v1: Changed comment
>
> =A0drivers/serial/omap-serial.c | =A0 =A04 ++++
> =A01 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/serial/omap-serial.c b/drivers/serial/omap-seria=
l.c
> index 1201eff..907be9b 100644
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
