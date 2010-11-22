From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v4 2/3] omap4: opp: add OPP table data
Date: Mon, 22 Nov 2010 15:19:41 -0800
Message-ID: <87aal1kktu.fsf@deeprootsystems.com>
References: <1289933661-19505-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:40452 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757749Ab0KVXTn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 18:19:43 -0500
Received: by pva4 with SMTP id 4so161799pva.19
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 15:19:43 -0800 (PST)
In-Reply-To: <1289933661-19505-3-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Tue, 16 Nov 2010 12:54:20 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony <tony@atomide.com>, Thomas <thomas.petazzoni@free-electrons.com>

Nishanth Menon <nm@ti.com> writes:

> This patch adds OPP tables for OMAP4. New file has been added to keep
> the OMAP4 opp tables and the registration of these tables with the
> generic opp framework by OMAP SoC OPP interface.

[...]

> diff --git a/arch/arm/mach-omap2/opp.c b/arch/arm/mach-omap2/opp.c
> index 66e12be..48a553f 100644
> --- a/arch/arm/mach-omap2/opp.c
> +++ b/arch/arm/mach-omap2/opp.c
> @@ -131,4 +131,5 @@ static int __init omap_init_opp_table(struct omap_opp_def *opp_def,
>  
>  /* omap3 opps */
>  #include "opp3xxx_data.c"
> -
> +/* omap4 opps */
> +#include "opp4xxx_data.c"

I'm not sure I like the including of C files.  Any reason you prefer
this to just adding them to the Makefile?  e.g. opp24xx_dta.c are
compiled in via Makefile and these two are included.

I vote for consistency.

Kevin
