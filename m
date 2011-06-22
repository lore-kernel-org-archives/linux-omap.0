From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH 1/2] OMAP4 :TWL6030: Regulator set the default behavior of LDO's
Date: Wed, 22 Jun 2011 20:00:18 +0530
Message-ID: <BANLkTi=e=weaR070Di_V=7wG7bdUF2pZMQ@mail.gmail.com>
References: <1308702281-12665-1-git-send-email-girishsg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:46715 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758033Ab1FVOaT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Jun 2011 10:30:19 -0400
Received: by mail-yi0-f47.google.com with SMTP id 18so370351yib.6
        for <linux-omap@vger.kernel.org>; Wed, 22 Jun 2011 07:30:19 -0700 (PDT)
In-Reply-To: <1308702281-12665-1-git-send-email-girishsg@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Girish S G <girishsg@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Wed, Jun 22, 2011 at 5:54 AM, Girish S G <girishsg@ti.com> wrote:
> TWL6030 below table shows the default state each LDO's can
> be put into.
>
> =A0 =A0 =A0 =A0+-----------------------------------------------------=
----------+
> =A0 =A0 =A0 =A0| LDO =A0 | =A0 =A0 =A0 Usage =A0 =A0 =A0 =A0 =A0 | =A0=
 =A0 =A0 state =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
> =A0 =A0 =A0 =A0+-----------------------------------------------------=
----------+
> =A0 =A0 =A0 =A0| VANA =A0| sources internal =A0 =A0 =A0| Always ON =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
> =A0 =A0 =A0 =A0| =A0 =A0 =A0 | analog voltage =A0 =A0 =A0 =A0| =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
> =A0 =A0 =A0 =A0+-----------------------------------------------------=
----------+
> =A0 =A0 =A0 =A0| VAUX1 | eMMC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| MM=
C Driver needs to handle =A0 =A0|
> =A0 =A0 =A0 =A0| =A0 =A0 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
> =A0 =A0 =A0 =A0+-----------------------------------------------------=
----------+
> =A0 =A0 =A0 =A0| VAUX2 | A/V switch =A0 =A0 =A0 =A0 =A0 =A0| Driver n=
eeds to handle =A0 =A0 =A0 =A0|
> =A0 =A0 =A0 =A0+-----------------------------------------------------=
----------+
> =A0 =A0 =A0 =A0| VAUX3 | 5MP CAMp =A0 =A0 =A0 =A0 =A0 =A0 =A0| Driver=
 needs to handle =A0 =A0 =A0 =A0|
> =A0 =A0 =A0 =A0+-----------------------------------------------------=
----------+
> =A0 =A0 =A0 =A0| VCXIO | supplies DPLL's =A0 =A0 =A0 | Can be put OFF=
 when OMAP hits |
> =A0 =A0 =A0 =A0| =A0 =A0 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | OFF mode. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
> =A0 =A0 =A0 =A0+-----------------------------------------------------=
----------+
> =A0 =A0 =A0 =A0| VDAC =A0| HDMI, CDC chip =A0 =A0 =A0 =A0| Always ON =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
> =A0 =A0 =A0 =A0+-----------------------------------------------------=
----------+
> =A0 =A0 =A0 =A0| VMMC =A0| MMC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
Driver needs to handle =A0 =A0 =A0 =A0|
> =A0 =A0 =A0 =A0+-----------------------------------------------------=
----------+
> =A0 =A0 =A0 =A0| VPP =A0 | VPP pins of OMAP =A0 =A0 =A0| Used while b=
urning fuses in =A0 |
> =A0 =A0 =A0 =A0| =A0 =A0 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | OMAP. This can be turned OFF =A0|
> =A0 =A0 =A0 =A0| =A0 =A0 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | by default when kernel comes =A0|
> =A0 =A0 =A0 =A0| =A0 =A0 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | up. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
> =A0 =A0 =A0 =A0+-----------------------------------------------------=
----------+
> =A0 =A0 =A0 =A0| VRTC =A0| VBRTC/RTC =A0 =A0 =A0 =A0 =A0 =A0 | Always=
 ON =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
