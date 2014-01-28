From: Manish Badarkhe <badarkhe.manish@gmail.com>
Subject: Re: [PATCH V2] regulator: fixed: update to devm_* API
Date: Tue, 28 Jan 2014 14:16:39 +0530
Message-ID: <CAKDJKT4jPLmtrm6Ngp+nT5vf0H4zXwwAM=oURDF-DSAJodVN6A@mail.gmail.com>
References: <1390878720-8676-1-git-send-email-badarkhe.manish@gmail.com>
	<20140128063308.GA5965@core.coreip.homeip.net>
	<CAKDJKT5COnY=i4Dd-P8_eMoWBU+ShqVKVhoVGBk1qWxffe+wMg@mail.gmail.com>
	<10462793.IYoAK2XtXv@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <10462793.IYoAK2XtXv@phil>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-omap@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-tegra@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi Heiko

Thank you for your reply.

On Tue, Jan 28, 2014 at 1:08 PM, Heiko St=FCbner <heiko@sntech.de> wrot=
e:
> On Tuesday, 28. January 2014 12:46:01 Manish Badarkhe wrote:
>> Hi Dmitry,
>>
>> Thank you for your review.
>>
>> On Tue, Jan 28, 2014 at 12:03 PM, Dmitry Torokhov
>>
>> <dmitry.torokhov@gmail.com> wrote:
>> > Hi Manish,
>> >
>> > On Tue, Jan 28, 2014 at 08:42:00AM +0530, Manish Badarkhe wrote:
>> >> Update the code to use devm_* API so that driver core will manage
>> >> resources.
>> >>
>> >> Signed-off-by: Manish Badarkhe <badarkhe.manish@gmail.com>
>> >> ---
>> >> Changes since V1:
>> >> 1. Updated driver to use "devm_kzalloc" to "kstrdup".
>> >> 2. Updated commit message.
>> >>
>> >> Not tested on any board.
>> >>
>> >> :100644 100644 5ea64b9... e9763a4... M        drivers/regulator/f=
ixed.c
>> >> :
>> >>  drivers/regulator/fixed.c |   42
>> >>  ++++++++++++------------------------------
>> >>  1 file changed, 12 insertions(+), 30 deletions(-)
>> >>
>> >> diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.=
c
>> >> index 5ea64b9..e9763a4 100644
>> >> --- a/drivers/regulator/fixed.c
>> >> +++ b/drivers/regulator/fixed.c
>> >> @@ -132,15 +132,15 @@ static int reg_fixed_voltage_probe(struct
>> >> platform_device *pdev)>>
>> >>                              GFP_KERNEL);
>> >>
>> >>       if (drvdata =3D=3D NULL) {
>> >>
>> >>               dev_err(&pdev->dev, "Failed to allocate device data=
\n");
>> >>
>> >> -             ret =3D -ENOMEM;
>> >> -             goto err;
>> >> +             return -ENOMEM;
>> >>
>> >>       }
>> >>
>> >> -     drvdata->desc.name =3D kstrdup(config->supply_name, GFP_KER=
NEL);
>> >> +     drvdata->desc.name =3D devm_kzalloc(&pdev->dev,
>> >> +                                       strlen(config->supply_nam=
e) + 1,
>> >> +                                       GFP_KERNEL);
>> >>
>> >>       if (drvdata->desc.name =3D=3D NULL) {
>> >>
>> >>               dev_err(&pdev->dev, "Failed to allocate supply name=
\n");
>> >>
>> >> -             ret =3D -ENOMEM;
>> >> -             goto err;
>> >> +             return -ENOMEM;
>> >>
>> >>       }
>> >
>> > Umm, I am fairly certain that devm_kzalloc() can't be used as a
>> > substitute for kstrdup, at least not without accompanying memcpy.
>>
>> Yes, I have provided allocation but it should be followed with assig=
nment.
>> Can I modify like this,
>>
>> +     drvdata->desc.name =3D devm_kzalloc(&pdev->dev,
>> +                                       strlen(config->supply_name) =
+ 1,
>> +                                       GFP_KERNEL);
>> +     if (drvdata->desc.name)
>> +     sprintf(drvdata->desc.name, "%s", config->supply_name);
>
> hmm, so you replaced a general helper function by open coding the str=
ing-
> duplication. Doesn't this defeat the target of simplifying the code?

Intention here, is to use devm_ API and to adopt this I have to do thes=
e
modifications for "kstrdup" functions. I have seen in regulator folder =
almost
all drivers adopted to "devm_" API. Hence same thing I am following to
update this driver. Please let me know whether to go ahead with this pa=
tch
or retain driver as it is.

Regards
Manish Badarkhe
