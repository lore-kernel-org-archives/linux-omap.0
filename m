From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH V2] regulator: fixed: update to devm_* API
Date: Tue, 28 Jan 2014 09:55:26 +0100
Message-ID: <1939430.3DVPas1i8V@phil>
References: <1390878720-8676-1-git-send-email-badarkhe.manish@gmail.com> <10462793.IYoAK2XtXv@phil> <CAKDJKT4jPLmtrm6Ngp+nT5vf0H4zXwwAM=oURDF-DSAJodVN6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKDJKT4jPLmtrm6Ngp+nT5vf0H4zXwwAM=oURDF-DSAJodVN6A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Manish Badarkhe <badarkhe.manish-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tuesday, 28. January 2014 14:16:39 Manish Badarkhe wrote:
> Hi Heiko
>=20
> Thank you for your reply.
>=20
> On Tue, Jan 28, 2014 at 1:08 PM, Heiko St=FCbner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org> wr=
ote:
> > On Tuesday, 28. January 2014 12:46:01 Manish Badarkhe wrote:
> >> Hi Dmitry,
> >>=20
> >> Thank you for your review.
> >>=20
> >> On Tue, Jan 28, 2014 at 12:03 PM, Dmitry Torokhov
> >>=20
> >> <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >> > Hi Manish,
> >> >=20
> >> > On Tue, Jan 28, 2014 at 08:42:00AM +0530, Manish Badarkhe wrote:
> >> >> Update the code to use devm_* API so that driver core will mana=
ge
> >> >> resources.
> >> >>=20
> >> >> Signed-off-by: Manish Badarkhe <badarkhe.manish-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> >> ---
> >> >> Changes since V1:
> >> >> 1. Updated driver to use "devm_kzalloc" to "kstrdup".
> >> >> 2. Updated commit message.
> >> >>=20
> >> >> Not tested on any board.
> >> >>=20
> >> >> :100644 100644 5ea64b9... e9763a4... M      =20
> >> >> :drivers/regulator/fixed.c
> >> >> :
> >> >>  drivers/regulator/fixed.c |   42
> >> >>  ++++++++++++------------------------------
> >> >>  1 file changed, 12 insertions(+), 30 deletions(-)
> >> >>=20
> >> >> diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixe=
d.c
> >> >> index 5ea64b9..e9763a4 100644
> >> >> --- a/drivers/regulator/fixed.c
> >> >> +++ b/drivers/regulator/fixed.c
> >> >> @@ -132,15 +132,15 @@ static int reg_fixed_voltage_probe(struct
> >> >> platform_device *pdev)>>
> >> >>=20
> >> >>                              GFP_KERNEL);
> >> >>      =20
> >> >>       if (drvdata =3D=3D NULL) {
> >> >>      =20
> >> >>               dev_err(&pdev->dev, "Failed to allocate device da=
ta\n");
> >> >>=20
> >> >> -             ret =3D -ENOMEM;
> >> >> -             goto err;
> >> >> +             return -ENOMEM;
> >> >>=20
> >> >>       }
> >> >>=20
> >> >> -     drvdata->desc.name =3D kstrdup(config->supply_name, GFP_K=
ERNEL);
> >> >> +     drvdata->desc.name =3D devm_kzalloc(&pdev->dev,
> >> >> +                                       strlen(config->supply_n=
ame) +
> >> >> 1,
> >> >> +                                       GFP_KERNEL);
> >> >>=20
> >> >>       if (drvdata->desc.name =3D=3D NULL) {
> >> >>      =20
> >> >>               dev_err(&pdev->dev, "Failed to allocate supply na=
me\n");
> >> >>=20
> >> >> -             ret =3D -ENOMEM;
> >> >> -             goto err;
> >> >> +             return -ENOMEM;
> >> >>=20
> >> >>       }
> >> >=20
> >> > Umm, I am fairly certain that devm_kzalloc() can't be used as a
> >> > substitute for kstrdup, at least not without accompanying memcpy=
=2E
> >>=20
> >> Yes, I have provided allocation but it should be followed with
> >> assignment.
> >> Can I modify like this,
> >>=20
> >> +     drvdata->desc.name =3D devm_kzalloc(&pdev->dev,
> >> +                                       strlen(config->supply_name=
) + 1,
> >> +                                       GFP_KERNEL);
> >> +     if (drvdata->desc.name)
> >> +     sprintf(drvdata->desc.name, "%s", config->supply_name);
> >=20
> > hmm, so you replaced a general helper function by open coding the s=
tring-
> > duplication. Doesn't this defeat the target of simplifying the code=
?
>=20
> Intention here, is to use devm_ API and to adopt this I have to do th=
ese
> modifications for "kstrdup" functions. I have seen in regulator folde=
r
> almost all drivers adopted to "devm_" API. Hence same thing I am foll=
owing
> to update this driver. Please let me know whether to go ahead with th=
is
> patch or retain driver as it is.

I don't have a strong opinion on this and others are most likely more q=
ualified=20
to have a definitive answer, I just found it strange to exchange one op=
en-coded=20
pattern against another open-coded one.

So don't let me keep you from it ;-)

Heiko
