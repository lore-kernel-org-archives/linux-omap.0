From: "Zhang, Shijie" <shijie.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCHv11 3/6] i2c: omap: Do not initialise the completion
 everytime
Date: Fri, 29 Jun 2012 01:34:43 +0000
Message-ID: <F432D66873BF804996E7E830C3B891790FD37C8E@SHSMSX102.ccr.corp.intel.com>
References: <1340896292-12112-1-git-send-email-shubhrajyoti@ti.com>
	<1340896292-12112-4-git-send-email-shubhrajyoti@ti.com>
 <CAAe_U6Jtoj3mixvp+vqNmkr-RC28AfNqZ0syEE5voEr+Odv3zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAAe_U6Jtoj3mixvp+vqNmkr-RC28AfNqZ0syEE5voEr+Odv3zg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

No, it should be init_completion(&dev->cmd_complete); in probe, we need=
 to initialize the wait queue, which will be used when using "complete(=
=2E.....)"


-----Original Message-----
=46rom: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-i2c-owner-fy+rA21nqHI@public.gmane.org=
rnel.org] On Behalf Of ABRAHAM, KISHON VIJAY
Sent: Friday, June 29, 2012 12:03 AM
To: Shubhrajyoti D
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-ke=
rnel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org; tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org; w.sang=
@pengutronix.de
Subject: Re: [PATCHv11 3/6] i2c: omap: Do not initialise the completion=
 everytime

Hi,

On Thu, Jun 28, 2012 at 8:41 PM, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> w=
rote:
> Use INIT_COMPLETION instead of init_completion in transfer.
>
> Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> ---
> - Add Felipe's reviewed-by tag
>
> =A0drivers/i2c/busses/i2c-omap.c | =A0 =A03 ++-
> =A01 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c=20
> b/drivers/i2c/busses/i2c-omap.c index b9915bb..6d05f18 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -490,7 +490,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter=20
> *adap,
> =A0 =A0 =A0 =A0w |=3D OMAP_I2C_BUF_RXFIF_CLR | OMAP_I2C_BUF_TXFIF_CLR=
;
> =A0 =A0 =A0 =A0omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, w);
>
> - =A0 =A0 =A0 init_completion(&dev->cmd_complete);
> + =A0 =A0 =A0 INIT_COMPLETION(dev->cmd_complete);
> =A0 =A0 =A0 =A0dev->cmd_err =3D 0;
>
> =A0 =A0 =A0 =A0w =3D OMAP_I2C_CON_EN | OMAP_I2C_CON_MST | OMAP_I2C_CO=
N_STT; @@=20
> -999,6 +999,7 @@ omap_i2c_probe(struct platform_device *pdev)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0platform_set_drvdata(pdev, dev);
> + =A0 =A0 =A0 init_completion(&dev->cmd_complete);
It should be INIT_COMPLETION here too.

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in=
 the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo info=
 at  http://vger.kernel.org/majordomo-info.html
