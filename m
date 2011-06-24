From: Jaswinder Singh <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] OMAP4: PANDA, SDP: Fix EHCI regulator supply
Date: Fri, 24 Jun 2011 22:37:56 +0530
Message-ID: <BANLkTin=-cRC_ax8AakMD1UZtU+AQ0H==w@mail.gmail.com>
References: <1308926240-13888-1-git-send-email-jaswinder.singh@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50193 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638Ab1FXRH6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jun 2011 13:07:58 -0400
Received: by bwz15 with SMTP id 15so2336615bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 10:07:56 -0700 (PDT)
In-Reply-To: <1308926240-13888-1-git-send-email-jaswinder.singh@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: patches@linaro.org, balbi@ti.com, tony@atomide.com, Jassi Brar <jaswinder.singh@linaro.org>, lrg@ti.com, Mark Brown <broonie@opensource.wolfsonmicro.com>

[CC'ing Liam and Mark as well]

On 24 June 2011 20:07, Jassi Brar <jaswinder.singh@linaro.org> wrote:
> VUSB is a fixed level line and hence have no set_voltage
> callback in regulator ops, but has apply_uV set to true.
> As a result it fails to register with the regulator core.
> Remove setting apply_uV.
>
> Also, assign name to VUSB supply, without which regulator core
> fails to find it and assigns the default 'dummy' regulator to
> the ehci-omap device.
>
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> ---
> =C2=A0arch/arm/mach-omap2/board-4430sdp.c =C2=A0 =C2=A0| =C2=A0 =C2=A0=
6 +++++-
> =C2=A0arch/arm/mach-omap2/board-omap4panda.c | =C2=A0 =C2=A06 +++++-
> =C2=A02 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap=
2/board-4430sdp.c
> index 63de2d3..1ec60be 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -504,16 +504,20 @@ static struct regulator_init_data sdp4430_vdac =
=3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> =C2=A0};
>
> +static struct regulator_consumer_supply sdp4430_vusb_supply =3D
> + =C2=A0 =C2=A0 =C2=A0 REGULATOR_SUPPLY("hsusb0", "ehci-omap.0");
> +
> =C2=A0static struct regulator_init_data sdp4430_vusb =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.constraints =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.min_uV =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 3300000,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.max_uV =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 3300000,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .apply_uV =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D true,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.valid_modes_m=
ask =C2=A0 =C2=A0 =C2=A0 =3D REGULATOR_MODE_NORMAL
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 REGULATOR_MODE_STANDBY,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.valid_ops_mas=
k =C2=A0=3D =C2=A0 =C2=A0 =C2=A0REGULATOR_CHANGE_MODE
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 REGULATOR_CHANGE_STATUS,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> + =C2=A0 =C2=A0 =C2=A0 .num_consumer_supplies =C2=A0=3D 1,
> + =C2=A0 =C2=A0 =C2=A0 .consumer_supplies =C2=A0 =C2=A0 =C2=A0=3D &sd=
p4430_vusb_supply,
> =C2=A0};
>
> =C2=A0static struct regulator_init_data sdp4430_clk32kg =3D {
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-o=
map2/board-omap4panda.c
> index d4f9879..7429f7e 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -362,16 +362,20 @@ static struct regulator_init_data omap4_panda_v=
dac =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> =C2=A0};
>
> +static struct regulator_consumer_supply omap4_panda_vusb_supply =3D
> + =C2=A0 =C2=A0 =C2=A0 REGULATOR_SUPPLY("hsusb0", "ehci-omap.0");
> +
> =C2=A0static struct regulator_init_data omap4_panda_vusb =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.constraints =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.min_uV =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 3300000,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.max_uV =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 3300000,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .apply_uV =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D true,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.valid_modes_m=
ask =C2=A0 =C2=A0 =C2=A0 =3D REGULATOR_MODE_NORMAL
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 REGULATOR_MODE_STANDBY,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.valid_ops_mas=
k =C2=A0=3D =C2=A0 =C2=A0 =C2=A0REGULATOR_CHANGE_MODE
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 REGULATOR_CHANGE_STATUS,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> + =C2=A0 =C2=A0 =C2=A0 .num_consumer_supplies =C2=A0=3D 1,
> + =C2=A0 =C2=A0 =C2=A0 .consumer_supplies =C2=A0 =C2=A0 =C2=A0=3D &om=
ap4_panda_vusb_supply,
> =C2=A0};
>
> =C2=A0static struct regulator_init_data omap4_panda_clk32kg =3D {
> --
> 1.7.4.1
>
>



--=20
Linaro.org =E2=94=82 Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106 =C2=A0-
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
