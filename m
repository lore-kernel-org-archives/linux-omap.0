From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: Re: [RFC PATCH v1 2/7] omap4: build fdif omap device from hwmod
Date: Fri, 2 Dec 2011 10:28:42 -0600
Message-ID: <CAKnK67T9S6Z=f9qmn9ov7YNyTKjdDbOZHJDRO-7_fqkJGZzXbA@mail.gmail.com>
References: <1322838172-11149-1-git-send-email-ming.lei@canonical.com> <1322838172-11149-3-git-send-email-ming.lei@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1322838172-11149-3-git-send-email-ming.lei@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>, Tony Lindgren <tony@atomide.com>, Sylwester Nawrocki <snjw23@gmail.com>, Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Ming,

Thanks for the patches.

On Fri, Dec 2, 2011 at 9:02 AM, Ming Lei <ming.lei@canonical.com> wrote=
:
> Signed-off-by: Ming Lei <ming.lei@canonical.com>
> ---
> =A0arch/arm/mach-omap2/devices.c | =A0 33 +++++++++++++++++++++++++++=
++++++
> =A01 files changed, 33 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devi=
ces.c
> index 1166bdc..a392af5 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -728,6 +728,38 @@ void __init omap242x_init_mmc(struct omap_mmc_pl=
atform_data **mmc_data)
>
> =A0#endif
>
> +static struct platform_device* __init omap4_init_fdif(void)
> +{
> + =A0 =A0 =A0 int id =3D -1;

You could remove this , as it is being used only once, and never change=
d.

> + =A0 =A0 =A0 struct platform_device *pd;
> + =A0 =A0 =A0 struct omap_hwmod *oh;
> + =A0 =A0 =A0 const char *dev_name =3D "fdif";
> +
> + =A0 =A0 =A0 oh =3D omap_hwmod_lookup("fdif");
> + =A0 =A0 =A0 if (!oh) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Could not look up fdif hwmod\n"=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 pd =3D omap_device_build(dev_name, id, oh, NULL, 0, NUL=
L, 0, 0);

Just do:

pd =3D omap_device_build(dev_name, -1, oh, NULL, 0, NULL, 0, 0);

> + =A0 =A0 =A0 WARN(IS_ERR(pd), "Can't build omap_device for %s.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_nam=
e);
> + =A0 =A0 =A0 return pd;
> +}
> +
> +static void __init omap_init_fdif(void)
> +{
> + =A0 =A0 =A0 if (cpu_is_omap44xx()) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct platform_device *pd;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd =3D omap4_init_fdif();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!pd)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_enable(&pd->dev);
> + =A0 =A0 =A0 }
> +}

IMHO, you could reduce 1 level of indentation here, like this:

static void __init omap_init_fdif(void)
{
	struct platform_device *pd;

	if (!cpu_is_omap44xx())
		return;

	pd =3D omap4_init_fdif();
	if (!pd)
		return;

	pm_runtime_enable(&pd->dev);
}

Regards,
Sergio

> +
> =A0/*----------------------------------------------------------------=
---------*/
>
> =A0#if defined(CONFIG_HDQ_MASTER_OMAP) || defined(CONFIG_HDQ_MASTER_O=
MAP_MODULE)
> @@ -808,6 +840,7 @@ static int __init omap2_init_devices(void)
> =A0 =A0 =A0 =A0omap_init_sham();
> =A0 =A0 =A0 =A0omap_init_aes();
> =A0 =A0 =A0 =A0omap_init_vout();
> + =A0 =A0 =A0 omap_init_fdif();
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-media=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
