From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 19/30] tty/serial/omap: console can only be built-in
Date: Mon, 3 Oct 2011 10:23:15 +0530
Message-ID: <CAAL8m4xrLXzHBjM4fmOmSnpvHSBYMSvWewKQg=RjcS79Q2ThUg@mail.gmail.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-20-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1317566760-25681-20-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sun, Oct 2, 2011 at 8:15 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> When the omap serial driver is built as a module, we must
> not allow the console driver to be selected, because consoles
> can not be loadable modules.

Agree.

>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Govindraj.R <govindraj.raja@ti.com>

Acked-by: Govindraj.R <govindraj.raja@ti.com>

> ---
> =A0drivers/tty/serial/Kconfig | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 4dcb37bb..eb04b2f 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1346,7 +1346,7 @@ config SERIAL_OMAP
>
> =A0config SERIAL_OMAP_CONSOLE
> =A0 =A0 =A0 =A0bool "Console on OMAP serial port"
> - =A0 =A0 =A0 depends on SERIAL_OMAP
> + =A0 =A0 =A0 depends on SERIAL_OMAP=3Dy
> =A0 =A0 =A0 =A0select SERIAL_CORE_CONSOLE
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Select this option if you would like to use omap seria=
l port as
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
