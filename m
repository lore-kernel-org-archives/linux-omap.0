From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 00/10] pwm-backlight: Add GPIO and power supply support
Date: Tue, 24 Sep 2013 11:00:24 +0200
Message-ID: <20130924090023.GA13971@ulmo>
References: <1379972467-11243-1-git-send-email-treding@nvidia.com>
 <20130924081446.GA11981@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130924081446.GA11981-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, openezx-devel-ZwoEplunGu3n3BO9LpVK+9i2O/JbrIOy@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2013 at 05:14:46PM +0900, Simon Horman wrote:
> [ Cc: Olof Johansson, Kevin Hilman and Arnd Bergman: arm-soc maintainers ]
>=20
> On Mon, Sep 23, 2013 at 11:40:57PM +0200, Thierry Reding wrote:
> > This series adds the ability to specify a GPIO and a power supply to
> > enable a backlight.
> >=20
> > Patch 1 refactors the power on and power off sequences into separate
> > functions in preparation for subsequent patches.
> >=20
> > Patch 2 adds an optional GPIO to enable a backlight. This patch only
> > includes the field within the platform data so that it can be properly
> > setup before actually being put to use.
> >=20
> > Patches 3 to 7 convert all users of the pwm-backlight driver to use the
> > new field. For most of them, this just initializes the field to -1,
> > marking the field as unused.
> >
> > Patch 8 uses the new field within the pwm-backlight driver and at the
> > same time allows it to be parsed from device tree.
> >=20
> > Patch 9 implements support for an optional power supply. This relies on
> > the regulator core to return a dummy regulator when no supply has been
> > otherwise setup so the driver doesn't have to handle that specially nor
> > require all users to be updated.
> >=20
> > Patch 10 adds a way to keep a backlight turned off at boot. This is
> > useful when hooking up a backlight with a subsystem such as DRM which
> > has more explicit semantics as to when a backlight should be turned on.
> >=20
> > Due to the dependencies within the series, I propose to take all these
> > patches through the PWM tree, so I'll need acks from OMAP, PXA, Samsung,
> > shmobile and Unicore32 maintainers.
>=20
> I received some feedback regarding shmobile conflicts when
> arm-soc was merged between v3.11 and v3.12-rc1. With this
> in mind I now have a strong preference for changes inside
> arch/arm/mach-shmobile/ to be taken through my renesas
> tree and thus more importantly through arm-soc if possible.

I understand. Unfortunately the nature of patche series such as this is
that they require the whole series to be applied atomically (or at least
in a very specific order). So the patch that uses the new enable_gpio
field can only be applied after all previous patches. The only
reasonable way to ensure that is to take all of the patches through one
tree. Furthermore this patch is tiny (it adds a single line) and touches
code that's unlikely to be modified by anyone else.

But if it makes you more comfortable, I could provide a stable branch
that contains this series for you to merge into the shmobile tree. That
should enable you to handle all conflict resolution prior to submitting
to arm-soc.

Thierry

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSQVSnAAoJEN0jrNd/PrOhgCMP+wRMaYep/EsYaWZD236S1Oo9
g766VpEy2PHs0H3e7krMcNGDj5ML47p0FYtmxJELSLrLqpveM5KgfJ1S1xw6Q+z+
NoXXVTfkIJstUCW8jV6zmWvoYqBhhqoog3f76Xj/HoUcFRFdKG7oJS5GvRvLi+6i
JX1hk0bSIN/tSJaM+PmCZpgwCfRV8ilcP8/cQpp9xsucHRSWA4fWmh06upGQle4D
RtcjkRIwlQXk3A5oj98HlF7DwoHzD4b3OoxWpMvlRFXcICpzPgvKJzHoJpzHbYsV
i0Ob0+0wROPhtQEJn86A9fLWf6qQUqZ5YbOaWxWVrtVHXfrY3+wRzXso/MuQEux0
E6RnRJD5uzJuA0T6ycXowdFhL2GWuOKtU3EnTxobNccrnsWhMlYM5/nVzkx2TsJH
rl5KfaPYFtDWLHZLov+a4RdldBLRDt4mM0SsY4HS44tE7/F8luRGP/I8MXjUm1sd
AdUwivXp41jKSeFEUaObMU/Ji/fMZGgu/6lnwgjE7t6KWzQNKOLVKnTDB/2XTGvc
9K+IYFLpl8pmKDf2rw+tXEd2zvNnopEREEBpYTGYZLETj9CaoO/F2yBPisGPa3zM
BqsAf6eFdq/C2VwdDi0/+FQ7VbkTksKXfizbHhbRXXZTDHftRb02kwABlli9fP1B
nloibteSzFiBna2xk6uS
=QTQk
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
