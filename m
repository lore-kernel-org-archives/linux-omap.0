From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: board-4430sdp: MUX configuration for sys_nirq2
Date: Fri, 06 Jul 2012 14:59:29 +0200
Message-ID: <4FF6E131.1030008@ti.com>
References: <1341564590-14024-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:55282 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754778Ab2GFM7M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jul 2012 08:59:12 -0400
Received: by obcva7 with SMTP id va7so14720020obc.6
        for <linux-omap@vger.kernel.org>; Fri, 06 Jul 2012 05:59:11 -0700 (PDT)
In-Reply-To: <1341564590-14024-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On 07/06/2012 10:49 AM, Peter Ujfalusi wrote:
> The sys_nirq2 is used for twl6040, make sure the pin is configured
> correctly.

Please ignore this two patch, I'll resend them with the correct MUX con=
fig.
By mistake I have set MUX_MODE1, while it must be set MUX_MODE0.
It was working with MUX_MODE1, but it is not aligned with the TRM...

Sorry,
P=E9ter

>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  arch/arm/mach-omap2/board-4430sdp.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap=
2/board-4430sdp.c
> index c4e17641..050cc8e 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -827,6 +827,9 @@ static void __init omap_4430sdp_display_init(void=
)
>  #ifdef CONFIG_OMAP_MUX
>  static struct omap_board_mux board_mux[] __initdata =3D {
>  	OMAP4_MUX(USBB2_ULPITLL_CLK, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
> +	/* NIRQ2 for twl6040 */
> +	OMAP4_MUX(SYS_NIRQ2, OMAP_MUX_MODE1 |
> +		  OMAP_PIN_INPUT_PULLUP | OMAP_PIN_OFF_WAKEUPENABLE),
>  	{ .reg_offset =3D OMAP_MUX_TERMINATOR },
>  };
> =20
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
