From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH v2] phy: phy-twl4030-usb: fix denied runtime access
Date: Thu, 21 Feb 2019 17:08:40 +0100
Message-ID: <20190221170840.5c970def@kemnade.info>
References: <20180922094405.4067-1-andreas@kemnade.info>
        <20190220223132.GV15711@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/xa./i5MTSts9ASx=BCx8Itv"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190220223132.GV15711@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, kishon@ti.com, lee.jones@linaro.org, daniel.thompson@linaro.org, wsa@the-dreams.de, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

--Sig_/xa./i5MTSts9ASx=BCx8Itv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 20 Feb 2019 14:31:32 -0800
Tony Lindgren <tony@atomide.com> wrote:

> * Andreas Kemnade <andreas@kemnade.info> [180922 09:48]:
> > When runtime is not enabled, pm_runtime_get_sync() returns -EACCESS,
> > the counter will be incremented but the resume callback not called,
> > so enumeration and charging will not start properly.
> > To avoid that happen, disable irq on suspend and recheck on resume.
> >=20
> > Practically this happens when the device is woken up from suspend by
> > plugging in usb.
> >=20
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> > Changes in v2:
> > * use pm suspend/resume callback instead of delayed_work
> >   as suggested by Dmitry =20
>=20
> Hmm it just occurred to me that this issue too might be fixed with commit
> c6e2bd956936 ("i2c: omap: Use noirq system sleep pm ops to idle device
> for suspend"). Andreas, care to check? That is if this is still an
> issue.
>=20
this one made already its way into 4.20. But for the records, I will
build the latest 5.0-rc and revert it and will check if the problem
still occurs.

I do not think the patch you mentioned has something to do with this
because here solely the problem is about things happen on resume.

But on gta04 we had several irregular behavior regarding to actions
on the other i2c bus where all the sensors and touchscreen are located.
It happens rarely and most often when I am not up to debugging it.
So maybe your patch helps there.

Regards,
Andreas

--Sig_/xa./i5MTSts9ASx=BCx8Itv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAlxuzQkACgkQl4jFM1s/
ye+2/g/+PzYxlaboOKPWnvVCAY6EtXecJFEEydrDdg77y7X92+mxQIZYqTQyoHcT
pwiYgespfie0vCLm4SJgaXq03MJmjlz/HpvVOkz72YSbyEQPnQX5ecKIzA9ys85+
5V5j7h09gBQ0kDte/r7302SjJHrUPC6qkFjJzWMyk9fPyqBufl46rU0SWgQudCKP
oQ3typmDliabNRiPg+oweQoSIsDk0cG3YGY+rLjtMQ+uENlqvyqRDdcBcyGLUNU0
IFMNPyzAP0zaD2raZMkHFIkJT/fF8fhvMLfk/soJXwyFpgsruxrr+GFZ5qbO37Bc
IKFFq36iGF7/oqmd6jx6dBHdG3AqiCJwcKUgu0his6ipF5EdPxYUU1UHvrf3lsWH
oENnwhIKfAYCKBEY3cejrIxyzVk9KDQAC9rajC4dtDzbA6C5fNK0qzaaBxsjxkKp
N0kWy7YxC4+Z5awgcoS2qQSROjjY3jJJzAP3khrA84FtxS/BuF+MrtTuualmGQcN
SRXKN7HOjVENyJdwwAKDGJ5u7ZTA9OvqVP2aG5lHPJxynpyNFzFmn117dqn8Cvl5
Ywbgq8XFMVQKn4wEOaPOvUPuzvXCp8ULmb8t13QduGHTP4Wnsy+KKAe24zXd+Y+R
y7XaWN05EroI86hJeNOVi9TDhwnWciV/nsvO082Qpejxc3gH11g=
=kzqh
-----END PGP SIGNATURE-----

--Sig_/xa./i5MTSts9ASx=BCx8Itv--
