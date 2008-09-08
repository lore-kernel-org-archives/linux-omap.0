From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH] omapfb: setting GOLCD bit for shadow registers to make effect
Date: Mon, 08 Sep 2008 21:02:56 +0100
Message-ID: <yw1xtzcq76dr.fsf@thrashbarg.mansr.com>
References: <c656a4d20809080219q545ccff3v13221d2287f6de30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:38413 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752996AbYIHUDM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Sep 2008 16:03:12 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Kcmwy-00062y-Hh
	for linux-omap@vger.kernel.org; Mon, 08 Sep 2008 20:03:04 +0000
Received: from thrashbarg.mansr.com ([78.86.181.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Mon, 08 Sep 2008 20:03:04 +0000
Received: from mans by thrashbarg.mansr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Mon, 08 Sep 2008 20:03:04 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

"arun c" <arunedarath@mistralsolutions.com> writes:

> A shadow register change has no direct effect on the display
> configuration until the GOLCD (DISPC_CONTROL[5]) is set.
>
> Signed-off-by: Arun C <arunedarath@mistralsolutions.com>
> ---
>  drivers/video/omap/dispc.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
> index 82ba030..2e7af85 100644
> --- a/drivers/video/omap/dispc.c
> +++ b/drivers/video/omap/dispc.c
> @@ -436,6 +436,11 @@ static inline int _setup_plane(int plane, int ch=
annel_out,
>
>  	dispc_write_reg(ri_reg[plane], (screen_width - width) * bpp / 8 + 1=
);
>
> +	/* Wait untill GOLCD bit is cleared and set it */

Nit: "until" (one l)

> +	while (dispc_read_reg(DISPC_CONTROL) & (1 << 5))
> +		continue;
> +	MOD_REG_FLD(DISPC_CONTROL, 1 << 5, 1 << 5);
> +
>  	return height * screen_width * bpp / 8;
>  }

This looks good.  However, the same thing is needed in
omap_dispc_enable_plane() as well.  Placing the loop+set in a function
(go_lcd()?) would make sense.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
