From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [RFC PATCH 04/11] OMAP: Add early device for system control module
Date: Mon, 28 May 2012 15:28:20 +0530
Message-ID: <CAMQu2gyVZ8iq3S=WMXNNaw6PtrcggRkoOEOpM9nL-Ngy+SoRfQ@mail.gmail.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com> <1337934361-1606-5-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:59323 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751938Ab2E1J6m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 May 2012 05:58:42 -0400
Received: by qadb17 with SMTP id b17so1002916qad.5
        for <linux-omap@vger.kernel.org>; Mon, 28 May 2012 02:58:40 -0700 (PDT)
In-Reply-To: <1337934361-1606-5-git-send-email-eduardo.valentin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: b-cousson@ti.com, kishon@ti.com, kbaidarov@dev.rtsoft.ru, tony@atomide.com, paul@pwsan.com, balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org

On Fri, May 25, 2012 at 1:55 PM, Eduardo Valentin
<eduardo.valentin@ti.com> wrote:
> This is a way to add an early device for system control module.
> the code is also requesting for driver registration and probing.
> Done at early_initcall because at that time, ioremapping is possible.
>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> ---
> =A0arch/arm/mach-omap2/devices.c | =A0 29 +++++++++++++++++++++++++++=
++
> =A01 files changed, 29 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devi=
ces.c
> index 9332673..58cc5c3 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -40,6 +40,35 @@
> =A0#define L3_MODULES_MAX_LEN 12
> =A0#define L3_MODULES 3
>
> +static struct resource control_resources[] =3D {
> + =A0 =A0 =A0 [0] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D 0x4a002000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D 0x4a0027ff,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_MEM,
> + =A0 =A0 =A0 },
> +};
> +static struct platform_device control_device =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "omap-control-core",
> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D 0,
> + =A0 =A0 =A0 .resource =A0 =A0 =A0 =3D control_resources,
> + =A0 =A0 =A0 .num_resources =A0=3D ARRAY_SIZE(control_resources),
> +};
> +
> +static struct platform_device *early_devices[] __initdata =3D {
> + =A0 =A0 =A0 &control_device,
> +};
> +
> +static int __init plat_early_device_setup(void)
> +{
> + =A0 =A0 =A0 early_platform_add_devices(early_devices,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
ARRAY_SIZE(early_devices));
> + =A0 =A0 =A0 early_platform_driver_register_all("early_omap_control"=
);
> + =A0 =A0 =A0 early_platform_driver_probe("early_omap_control", 1, fa=
lse);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +early_initcall(plat_early_device_setup);
> +
> =A0static int omap_init_control(void)
> =A0{
> =A0 =A0 =A0 =A0struct omap_hwmod =A0 =A0 =A0 =A0 =A0 =A0 =A0 *oh;

Nice !!
Apart from fix from Konstantin and Benoit's DT comment,
patch looks fine to me.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
