From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: hwmod code: convert missing clockdomain
 warnings to debug messages
Date: Tue, 18 Sep 2012 16:50:39 -0500
Message-ID: <5058ECAF.7010609@ti.com>
References: <20120918211146.16484.85893.stgit@dusk.lan> <20120918211251.16484.18401.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51572 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755734Ab2IRVuo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Sep 2012 17:50:44 -0400
In-Reply-To: <20120918211251.16484.18401.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Paul,

On 9/18/2012 4:12 PM, Paul Walmsley wrote:
> The decision was made a few months ago to allow struct omap_hwmod
> records and struct clk records to omit clockdomain information if the
> clockdomain is not software-controllable.  See for example commit
> 868c157df9721675c19729eed2c96bac6c3f1d01 ("ARM: OMAP2+: hwmod: remove
> prm_clkdm, cm_clkdm; allow hwmods to have no clockdomain").
>
> So convert an existing pr_warning() to a pr_debug() (regarding missin=
g
> clockdomains in clocks), and add a pr_debug() for missing hwmod
> clockdomains.

At some point I sent you a small RFC to still keep the message if=20
neither oh->clkdm nor oh->_clk->clkdm was there. I've never had the tim=
e=20
to test it, but that should then cover OMAP2, 3 & 4 cases.

Regards,
Benoit

>  It's still useful to enable these messages for
> debugging, since missing clockdomains can cause hard-to-debug problem=
s
> with power management; see for example commit
> 6c4a057bffe9823221eab547e11fac181dc18a2b ("ARM: OMAP4: clock data:
> Force a DPLL clkdm/pwrdm ON before a relock").
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod.c |    8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/o=
map_hwmod.c
> index 80cea5b..e05228a 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -685,8 +685,8 @@ static int _init_main_clk(struct omap_hwmod *oh)
>   	}
>
>   	if (!oh->_clk->clkdm)
> -		pr_warning("omap_hwmod: %s: missing clockdomain for %s.\n",
> -			   oh->main_clk, oh->_clk->name);
> +		pr_debug("omap_hwmod: %s: missing clockdomain for %s.\n",
> +			 oh->main_clk, oh->_clk->name);
>
>   	return ret;
>   }
> @@ -1380,8 +1380,10 @@ static struct omap_hwmod *_lookup(const char *=
name)
>    */
>   static int _init_clkdm(struct omap_hwmod *oh)
>   {
> -	if (!oh->clkdm_name)
> +	if (!oh->clkdm_name) {
> +		pr_debug("omap_hwmod: %s: missing clockdomain\n", oh->name);
>   		return 0;
> +	}
>
>   	oh->clkdm =3D clkdm_lookup(oh->clkdm_name);
>   	if (!oh->clkdm) {
>
>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
