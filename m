From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v3 02/11] i2c: OMAP: Add DT support for i2c controller
Date: Tue, 20 Dec 2011 13:24:07 -0800
Message-ID: <CAOesGMiwg9gVDDwCjuCcAPX6hc2E6OgH-c_nAqhCHmj7y5oCeQ@mail.gmail.com>
References: <1324398444-23296-1-git-send-email-b-cousson@ti.com>
	<1324398444-23296-3-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46537 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482Ab1LTVYI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Dec 2011 16:24:08 -0500
Received: by yhr47 with SMTP id 47so4980402yhr.19
        for <linux-omap@vger.kernel.org>; Tue, 20 Dec 2011 13:24:07 -0800 (PST)
In-Reply-To: <1324398444-23296-3-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: rob.herring@calxeda.com, tony@atomide.com, Kevin Hilman <khilman@ti.com>, devicetree-discuss@lists.ozlabs.org, Ben Dooks <ben-linux@fluff.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Tue, Dec 20, 2011 at 8:27 AM, Benoit Cousson <b-cousson@ti.com> wrot=
e:


> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-o=
map.c
> index a43d002..dcbc1ec 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -37,6 +37,8 @@
> =A0#include <linux/platform_device.h>
> =A0#include <linux/clk.h>
> =A0#include <linux/io.h>
> +#include <linux/of_i2c.h>
> +#include <linux/of_device.h>
> =A0#include <linux/slab.h>
> =A0#include <linux/i2c-omap.h>
> =A0#include <linux/pm_runtime.h>
[...]
> @@ -1165,6 +1195,7 @@ static struct platform_driver omap_i2c_driver =3D=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "omap_i2c",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =A0=3D THIS_MODULE,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.pm =A0 =A0 =3D OMAP_I2C_PM_OPS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D of_match_ptr(omap_i=
2c_of_match),
> =A0 =A0 =A0 =A0},
> =A0};

of_match_ptr() comes from <linux/of.h>, so you need to include that to
not break !CONFIG_OF builds.


-Olof
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
