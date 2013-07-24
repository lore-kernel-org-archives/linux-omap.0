From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/4] mfd: twl6030-irq: migrate to IRQ threaded handler
Date: Wed, 24 Jul 2013 12:54:13 +0100
Message-ID: <20130724115413.GK26801@laptop>
References: <1374595624-15054-1-git-send-email-grygorii.strashko@ti.com>
 <1374595624-15054-2-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f44.google.com ([74.125.83.44]:57654 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003Ab3GXLyT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Jul 2013 07:54:19 -0400
Received: by mail-ee0-f44.google.com with SMTP id c13so184859eek.17
        for <linux-omap@vger.kernel.org>; Wed, 24 Jul 2013 04:54:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1374595624-15054-2-git-send-email-grygorii.strashko@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Kevin Hilman <khilman@linaro.org>, Graeme Gregory <gg@slimlogic.co.uk>, linux-omap@vger.kernel.org, Ruslan Bilovol <ruslan.bilovol@ti.com>, linux-kernel@vger.kernel.org, Naga Venkata Srikanth V <vnv.srikanth@samsung.com>, Oleg_Kosheliev <oleg.kosheliev@ti.com>

On Tue, 23 Jul 2013, Grygorii Strashko wrote:

> From: Naga Venkata Srikanth V <vnv.srikanth@samsung.com>
>=20
> 1) Removed request_irq() and replaced it with request_threaded_irq().
>=20
> 2) Removed generic_handle_irq() and replaced it with
> handle_nested_irq().
>   Handling of these interrupts is nested, as we are handling an
> interrupt (for e.g rtc, mmc1) when we are still servicing TWL irq.
>=20
> 3) Removed I2C read-retry logic for the case when twl_i2c_read() is
> failed inside IRQ handler - there is no sense to do that, so just rep=
ort
> an error and return.
>=20
> Signed-off-by: Naga Venkata Srikanth V <vnv.srikanth@samsung.com>
> Signed-off-by: Oleg_Kosheliev <oleg.kosheliev@ti.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  drivers/mfd/twl6030-irq.c |  146 +++++++++++++++--------------------=
----------
>  1 file changed, 49 insertions(+), 97 deletions(-)
>=20
> diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c

<snip>

> +	status =3D request_threaded_irq(irq_num, NULL, twl6030_irq_thread,
> +				      IRQF_ONESHOT, "TWL6030-PIH", NULL);

Oh, and please use managed resources for this: devm_*

>  	if (status < 0) {
>  		dev_err(dev, "could not claim irq %d: %d\n", irq_num, status);
>  		goto fail_irq;
>  	}
> =20

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
