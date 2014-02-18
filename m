From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4 1/2] usb: musb: dsps, debugfs files
Date: Tue, 18 Feb 2014 11:50:19 -0600
Message-ID: <20140218175018.GF28506@saruman.home>
References: <1389950556-6453-1-git-send-email-mpa@pengutronix.de>
 <1389950556-6453-2-git-send-email-mpa@pengutronix.de>
 <20140218162054.GE9878@saruman.home>
 <20140218165911.GA17486@kroah.com>
 <20140218170335.GC28506@saruman.home>
 <20140218173021.GA17368@kroah.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2722986530587737222=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140218173021.GA17368@kroah.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Bin Liu <binmlist@gmail.com>, linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============2722986530587737222==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ChQOR20MqfxkMJg9"
Content-Disposition: inline

--ChQOR20MqfxkMJg9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 18, 2014 at 09:30:21AM -0800, Greg KH wrote:
> > > > > +static int dsps_musb_dbg_init(struct musb *musb, struct dsps_glu=
e *glue)
> > > > > +{
> > > > > +	struct dentry *root;
> > > > > +	struct dentry *file;
> > > > > +	char buf[128];
> > > > > +
> > > > > +	sprintf(buf, "%s.dsps", dev_name(musb->controller));
> > > > > +	root =3D debugfs_create_dir(buf, NULL);
> > > > > +	if (!root)
> > > >=20
> > > > wrong, you should be using IS_ERR()
> > >=20
> > > !root is fine, IS_ERR() will fail if CONFIG_DEBUGFS is not enabled.
> >=20
> > in that case, files will be created on parent directory right ?
>=20
> If, for some reason, creating a directory fails and then creating a file
> would succeed, yes, that will happen.
>=20
> > If we pass a ERR_PTR(-ENODEV), otoh, we will try to dereference it in
> > __create_file().
>=20
> No, because -ENODEV will only happen if debugfs is not enabled, so no
> dereference will ever happen.
>=20
> Don't worry about checking return values from debugfs, it shouldn't be
> needed.

aha, now I see. I missed the:

348         if (error) {
349                 dentry =3D NULL;
350                 simple_release_fs(&debugfs_mount, &debugfs_mount_count);
351         }

in fs/debugfs/inode.c::__create_file(). I'll apply this patch in a few
hours (randconfig running).

cheers

--=20
balbi

--ChQOR20MqfxkMJg9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIbBAEBAgAGBQJTA51aAAoJEIaOsuA1yqREQPMP90j7I4lIyrdkQQ5ikvFMPCt/
l9j2Pi5gP4FADu0fb33IFfHThDtWCGlQO/Wj2/1oamMM8cXWGaMf1UzSGD2B6ykQ
PyrmMp5lXzW4M8A0+id1OfD04ZhV6TZGsQTcmxkTHZb5MABEAeyv3EAiavdncAx+
Mq9y18ZjoqxfziM9h4ONoZwPvVacJdUCiQ8Kf/4cxDs8GPM35dfJ05LO6UUil0x6
jqGlRyjFM6biJ3VShKq9AIjw8CUa+f/ghwjEQBUbwnNIS6NiGNsMj7XsYYfSVeJ3
2yc4JHm/+7CDrx4ftHuXBHv84+IJz3ypLLisKfjsbI29B73rec/yVK/4exD6jNeu
XfI/AfdbM/69OVjqT7ukzZvQxReQDvIfdqZxeZv0/BRhBMA5AzdTfPdnY64ImqF7
0HLgSbOR+QrwsHF7rQ4J4dWczwc1NHhZSSHRJ1kk7FHnY6iDKwmBus+0ET4bD42N
GP7IduMfezWwVlOcBhi8Pet1jTumc3Gp0VhDIJvP0nI4RXt39wiAQC5gL+rwxZPQ
ZDZZ+scVPm6DCYKex4/23mXJQLIN7Dee9ipidGPa2KqrvNMheY4Q5pZl3fivhQ93
qJ7hQ4xhlXmgkDKKzi9ds1/6zOIfnrXNgi2aheF2PBXWl99p1KffPu+oV7ynDPs7
rcpWd2NFYj1Y7utXQLg=
=qUST
-----END PGP SIGNATURE-----

--ChQOR20MqfxkMJg9--


--===============2722986530587737222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2722986530587737222==--