> =A0 =A0 =A0 =A0+-----------------------------------------------------=
----------+
> =A0 =A0 =A0 =A0| VUSB =A0| USB OTG pins =A0 =A0 =A0 =A0 =A0| Driver n=
eeds to handle =A0 =A0 =A0 =A0|
> =A0 =A0 =A0 =A0+-----------------------------------------------------=
----------+
> =A0 =A0 =A0 =A0| VUSIM | VDDS_SIM, SIM cage =A0 =A0| Driver needs to =
handle. =A0 =A0 =A0 |
> =A0 =A0 =A0 =A0+-----------------------------------------------------=
----------+
> =A0 =A0 =A0 =A0| CLK32K| 32KHz o/p clk =A0 =A0 =A0 =A0 | WIFI/BT/FM/G=
PS driver needs =A0 |
> =A0 =A0 =A0 =A0| =A0 =A0 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | to handle =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
> =A0 =A0 =A0 =A0+-----------------------------------------------------=
----------+
>
> =A0- VDAC, VANA, VCXIO and VRTC should be kept always ON. As per the =
table above.
>
> Need REVISIT on below LDO's:
> =A0- VAUX1 kept ON now. MMC driver needs to take care of enabling/dis=
abling
> =A0 as needed. Issue seen with eMMC bootup with VAUX1 disabled by def=
ault.
>
> =A0- VAUX3 is kept ON now. CAM/syslink should handle this regulator. =
This
> =A0 is only for 5MP camera on Blaze.
>
> =A0- CLK32KG is pseudo regulator, on Blaze/panda it supplies GPS/WIFI=
/BT/FM/GPS
> =A0 Drivers should handle it. Keeping it always ON as of now.

description and code changes are not in sync.
vmmc, vana, vdac, vusb is kept as always_on.
Can you try boot_on if it fits you requirement.

--=20
Thanks and Regards,
Balaji T K

>
> Signed-off-by: Girish S G <girishsg@ti.com>
> ---
> =A0arch/arm/mach-omap2/board-4430sdp.c =A0 =A0| =A0 =A04 ++++
> =A0arch/arm/mach-omap2/board-omap4panda.c | =A0 =A03 +++
> =A02 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap=
2/board-4430sdp.c
> index 63de2d3..04b7770 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -440,6 +440,7 @@ static struct regulator_init_data sdp4430_vmmc =3D=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.valid_ops_mask =A0=3D REGULATOR_CHANG=
E_VOLTAGE
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| REGULATOR_CHANGE_MODE
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| REGULATOR_CHANGE_STATUS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .always_on =A0 =A0 =A0=3D true,
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0.num_consumer_supplies =A0=3D 1,
> =A0 =A0 =A0 =A0.consumer_supplies =A0 =A0 =A0=3D sdp4430_vmmc_supply,
> @@ -479,6 +480,7 @@ static struct regulator_init_data sdp4430_vana =3D=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| REGULATOR_MODE_STANDBY,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.valid_ops_mask =A0=3D REGULATOR_CHANG=
E_MODE
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| REGULATOR_CHANGE_STATUS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .always_on =A0 =A0 =A0=3D true,
> =A0 =A0 =A0 =A0},
> =A0};
>
> @@ -501,6 +503,7 @@ static struct regulator_init_data sdp4430_vdac =3D=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| REGULATOR_MODE_STANDBY,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.valid_ops_mask =A0=3D REGULATOR_CHANG=
E_MODE
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| REGULATOR_CHANGE_STATUS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .always_on =A0 =A0 =A0=3D true,
> =A0 =A0 =A0 =A0},
> =A0};
>
> @@ -519,6 +522,7 @@ static struct regulator_init_data sdp4430_vusb =3D=
 {
> =A0static struct regulator_init_data sdp4430_clk32kg =3D {
> =A0 =A0 =A0 =A0.constraints =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.valid_ops_mask =A0 =A0 =A0 =A0 =3D RE=
GULATOR_CHANGE_STATUS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .always_on =A0 =A0 =A0=3D true,
> =A0 =A0 =A0 =A0},
> =A0};
>
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-o=
map2/board-omap4panda.c
> index 0cfe200..3415a5e 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -337,6 +337,7 @@ static struct regulator_init_data omap4_panda_van=
a =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| REGULATOR_MODE_STANDBY,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.valid_ops_mask =A0=3D REGULATOR_CHANG=
E_MODE
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| REGULATOR_CHANGE_STATUS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .always_on =A0 =A0 =A0=3D true,
> =A0 =A0 =A0 =A0},
> =A0};
>
> @@ -359,6 +360,7 @@ static struct regulator_init_data omap4_panda_vda=
c =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| REGULATOR_MODE_STANDBY,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.valid_ops_mask =A0=3D REGULATOR_CHANG=
E_MODE
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| REGULATOR_CHANGE_STATUS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .always_on =A0 =A0 =A0=3D true,
> =A0 =A0 =A0 =A0},
> =A0};
>
> @@ -377,6 +379,7 @@ static struct regulator_init_data omap4_panda_vus=
b =3D {
> =A0static struct regulator_init_data omap4_panda_clk32kg =3D {
> =A0 =A0 =A0 =A0.constraints =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.valid_ops_mask =A0 =A0 =A0 =A0 =3D RE=
GULATOR_CHANGE_STATUS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .always_on =A0 =A0 =A0=3D true,
> =A0 =A0 =A0 =A0},
> =A0};
>
> --
> 1.6.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
