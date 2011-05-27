From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] free rev gpios when they are read, so others can read
 them later
Date: Fri, 27 May 2011 14:28:09 +0300
Message-ID: <4DDF8AC9.60709@compulab.co.il>
References: <1306438716-68265-1-git-send-email-tasskjapp@gmail.com> <2DCF0893-4166-4604-887B-EDBC3643290A@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:36910
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752757Ab1E0L2K convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 May 2011 07:28:10 -0400
In-Reply-To: <2DCF0893-4166-4604-887B-EDBC3643290A@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tasslehoff Kjappfot <tasskjapp@gmail.com>
Cc: linux-omap@vger.kernel.org

Hi Tasslehoff,

On 05/26/11 22:59, Tasslehoff Kjappfot wrote:
> A script of mine that reads the rev gpios on the beagleboard started =
failing when I upgraded to .37, since board-omap3beagle.c doesn=B4t fre=
e the rev gpios after using them.
>
> Signed-off-by: Tasslehoff Kjappfot <tasskjapp@gmail.com>
> ---
> arch/arm/mach-omap2/board-omap3beagle.c |    3 +++
> 1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-=
omap2/board-omap3beagle.c
> index 3ff3a2c..8a4ac43 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -106,6 +106,9 @@ static void __init omap3_beagle_init_rev(void)
> 	beagle_rev =3D gpio_get_value(171) | (gpio_get_value(172) << 1)
> 			| (gpio_get_value(173) << 2);
>
> +        gpio_free_array(omap3_beagle_rev_gpios,
> +                        ARRAY_SIZE(omap3_beagle_rev_gpios));
> +

To be consistent with the rest of the file,
can the white space here be "tabs" instead of spaces?


--=20
Regards,
Igor.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
