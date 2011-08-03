From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [alsa-devel] [PATCH 4/4] ASoC: OMAP4: McPDM: Convert to hwmod/omap_device
Date: Wed, 3 Aug 2011 10:58:13 +0300
Message-ID: <1433314.EB2v33lUYq@barack>
References: <1312284857-1774-1-git-send-email-peter.ujfalusi@ti.com> <1312284857-1774-5-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37741 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751993Ab1HCH6T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Aug 2011 03:58:19 -0400
In-Reply-To: <1312284857-1774-5-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: "Girdwood, Liam" <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Guiriec, Sebastien" <s-guiriec@ti.com>, "Sebastien@alsa-project.org" <Sebastien@alsa-project.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>, "Misael@alsa-project.org" <Misael@alsa-project.org>

On Tuesday 02 August 2011 13:34:17 Ujfalusi, Peter wrote:
> In order to probe, and operate correctly, the OMAP McPDM driver needs=
 to
> be converted to use hwmod.
> The device name has been changed to probe the driver.
> Replace the clk_* with pm_runtime_* calls to manage the clocks correc=
tly.
> Missing request_mem_region/release_mem_region added.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  sound/soc/omap/mcpdm.c      |   38 +++++++++++++++++++++------------=
-----
>  sound/soc/omap/mcpdm.h      |    1 -
>  sound/soc/omap/omap-mcpdm.c |    2 +-
>  sound/soc/omap/sdp4430.c    |    2 +-
>  4 files changed, 23 insertions(+), 20 deletions(-)
>=20
> diff --git a/sound/soc/omap/mcpdm.c b/sound/soc/omap/mcpdm.c
> index 928f037..d29cc98 100644
> --- a/sound/soc/omap/mcpdm.c
> +++ b/sound/soc/omap/mcpdm.c
> @@ -28,7 +28,7 @@
>  #include <linux/slab.h>
>  #include <linux/interrupt.h>
>  #include <linux/err.h>
> -#include <linux/clk.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/irq.h>
> @@ -322,11 +322,11 @@ static irqreturn_t omap_mcpdm_irq_handler(int i=
rq,
> void *dev_id) return IRQ_HANDLED;
>  }
>=20
> -int omap_mcpdm_request(void)
> +			int omap_mcpdm_request(void)

Just noticed this one.
Going to resend, or Liam can you fix this up when you take the patches?

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
