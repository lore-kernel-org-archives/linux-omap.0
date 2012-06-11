From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCHv2 04/12] ARM: OMAP4: hwmod data: fix 32k sync timer idle
 modes
Date: Mon, 11 Jun 2012 11:31:19 +0200
Message-ID: <4FD5BAE7.7080805@ti.com>
References: <20120611004502.20034.8840.stgit@dusk> <20120611004602.20034.73590.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57666 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751131Ab2FKJbY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 05:31:24 -0400
In-Reply-To: <20120611004602.20034.73590.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>

On 6/11/2012 2:46 AM, Paul Walmsley wrote:
> The 32k sync timer IP block target idle modes are incorrect in the
> hwmod data are incorrect.

Nit: Is there too many "incorrect" in this sentence?

> The IP block does not support any
> smart-idle modes.  Update the data to reflect the correct modes.
>
> This problem was initially identified and a diff fragment posted to
> the lists by Beno=C3=AEt Cousson <b-cousson@ti.com>.

Thanks for taking care of that patch.

Benoit

>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/ma=
ch-omap2/omap_hwmod_44xx_data.c
> index 4aaaa84..6b0aedc 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -393,8 +393,7 @@ static struct omap_hwmod_class_sysconfig omap44xx=
_counter_sysc =3D {
>   	.rev_offs	=3D 0x0000,
>   	.sysc_offs	=3D 0x0004,
>   	.sysc_flags	=3D SYSC_HAS_SIDLEMODE,
> -	.idlemodes	=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
> -			   SIDLE_SMART_WKUP),
> +	.idlemodes	=3D (SIDLE_FORCE | SIDLE_NO),
>   	.sysc_fields	=3D &omap_hwmod_sysc_type1,
>   };
>
>
>


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
