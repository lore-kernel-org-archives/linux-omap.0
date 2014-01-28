From: Manish Badarkhe <badarkhe.manish-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2] regulator: fixed: update to devm_* API
Date: Tue, 28 Jan 2014 14:31:32 +0530
Message-ID: <CAKDJKT5z=-CmK+goocgdqy2eQMZN2tsoPgzOFk4KbFTTTiUNAA@mail.gmail.com>
References: <1390878720-8676-1-git-send-email-badarkhe.manish@gmail.com>
	<10462793.IYoAK2XtXv@phil>
	<CAKDJKT4jPLmtrm6Ngp+nT5vf0H4zXwwAM=oURDF-DSAJodVN6A@mail.gmail.com>
	<1939430.3DVPas1i8V@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1939430.3DVPas1i8V@phil>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 28, 2014 at 2:25 PM, Heiko St=FCbner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org> wrot=
e:
> On Tuesday, 28. January 2014 14:16:39 Manish Badarkhe wrote:
>> Hi Heiko
>>
>> Thank you for your reply.
>>
>> On Tue, Jan 28, 2014 at 1:08 PM, Heiko St=FCbner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org> w=
rote:
>> > On Tuesday, 28. January 2014 12:46:01 Manish Badarkhe wrote:
>> >> Hi Dmitry,
>> >>
>> >> Thank you for your review.
>> >>
>> >> On Tue, Jan 28, 2014 at 12:03 PM, Dmitry Torokhov
>> >>
>> >> <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> >> > Hi Manish,
>> >> >
>> >> > On Tue, Jan 28, 2014 at 08:42:00AM +0530, Manish Badarkhe wrote=
:
>> >> >> Update the code to use devm_* API so that driver core will man=
age
>> >> >> resources.
>> >> >>
>> >> >> Signed-off-by: Manish Badarkhe <badarkhe.manish-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> >> >> ---
>> >> >> Changes since V1:
>> >> >> 1. Updated driver to use "devm_kzalloc" to "kstrdup".
>> >> >> 2. Updated commit message.
>> >> >>
>> >> >> Not tested on any board.
>> >> >>
>> >> >> :100644 100644 5ea64b9... e9763a4... M
>> >> >> :drivers/regulator/fixed.c
>> >> >> :
>> >> >>  drivers/regulator/fixed.c |   42
>> >> >>  ++++++++++++------------------------------
>> >> >>  1 file changed, 12 insertions(+), 30 deletions(-)
>> >> >>
>> >> >> diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fix=
ed.c
>> >> >> index 5ea64b9..e9763a4 100644
>> >> >> --- a/drivers/regulator/fixed.c
>> >> >> +++ b/drivers/regulator/fixed.c
>> >> >> @@ -132,15 +132,15 @@ static int reg_fixed_voltage_probe(struc=
t
>> >> >> platform_device *pdev)>>
>> >> >>
>> >> >>                              GFP_KERNEL);
>> >> >>
>> >> >>       if (drvdata =3D=3D NULL) {
>> >> >>
>> >> >>               dev_err(&pdev->dev, "Failed to allocate device d=
ata\n");
>> >> >>
>> >> >> -             ret =3D -ENOMEM;
>> >> >> -             goto err;
>> >> >> +             return -ENOMEM;
>> >> >>
>> >> >>       }
>> >> >>
>> >> >> -     drvdata->desc.name =3D kstrdup(config->supply_name, GFP_=
KERNEL);
>> >> >> +     drvdata->desc.name =3D devm_kzalloc(&pdev->dev,
>> >> >> +                                       strlen(config->supply_=
name) +
>> >> >> 1,
>> >> >> +                                       GFP_KERNEL);
>> >> >>
>> >> >>       if (drvdata->desc.name =3D=3D NULL) {
>> >> >>
>> >> >>               dev_err(&pdev->dev, "Failed to allocate supply n=
ame\n");
>> >> >>
>> >> >> -             ret =3D -ENOMEM;
>> >> >> -             goto err;
>> >> >> +             return -ENOMEM;
>> >> >>
>> >> >>       }
>> >> >
>> >> > Umm, I am fairly certain that devm_kzalloc() can't be used as a
>> >> > substitute for kstrdup, at least not without accompanying memcp=
y.
>> >>
>> >> Yes, I have provided allocation but it should be followed with
>> >> assignment.
>> >> Can I modify like this,
>> >>
>> >> +     drvdata->desc.name =3D devm_kzalloc(&pdev->dev,
>> >> +                                       strlen(config->supply_nam=
e) + 1,
>> >> +                                       GFP_KERNEL);
>> >> +     if (drvdata->desc.name)
>> >> +     sprintf(drvdata->desc.name, "%s", config->supply_name);
>> >
>> > hmm, so you replaced a general helper function by open coding the =
string-
>> > duplication. Doesn't this defeat the target of simplifying the cod=
e?
>>
>> Intention here, is to use devm_ API and to adopt this I have to do t=
hese
>> modifications for "kstrdup" functions. I have seen in regulator fold=
er
>> almost all drivers adopted to "devm_" API. Hence same thing I am fol=
lowing
>> to update this driver. Please let me know whether to go ahead with t=
his
>> patch or retain driver as it is.
>
> I don't have a strong opinion on this and others are most likely more=
 qualified
> to have a definitive answer, I just found it strange to exchange one =
open-coded
> pattern against another open-coded one.
>
> So don't let me keep you from it ;-)

Okay.
@Mark, Dmitry: Please let me know your opinion on this.

Thanks
Manish Badarkhe
