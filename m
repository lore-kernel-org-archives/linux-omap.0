From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCH] OMAP: beagle: Set USB Host Port 1 to OMAP_USBHS_PORT_MODE_UNUSED
Date: Mon, 18 Jun 2012 18:50:25 -0700
Message-ID: <CA+Bv8XZNEf0yGS96edsSJtv0x6PcYh5dUKoHx2T=MLGe3aSPfQ@mail.gmail.com>
References: <1340055775-11427-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:60484 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791Ab2FSBu1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jun 2012 21:50:27 -0400
Received: by lbbgm6 with SMTP id gm6so5099119lbb.19
        for <linux-omap@vger.kernel.org>; Mon, 18 Jun 2012 18:50:25 -0700 (PDT)
In-Reply-To: <1340055775-11427-1-git-send-email-brian.austin@cirrus.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, balbi@ti.com

On Mon, Jun 18, 2012 at 2:42 PM, Brian Austin <brian.austin@cirrus.com>=
 wrote:
> The beagleboard USB Host Port that is used is Port 2. The platform dr=
iver sets MODE_PHY for port 1 causing pin muxing to override the pins o=
n the expansion
> connector P17 when using board_mux[]. Since USBHS Port 1 is not conne=
cted remove the case for muxing the USB Port1 pins by default.
>
> Patch is based off of 3.5-rc2 from ASoC for-next branch
>
> Tested with BeagleBoard xM revC and checked the userguides for Beagle=
 xM and revC to be sure USB Port2 is what is used.
>
> Singed-off-by: Brian Austin <brian.austin@cirrus.com>

You'll probably have to fix your sing/sign typo, but otherwise it looks=
 good

Acked-by: Russ Dill <Russ.Dill@ti.com>

Just for those that might get confused looking at schematics,
port_mode[0] refers to the HSUSB1_* pins, and port_mode[1] refers to
the HSUSB2_* pins.

> ---
> =C2=A0arch/arm/mach-omap2/board-omap3beagle.c | =C2=A0 =C2=A02 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-=
omap2/board-omap3beagle.c
> index 79c6909..75eb88a 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -435,7 +435,7 @@ static struct platform_device *omap3_beagle_devic=
es[] __initdata =3D {
>
> =C2=A0static const struct usbhs_omap_board_data usbhs_bdata __initcon=
st =3D {
>
> - =C2=A0 =C2=A0 =C2=A0 .port_mode[0] =3D OMAP_EHCI_PORT_MODE_PHY,
> + =C2=A0 =C2=A0 =C2=A0 .port_mode[0] =3D OMAP_USBHS_PORT_MODE_UNUSED,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.port_mode[1] =3D OMAP_EHCI_PORT_MODE_PHY,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.port_mode[2] =3D OMAP_USBHS_PORT_MODE_UNU=
SED,
>
> --
> 1.7.10.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
