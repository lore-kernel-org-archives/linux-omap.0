From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCHv2] mfd: twl4030: Fix mismatch in mutex lock-unlock
Date: Mon, 11 Jul 2011 22:33:16 +0530
Message-ID: <CAJ6a13YEbFBtkCSqZvZCJ5Zqizb3s+j39gm=Yr0tWEtJdw4cKQ@mail.gmail.com>
References: <1310397631-1596-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:39938 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754264Ab1GKRDR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 13:03:17 -0400
Received: by mail-iy0-f179.google.com with SMTP id 35so4116335iyn.38
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 10:03:16 -0700 (PDT)
In-Reply-To: <1310397631-1596-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

Hi Sanjeev,

Thanks. Changes look good to me.

On Mon, Jul 11, 2011 at 8:50 PM, Sanjeev Premi <premi@ti.com> wrote:
> A mutex is locked on entry into twl4030_madc_conversion().
> Immediate return on some error conditions leaves the
> mutex locked.
>
> This patch ensures that mutex is always unlocked before
> leaving the function.
>
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> ---
>
> =A0Compile tested only.
>
> =A0Changes since v1:
> =A0 None. Repost after adding Samuel Ortiz to cc: and
> =A0 removed lm-sensors list from to: list.
>
> =A0drivers/mfd/twl4030-madc.c | =A0 =A08 ++++----
> =A01 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mfd/twl4030-madc.c b/drivers/mfd/twl4030-madc.c
> index 3941ddc..b5d598c 100644
> --- a/drivers/mfd/twl4030-madc.c
> +++ b/drivers/mfd/twl4030-madc.c
> @@ -530,13 +530,13 @@ int twl4030_madc_conversion(struct twl4030_madc=
_request *req)
> =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(twl4030_madc->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"unable to write sel r=
egister 0x%X\n", method->sel + 1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0ret =3D twl_i2c_write_u8(TWL4030_MODULE_MADC, ch_lsb, =
method->sel);
> =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(twl4030_madc->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"unable to write sel r=
egister 0x%X\n", method->sel + 1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0/* Select averaging for all channels if do_avg is set =
*/
> =A0 =A0 =A0 =A0if (req->do_avg) {
> @@ -546,7 +546,7 @@ int twl4030_madc_conversion(struct twl4030_madc_r=
equest *req)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(twl4030_madc->=
dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"unabl=
e to write avg register 0x%X\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0method=
->avg + 1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D twl_i2c_write_u8(TWL4030_MODUL=
E_MADC,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ch_lsb, method->avg);
> @@ -554,7 +554,7 @@ int twl4030_madc_conversion(struct twl4030_madc_r=
equest *req)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(twl4030_madc->=
dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"unabl=
e to write sel reg 0x%X\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0method=
->sel + 1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0if (req->type =3D=3D TWL4030_MADC_IRQ_ONESHOT && req->=
func_cb !=3D NULL) {
> --
> 1.7.2.2
>
>



--=20
Regards and Thanks,
Keerthy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
