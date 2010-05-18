From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: [PATCH 14/18] omap: Overo: Add support for second ethernet port
Date: Tue, 18 May 2010 06:41:39 -0700
Message-ID: <AANLkTinxHaxG89pUhD7nmMjQSF-p-FB1FWj_w-de9y1r@mail.gmail.com>
References: <20100505192957.21568.19569.stgit@baageli.muru.com>
	 <20100505193315.21568.55530.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49581 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757513Ab0ERNlk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 09:41:40 -0400
Received: by vws9 with SMTP id 9so2681675vws.19
        for <linux-omap@vger.kernel.org>; Tue, 18 May 2010 06:41:40 -0700 (PDT)
In-Reply-To: <20100505193315.21568.55530.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Wed, May 5, 2010 at 12:33 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> From: Steve Sakoman <steve@sakoman.com>
>
> Some Overo add-on boards include a second ethernet port. =A0This patc=
h
> adds support for that second port.
>
> Signed-off-by: Steve Sakoman <steve@sakoman.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> =A0arch/arm/mach-omap2/board-overo.c | =A0 14 +++++++++++++-
> =A01 files changed, 13 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/=
board-overo.c
> index 8848c7c..79ac414 100644
> --- a/arch/arm/mach-omap2/board-overo.c
> +++ b/arch/arm/mach-omap2/board-overo.c
> @@ -63,6 +63,8 @@
>
> =A0#define OVERO_SMSC911X_CS =A0 =A0 =A05
> =A0#define OVERO_SMSC911X_GPIO =A0 =A0176
> +#define OVERO_SMSC911X2_CS =A0 =A0 4
> +#define OVERO_SMSC911X2_GPIO =A0 65
>
> =A0#if defined(CONFIG_TOUCHSCREEN_ADS7846) || \
> =A0 =A0 =A0 =A0defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
> @@ -137,6 +139,16 @@ static struct resource overo_smsc911x_resources[=
] =3D {
> =A0 =A0 =A0 =A0},
> =A0};
>
> +static struct resource overo_smsc911x2_resources[] =3D {
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "smsc911x2-memory",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_MEM,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_IRQ | IORESOUR=
CE_IRQ_LOWLEVEL,
> + =A0 =A0 =A0 },
> +};
> +
> =A0static struct smsc911x_platform_config overo_smsc911x_config =3D {
> =A0 =A0 =A0 =A0.irq_polarity =A0 =3D SMSC911X_IRQ_POLARITY_ACTIVE_LOW=
,
> =A0 =A0 =A0 =A0.irq_type =A0 =A0 =A0 =3D SMSC911X_IRQ_TYPE_OPEN_DRAIN=
,
> @@ -146,7 +158,7 @@ static struct smsc911x_platform_config overo_smsc=
911x_config =3D {
>
> =A0static struct platform_device overo_smsc911x_device =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "smsc911x",
> - =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D -1,
> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D 0,
> =A0 =A0 =A0 =A0.num_resources =A0=3D ARRAY_SIZE(overo_smsc911x_resour=
ces),
> =A0 =A0 =A0 =A0.resource =A0 =A0 =A0 =3D overo_smsc911x_resources,
> =A0 =A0 =A0 =A0.dev =A0 =A0 =A0 =A0 =A0 =A0=3D {
>
> --

I just noticed that somehow a good portion of my original patch got
dropped in this version!

Original:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26350.html

How would you like to handle getting the missing chuncks?

Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
