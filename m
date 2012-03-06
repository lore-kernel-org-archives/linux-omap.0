From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/3] arm: fix compile error in mach-omap2/board-omap4panda.c
Date: Tue, 06 Mar 2012 13:03:38 +0200
Message-ID: <4F55EF0A.1070309@ti.com>
References: <1330987310-8108-1-git-send-email-paul.gortmaker@windriver.com> <1330987310-8108-3-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:47456 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757006Ab2CFLDo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Mar 2012 06:03:44 -0500
Received: by lagj5 with SMTP id j5so5889678lag.3
        for <linux-omap@vger.kernel.org>; Tue, 06 Mar 2012 03:03:42 -0800 (PST)
In-Reply-To: <1330987310-8108-3-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-next@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Hi,

On 03/06/2012 12:41 AM, Paul Gortmaker wrote:
> The commit 3c90c98a1ebbb08d95700ce8a3b7bce6286607bd (linux-next)
>=20
>     "OMAP4: omap4panda: Enable audio support"
>=20
> introduced population of a new struct, but chose the wrong (but
> similarly named) struct that has none of the named fields.
>=20
> Change it to the struct with those fields, to fix:
>=20
> arch/arm/mach-omap2/board-omap4panda.c:284: error: unknown field 'hs_=
left_step' specified in initializer
> arch/arm/mach-omap2/board-omap4panda.c:285: error: unknown field 'hs_=
right_step' specified in initializer
> arch/arm/mach-omap2/board-omap4panda.c:286: error: unknown field 'hf_=
left_step' specified in initializer
> arch/arm/mach-omap2/board-omap4panda.c:287: error: unknown field 'hf_=
right_step' specified in initializer
> arch/arm/mach-omap2/board-omap4panda.c:287: warning: large integer im=
plicitly truncated to unsigned type

Yes, I have also noticed it.
This is because part of the twl6040 i2c conversion series has been take=
n
by Samuel.
He will stop carrying it further (I hope), and we are going to have a
bit different series going via audio.
Samuel did not took the panda part of the patches since it had some
other dependencies coming via audio tree.

The thing is that the panda audio support is coming via ASoC to
linux-next, so Samuel could not take the patch addressing this breakage
(mfd tree does not have the needed patches).

I'm not sure where we could apply this patch in the first place since
mfd does not have the panda audio support patches, and currently the
ASoC does not have the twl6040 i2c conversion patches either...

> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> CC: Peter Ujfalusi <peter.ujfalusi@ti.com>
> CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
> CC: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/board-omap4panda.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-o=
map2/board-omap4panda.c
> index c1a852d..e919153 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -279,7 +279,7 @@ static int __init omap4_twl6030_hsmmc_init(struct=
 omap2_hsmmc_info *controllers)
>  	return 0;
>  }
> =20
> -static struct twl4030_codec_data twl6040_codec =3D {
> +static struct twl6040_codec_data twl6040_codec =3D {
>  	/* single-step ramp for headset and handsfree */
>  	.hs_left_step	=3D 0x0f,
>  	.hs_right_step	=3D 0x0f,


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
