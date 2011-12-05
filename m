From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [RFC PATCH v1 2/7] omap4: build fdif omap device from hwmod
Date: Mon, 5 Dec 2011 12:27:11 +0800
Message-ID: <CACVXFVNxX9tHZrdsRw6Wm14g59x44dR1Rm5jLeqxx4m6Jxe5-Q@mail.gmail.com>
References: <1322838172-11149-1-git-send-email-ming.lei@canonical.com>
	<1322838172-11149-3-git-send-email-ming.lei@canonical.com>
	<CAKnK67T9S6Z=f9qmn9ov7YNyTKjdDbOZHJDRO-7_fqkJGZzXbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKnK67T9S6Z=f9qmn9ov7YNyTKjdDbOZHJDRO-7_fqkJGZzXbA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Aguirre, Sergio" <saaguirre@ti.com>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>, Tony Lindgren <tony@atomide.com>, Sylwester Nawrocki <snjw23@gmail.com>, Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Sat, Dec 3, 2011 at 12:28 AM, Aguirre, Sergio <saaguirre@ti.com> wro=
te:
> Hi Ming,
>
> Thanks for the patches.

Thanks for your review.

> On Fri, Dec 2, 2011 at 9:02 AM, Ming Lei <ming.lei@canonical.com> wro=
te:
>> Signed-off-by: Ming Lei <ming.lei@canonical.com>
>> ---
>> =A0arch/arm/mach-omap2/devices.c | =A0 33 ++++++++++++++++++++++++++=
+++++++
>> =A01 files changed, 33 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/dev=
ices.c
>> index 1166bdc..a392af5 100644
>> --- a/arch/arm/mach-omap2/devices.c
>> +++ b/arch/arm/mach-omap2/devices.c
>> @@ -728,6 +728,38 @@ void __init omap242x_init_mmc(struct omap_mmc_p=
latform_data **mmc_data)
>>
>> =A0#endif
>>
>> +static struct platform_device* __init omap4_init_fdif(void)
>> +{
>> + =A0 =A0 =A0 int id =3D -1;
>
> You could remove this , as it is being used only once, and never chan=
ged.

Yes.

>
>> + =A0 =A0 =A0 struct platform_device *pd;
>> + =A0 =A0 =A0 struct omap_hwmod *oh;
>> + =A0 =A0 =A0 const char *dev_name =3D "fdif";
>> +
>> + =A0 =A0 =A0 oh =3D omap_hwmod_lookup("fdif");
>> + =A0 =A0 =A0 if (!oh) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Could not look up fdif hwmod\n=
");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 pd =3D omap_device_build(dev_name, id, oh, NULL, 0, NU=
LL, 0, 0);
>
> Just do:
>
> pd =3D omap_device_build(dev_name, -1, oh, NULL, 0, NULL, 0, 0);
>
>> + =A0 =A0 =A0 WARN(IS_ERR(pd), "Can't build omap_device for %s.\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_na=
me);
>> + =A0 =A0 =A0 return pd;
>> +}
>> +
>> +static void __init omap_init_fdif(void)
>> +{
>> + =A0 =A0 =A0 if (cpu_is_omap44xx()) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct platform_device *pd;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd =3D omap4_init_fdif();
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!pd)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_enable(&pd->dev);
>> + =A0 =A0 =A0 }
>> +}
>
> IMHO, you could reduce 1 level of indentation here, like this:
>
> static void __init omap_init_fdif(void)
> {
> =A0 =A0 =A0 =A0struct platform_device *pd;
>
> =A0 =A0 =A0 =A0if (!cpu_is_omap44xx())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> =A0 =A0 =A0 =A0pd =3D omap4_init_fdif();
> =A0 =A0 =A0 =A0if (!pd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> =A0 =A0 =A0 =A0pm_runtime_enable(&pd->dev);
> }

OK, will take this.

thanks,
--
Ming Lei
