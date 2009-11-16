From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/3] OMAP clock/hwmod: fix off-by-one errors
Date: Mon, 16 Nov 2009 14:08:30 +0000
Message-ID: <20091116140830.GA31522@n2100.arm.linux.org.uk>
References: <20091116133237.14128.39687.stgit@localhost.localdomain> <20091116133654.14128.175.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34073 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738AbZKPOIs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Nov 2009 09:08:48 -0500
Content-Disposition: inline
In-Reply-To: <20091116133654.14128.175.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.infradead.org, Juha =?iso-8859-1?Q?Lepp=E4nen?= <juha_motorsportcom@luukku.com>, linux-omap@vger.kernel.org

On Mon, Nov 16, 2009 at 06:36:55AM -0700, Paul Walmsley wrote:
> Fix loop bailout off-by-one bugs reported by Juha Lepp=E4nen
> <juha_motorsportcom@luukku.com>.

I'm not sure the new code is any easier to read than the old code.
And what with some checks post-loop being <=3D and others being >, it's
a recipe for cut'n'paste errors happening.

> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/o=
map_hwmod.c
> index 633b216..a4a9518 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -759,14 +759,12 @@ static int _reset(struct omap_hwmod *oh)
>  	_write_sysconfig(v, oh);
> =20
>  	c =3D 0;
> -	while (c < MAX_MODULE_RESET_WAIT &&
> -	       !(omap_hwmod_readl(oh, oh->sysconfig->syss_offs) &
> -		 SYSS_RESETDONE_MASK)) {
> +	while (!(omap_hwmod_readl(oh, oh->sysconfig->syss_offs) &
> +		 SYSS_RESETDONE_MASK) &&
> +	       (c++ < MAX_MODULE_RESET_WAIT))
>  		udelay(1);
> -		c++;
> -	}
> =20
> -	if (c =3D=3D MAX_MODULE_RESET_WAIT)
> +	if (c > MAX_MODULE_RESET_WAIT)
>  		WARN(1, "omap_hwmod: %s: failed to reset in %d usec\n",
>  		     oh->name, MAX_MODULE_RESET_WAIT);
>  	else

How about:

	for (c =3D 0; c <=3D MAX_MODULE_RESET_WAIT; c++) {
		if (omap_hwmod_readl(oh, oh->sysconfig->syss_offs) &
		    SYSS_RESETDONE_MASK) {
			pr_debug("omap_hwmod: %s: reset in %d usec\n",
				oh->name, c);
			return 0;
		}
	}

	WARN(1, "omap_hwmod: %s: failed to reset in %d usec\n",
                     oh->name, c - 1);
	return -ETIMEDOUT;

?

Even better would be to turn this into a helper much like wait_event(),
which would stop silly mistakes happening.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
