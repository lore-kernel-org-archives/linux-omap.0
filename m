From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCHv2 12/12] ARM: OMAP4: hwmod data: do not enable or reset
 the McPDM during kernel init
Date: Mon, 11 Jun 2012 11:54:23 +0200
Message-ID: <4FD5C04F.2040509@ti.com>
References: <20120611004502.20034.8840.stgit@dusk> <20120611004626.20034.42995.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35419 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752181Ab2FKJya (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 05:54:30 -0400
In-Reply-To: <20120611004626.20034.42995.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?UTF-8?B?UMOpdGVyIFVqZmFsdXNp?= <peter.ujfalusi@ti.com>

On 6/11/2012 2:46 AM, Paul Walmsley wrote:
> Resolve this kernel boot message:
>
> omap_hwmod: mcpdm: cannot be enabled for reset (3)
>
> It appears that the McPDM on OMAP4 can only receive its functional
> clock from an off-chip source.  This source is not guaranteed to be
> present on the board, and when present, it is controlled by I2C.  Thi=
s
> would introduce a board dependency to the early hwmod code which it
> was not designed to handle.  Also, neither the driver for this
> off-chip clock provider nor the I2C code is available early in boot
> when the hwmod code is attempting to enable and reset IP blocks.  Thi=
s
> effectively makes it impossible to enable and reset this device durin=
g
> hwmod init.
>
> At its core, this patch is a workaround for an OMAP hardware problem.
> It should be possible to configure the OMAP to provide any IP block's
> functional clock from an on-chip source.  (This is true for almost
> every IP block on the chip.  As far as I know, McPDM is the only
> exception.)  If the kernel cannot reset and configure IP blocks, it
> cannot guarantee a sane SoC state.  Relying on an optional off-chip
> clock also creates a board dependency which is beyond the scope of th=
e
> early hwmod code.

And I guess, that's a good reason as well to let the driver managing th=
e=20
reset during the probe for such IPs.

> This patch works around the issue by marking the McPDM hwmod record
> with the HWMOD_EXT_OPT_MAIN_CLK flag.  This prevents the hwmod
> code from touching the device early during boot.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: P=C3=A9ter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/ma=
ch-omap2/omap_hwmod_44xx_data.c
> index 3613054..86fc513 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -2091,6 +2091,18 @@ static struct omap_hwmod omap44xx_mcpdm_hwmod =
=3D {
>   	.name		=3D "mcpdm",
>   	.class		=3D &omap44xx_mcpdm_hwmod_class,
>   	.clkdm_name	=3D "abe_clkdm",
> +	/*
> +	 * It's suspected that the McPDM requires an off-chip main
> +	 * functional clock, controlled via I2C.

Nit: Is it not suspected, it is a fact. The clock tree clearly indicate=
=20
that the mcpdm fclk is generated from the pad_clks.
The IP is a custom link for the Audio IC control / data. using the Audi=
o=20
IC as a source clock is standard. Since that IP is done only for that=20
purpose, there is no optional clock path from the PRCM like it is the=20
case for the McASP / McBSP.

>  This IP block is
> +	 * currently reset very early during boot, before I2C is
> +	 * available, so it doesn't seem that we have any choice in
> +	 * the kernel other than to avoid resetting it.  XXX This is
> +	 * really a hardware issue workaround: every IP block should
> +	 * be able to source its main functional clock from either
> +	 * on-chip or off-chip sources.  McPDM seems to be the only
> +	 * current exception.

I do not think this is the right place to put some complaint about the=20
HW :-).
I guess we should just describe the facts.

> +	 */
> +	.flags		=3D HWMOD_EXT_OPT_MAIN_CLK,

Could you please update the hints for this IP in the autogen scripts?
I added a comment attribute to add a custom comment on top of the flags=
=20
entry.
The latest branch is "omap5430_for_3.6".

Thanks,
Benoit


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
