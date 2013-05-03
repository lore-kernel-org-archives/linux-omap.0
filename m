From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: OMAP-USB: Fix possible memory leak
Date: Fri, 3 May 2013 09:21:51 +0300
Message-ID: <20130503061931.GB27451@arwen.pp.htv.fi>
References: <1367510596-27780-1-git-send-email-shc_work@mail.ru>
 <20130502162433.GA10016@kahuna> <1367512124.978518915@f372.mail.ru>
 <20130502164058.GC8577@arwen.pp.htv.fi>
 <20130502231353.GF21614@n2100.arm.linux.org.uk>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3246359119886415263=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130502231353.GF21614@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nishanth Menon <nm@ti.com>, Alexander Shiyan <shc_work@mail.ru>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============3246359119886415263==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
Content-Disposition: inline

--vEao7xgI/oilGqZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 03, 2013 at 12:13:53AM +0100, Russell King - ARM Linux wrote:
> > > > > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > > > > ---
> > > > >  arch/arm/mach-omap2/usb-host.c | 21 +++++++++++++++++----
> > > > >  1 file changed, 17 insertions(+), 4 deletions(-)
> > > > >=20
> > > > > diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2=
/usb-host.c
> > > > > index aa27d7f..8d17a0d 100644
> > > > > --- a/arch/arm/mach-omap2/usb-host.c
> > > > > +++ b/arch/arm/mach-omap2/usb-host.c
> > > > > @@ -570,8 +570,10 @@ static int usbhs_add_regulator(char *name, c=
har *dev_id, char *dev_supply,
> > > > >  	supplies->dev_name =3D dev_id;
> > > > > =20
> > > > >  	reg_data =3D kzalloc(sizeof(*reg_data), GFP_KERNEL);
> > > > > -	if (!reg_data)
> > > > > +	if (!reg_data) {
> > > > > +		kfree(supplies);
> > > > >  		return -ENOMEM;
> > > > > +	}
> > > > > =20
> > > > >  	reg_data->constraints.valid_ops_mask =3D REGULATOR_CHANGE_STATU=
S;
> > > > >  	reg_data->consumer_supplies =3D supplies;
> > > > > @@ -579,8 +581,11 @@ static int usbhs_add_regulator(char *name, c=
har *dev_id, char *dev_supply,
> > > > > =20
> > > > >  	config =3D kmemdup(&hsusb_reg_config, sizeof(hsusb_reg_config),
> > > > >  			GFP_KERNEL);
> > > > > -	if (!config)
> > > > > +	if (!config) {
> > > > > +		kfree(supplies);
> > > > > +		kfree(reg_data);
> > > > >  		return -ENOMEM;
> > > > > +	}
> > > > > =20
> > > > >  	config->supply_name =3D name;
> > > > >  	config->gpio =3D gpio;
> > > > > @@ -589,17 +594,25 @@ static int usbhs_add_regulator(char *name, =
char *dev_id, char *dev_supply,
> > > > > =20
> > > > >  	/* create a regulator device */
> > > > >  	pdev =3D kzalloc(sizeof(*pdev), GFP_KERNEL);
> > > > > -	if (!pdev)
> > > > > +	if (!pdev) {
> > > > > +		kfree(supplies);
> > > > > +		kfree(reg_data);
> > > > > +		kfree(config);
> > > > >  		return -ENOMEM;
> > > > > +	}
> > > > > =20
> > > > >  	pdev->id =3D PLATFORM_DEVID_AUTO;
> > > > >  	pdev->name =3D reg_name;
> > > > >  	pdev->dev.platform_data =3D config;
> > > > > =20
> > > > >  	ret =3D platform_device_register(pdev);
> > > > > -	if (ret)
> > > > > +	if (ret) {
> > > > >  		pr_err("%s: Failed registering regulator %s for %s\n",
> > > > >  				__func__, name, dev_id);
> > > > > +		kfree(supplies);
> > > > > +		kfree(reg_data);
> > > > > +		kfree(config);
> > > > > +	}
> > > >=20
> > > > Might be better to switch to devm_XXX managed functions?
> >=20
> > I don't think it makes sense since the platform_device hasn't been
> > registered yet.
> >=20
> > Still, patch can be improved with proper goto labels instead of
> > sprinkling different kfree() calls in every single error branch.
> >=20
> > > If anyone can rewrite driver to use devm_xx, it would have been bette=
r.
> > > I'm not going to redo the patch yet, let it be so, I just showed a po=
int
> > > for OMAP-developers.
> >=20
> > fair enough.
>=20
> Well, as long as this crap violates the driver model by using kfree() on
> a device...  Devices are refcounted and must only be freed when the
> refcount drops to zero.

read the patch again, there's no kfree() on any device. There is a kfree
of supplies, reg_data and config.

On top of that, the code being changed here doesn't even exist, so I
wonder which tree is this code based off. usb-host.c has always being
using omap_device_build() which internally calls
platform_device_alloc().

> This is exactly why we have platform_device_alloc(),
> platform_device_register_full() and friends - so that people don't have to
> fsck around with kzalloc themselves and get it wrong like the above does.
>=20
> Would you like me to pass your details to gregkh for another one of his
> public humilation exercises over basic kernel programming stuff? :)

How about we pass yours for not reading the patch before flaming ? Note
that $SUBJECT is *not* touching at all that line which kzallocs a
platform_device. Wrong as it is, it's not part of $SUBJECT.

--=20
balbi

--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRg1d/AAoJEIaOsuA1yqRE9ikP+wQaCdWClDOrzioBIP7YSLVQ
I8IACFUNsuxAH8k7S1byGf7PY3OG5hT483oL7wFY3S7dKhUd75bzSWKHA1QxtQwh
hLOGa2JgPZU0FFnqVrLOkb6YjMnecaVgxAJ/3GgKFMwLt5blIBJYAmSugwKsHjGy
BeHwMbmQtoOdPZToaq2Iz6nsjwi9BDIWJSJfxdC3ACTg7ieQ+VUoJTHSBy2eJbIb
f8bEPKAWcQyoQYDJ2SXHr/H2nm1XFQiZ6MfyULinJeS9egz6kSXozKkKc4UCEV8j
u5hlkMEYNrZviZrZUG/i0D5Ycfj9R6CV6iFV+6Xp2AgW6Pr/Ud2NQkkl1Q9UBnnw
tlwyBXdoB/JovF05hSZJUQjXuj0OdA+gjGvZKEItFuZ+2jr0e9oKklxteSuV20hP
cGZTuWRQtpqqSx8F2zoadhLMxa2y0zUqjfpN1t6dq7WEYQTKfOeMhrcNoGnGiKQC
6F8qna/wBw7YiPB+qPBFtzFMH1KUDQKmk90FVcJA3qO05aScqgIs6P/lqP+dLOO/
CrgwO7Wo0anLF6elSIaHgPNzke5UMvndVEtKLf69OooOe2aA/C2SV6JceV4Y+3hu
MkXkth4T/ax1eDdaMkRPjd1GUHnfmm6nRr+QKupTLoWTe/+vmHbCd9wfjUXpBClk
oFLHLx9kYifdbVJbLn4h
=N/1O
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--


--===============3246359119886415263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3246359119886415263==--
