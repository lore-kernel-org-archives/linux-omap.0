From: =?UTF-8?B?UMOpdGVyIFVqZmFsdXNp?= <peter.ujfalusi@ti.com>
Subject: Re: [PATCHv2 12/12] ARM: OMAP4: hwmod data: do not enable or reset
 the McPDM during kernel init
Date: Tue, 30 Oct 2012 08:41:01 +0100
Message-ID: <508F848D.3070609@ti.com>
References: <20120611004502.20034.8840.stgit@dusk> <20120611004626.20034.42995.stgit@dusk> <4FD5C04F.2040509@ti.com> <alpine.DEB.2.00.1210300403170.12697@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60447 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755300Ab2J3HlI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Oct 2012 03:41:08 -0400
In-Reply-To: <alpine.DEB.2.00.1210300403170.12697@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Paul,

On 10/30/2012 05:05 AM, Paul Walmsley wrote:
> omap_hwmod: mcpdm: cannot be enabled for reset (3)
>=20
> The McPDM on OMAP4 can only receive its functional clock from an
> off-chip source.  This source is not guaranteed to be present on the
> board, and when present, it is controlled by I2C.  This would
> introduce a board dependency to the early hwmod code which it was not
> designed to handle.  Also, neither the driver for this off-chip clock
> provider nor the I2C code is available early in boot when the hwmod
> code is attempting to enable and reset IP blocks.  This effectively
> makes it impossible to enable and reset this device during hwmod init=
=2E
>=20
> At its core, this patch is a workaround for an OMAP hardware problem.
> It should be possible to configure the OMAP to provide any IP block's
> functional clock from an on-chip source.  (This is true for almost
> every IP block on the chip.  As far as I know, McPDM is the only
> exception.)  If the kernel cannot reset and configure IP blocks, it
> cannot guarantee a sane SoC state.  Relying on an optional off-chip
> clock also creates a board dependency which is beyond the scope of th=
e
> early hwmod code.
>=20
> This patch works around the issue by marking the McPDM hwmod record
> with the HWMOD_EXT_OPT_MAIN_CLK flag.  This prevents the hwmod
> code from touching the device early during boot.
>=20
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: P=C3=A9ter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/ma=
ch-omap2/omap_hwmod_44xx_data.c
> index 652d028..7bddfa5 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -2125,6 +2125,14 @@ static struct omap_hwmod omap44xx_mcpdm_hwmod =
=3D {
>  	.name		=3D "mcpdm",
>  	.class		=3D &omap44xx_mcpdm_hwmod_class,
>  	.clkdm_name	=3D "abe_clkdm",
> +	/*
> +	 * It's suspected that the McPDM requires an off-chip main
> +	 * functional clock, controlled via I2C.  This IP block is
> +	 * currently reset very early during boot, before I2C is
> +	 * available, so it doesn't seem that we have any choice in
> +	 * the kernel other than to avoid resetting it.
> +	 */
> +	.flags		=3D HWMOD_EXT_OPT_MAIN_CLK,
>  	.mpu_irqs	=3D omap44xx_mcpdm_irqs,
>  	.sdma_reqs	=3D omap44xx_mcpdm_sdma_reqs,
>  	.main_clk	=3D "mcpdm_fck",
>=20


--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
