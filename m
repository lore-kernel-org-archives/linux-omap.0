From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: omap-usb-tll: fix include of omap-usb.h
Date: Thu, 9 Jun 2016 14:52:29 +0100
Message-ID: <20160609135229.GB2385@dell>
References: <1465409180-18634-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465409180-18634-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, 08 Jun 2016, Ben Dooks wrote:

> Fix the warnings about the following functions not being
> declared by including omap-usb.h which declares them:
>=20
> drivers/mfd/omap-usb-tll.c:333:5: warning: symbol 'omap_tll_init' was=
 not declared. Should it be static?
> drivers/mfd/omap-usb-tll.c:408:5: warning: symbol 'omap_tll_enable' w=
as not declared. Should it be static?
> drivers/mfd/omap-usb-tll.c:442:5: warning: symbol 'omap_tll_disable' =
was not declared. Should it be static?
>=20
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/mfd/omap-usb-tll.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

> diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
> index c30290f..1aa74c4 100644
> --- a/drivers/mfd/omap-usb-tll.c
> +++ b/drivers/mfd/omap-usb-tll.c
> @@ -30,6 +30,8 @@
>  #include <linux/platform_data/usb-omap.h>
>  #include <linux/of.h>
> =20
> +#include "omap-usb.h"
> +
>  #define USBTLL_DRIVER_NAME	"usbhs_tll"
> =20
>  /* TLL Register Set */

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
