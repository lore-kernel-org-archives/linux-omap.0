From: "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] OMAP4: I2C: Enable FIFO usage for OMAP4
Date: Tue, 5 Jul 2011 17:05:48 -0700
Message-ID: <CAOMWX4crxR0TQ38mFVkqv5eDQuEAry139+zoD2kKNm6imeR7yQ@mail.gmail.com>
References: <1309849870-25660-1-git-send-email-shubhrajyoti@ti.com> <8739ikp9aa.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8739ikp9aa.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 5, 2011 at 17:01, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org> wrote:
>
> Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> writes:
>
> > Currently the fifo depth is set to zero for OMAP4 which disables
> > the FIFO usage. This patch enables the FIFO usage for I2C transacti=
ons
> > on OMAP4 also.
> >
> > Tested on omap4430 and 3430.
> >
> > Reported-By: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> > Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> > ---
> > Rebased on top of the series by Andy Green
> > http://www.spinics.net/lists/linux-i2c/msg05632.html
>
> Thanks.
>
> This is v3.1 material, but would be nice to see a couple tested-by or
> acked-by tags from folks that are more actively using the I2C driver
> before merging

=46or what it is worth: tested on SDP4460/4430 with 255 multi-byte i2c
read operation on twl6030.

Tested-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>

Regards,
Nishanth Menon



>
> Kevin
>
>
> > =A0drivers/i2c/busses/i2c-omap.c | =A0 11 ++++++-----
> > =A01 files changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c=
-omap.c
> > index d53cd61..8f87a37 100644
> > --- a/drivers/i2c/busses/i2c-omap.c
> > +++ b/drivers/i2c/busses/i2c-omap.c
> > @@ -1068,13 +1068,14 @@ omap_i2c_probe(struct platform_device *pdev=
)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* size. This is to ensure that we ca=
n handle the status on int
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* call back latencies.
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> > - =A0 =A0 =A0 =A0 =A0 =A0 if (dev->rev >=3D OMAP_I2C_REV_ON_3530_44=
30) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->fifo_size =3D 0;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 dev->fifo_size =3D (dev->fifo_size / 2);
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 if (dev->rev >=3D OMAP_I2C_REV_ON_3530_44=
30)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->b_hw =3D 0; /* Dis=
able hardware fixes */
> > - =A0 =A0 =A0 =A0 =A0 =A0 } else {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->fifo_size =3D (dev->=
fifo_size / 2);
> > + =A0 =A0 =A0 =A0 =A0 =A0 else
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->b_hw =3D 1; /* Ena=
ble hardware fixes */
> > - =A0 =A0 =A0 =A0 =A0 =A0 }
> > +
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* calculate wakeup latency constraint =
for MPU */
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dev->set_mpu_wkup_lat !=3D NULL)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->latency =3D (10000=
00 * dev->fifo_size) /
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
