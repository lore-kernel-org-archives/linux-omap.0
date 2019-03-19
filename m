From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 00/14] Add support for FM radio in hcill and kill TI_ST
Date: Tue, 19 Mar 2019 14:31:55 +0100
Message-ID: <20190319133154.7tbfafy7pguzw2tk@earth.universe>
References: <20181221011752.25627-1-sre@kernel.org>
 <4f47f7f2-3abb-856c-4db5-675caf8057c7@xs4all.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="62zbunq3ffyszqqd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4f47f7f2-3abb-856c-4db5-675caf8057c7@xs4all.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, linux-bluetooth@vger.kernel.org, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--62zbunq3ffyszqqd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Thu, Mar 14, 2019 at 09:20:10AM +0100, Hans Verkuil wrote:
> On 12/21/18 2:17 AM, Sebastian Reichel wrote:
> > This moves all remaining users of the legacy TI_ST driver to hcill (pat=
ches
> > 1-3). Then patches 4-7 convert wl128x-radio driver to a standard platfo=
rm
> > device driver with support for multiple instances. Patch 7 will result =
in
> > (userless) TI_ST driver no longer supporting radio at runtime. Patch 8-=
11 do
> > some cleanups in the wl128x-radio driver. Finally patch 12 removes the =
TI_ST
> > specific parts from wl128x-radio and adds the required infrastructure t=
o use it
> > with the serdev hcill driver instead. The remaining patches 13 and 14 r=
emove
> > the old TI_ST code.
> >=20
> > The new code has been tested on the Motorola Droid 4. For testing the a=
udio
> > should be configured to route Ext to Speaker or Headphone. Then you nee=
d to
> > plug headphone, since its cable is used as antenna. For testing there i=
s a
> > 'radio' utility packages in Debian. When you start the utility you need=
 to
> > specify a frequency, since initial get_frequency returns an error:
>=20
> What is the status of this series?
>
> Based on some of the replies (from Adam Ford in particular) it appears th=
at
> this isn't ready to be merged, so is a v2 planned?

Yes, a v2 is planned, but I'm super busy at the moment. I don't
expect to send something for this merge window. Neither LogicPD
nor IGEP use FM radio, so I can just remove FM support from the
TI_ST framework. Converting those platforms to hci_ll can be done
in a different patchset.

If that was the only issue there would be a v2 already. But Marcel
Holtmann suggested to pass the custom packet data through the BT
subsystem, which is non-trivial (at least for me) :)

-- Sebastian

--62zbunq3ffyszqqd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlyQ70QACgkQ2O7X88g7
+prWdA//Vy7zc3RwtOPcf8fnZpZi5XJmJWA/+h15XD1lwsVp6xBaiIgxbY9/VLjy
7k4qGuFaGVP73+QBEVgPSZKXKAqIAu4ZKTnjbrpOQIO7TPcffKWHjz9Hjy9Uh48T
w6Q+wckAzamw93W2Uq6MITl7yIdUTLvk698fWZe/iD96jL7SORvbyLpWwpQztH/J
z1iYvIzafWUr+VkjmqaSteTwl0gC+L7prdyk4DQHWLtn4Ty5AwgsYkvfqaXju0vm
gW73gYoFvtFJN1uOf349P20mNYbkCi25llV9tbx1FmfKbwHVLWLGWy35+yVG9sUt
/NjzFQDJrFjvuGtVkAIQJH7yX3WlMjl6tce4xqiuKcuXp12AJMOrt9nrku8sxc8I
wuU7F+R9l8yb7jHdWkYYQZcyU31szc9XfmcEyEBPgI2o++i0K4/BDB6rw2dtq9N4
aM9omX45PZirFKW91zAy85soHpBINWI/pYbS3d2tNeRUnxpzOqnbSmgZvYmgj1T1
Qy5zWEK4Db4gy27znrGfGlC6D+bPA1SJ063ZBfugv49Il5NpBRBV7bnan0rDO5+Z
mZURZio8SIX3CY1YnIK694LqOG1adtZns6ioUuA5tPK+T8NkiWHyRA4uHQ4IRFbA
HVxGiuwsqS5eWwuSJEP8A5mTqT2co8Ez4Y6mBtC2Pdzwt6V5RE0=
=iW+w
-----END PGP SIGNATURE-----

--62zbunq3ffyszqqd--
