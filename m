From: Alexander Shishkin <virtuoso@slind.org>
Subject: Re: [PATCHV5 1/4] OMAP3: introduce DPLL4 Jtype
Date: Mon, 18 Jan 2010 12:17:30 +0200
Message-ID: <20100118101730.GL29059@shisha.kicks-ass.net>
References: <1263803362-7083-1-git-send-email-vishwanath.bs@ti.com>
 <1263803362-7083-2-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:50620 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397Ab0ARKSX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jan 2010 05:18:23 -0500
Content-Disposition: inline
In-Reply-To: <1263803362-7083-2-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Richard Woodruff <r-woodruff2@ti.com>, Nishanth Menon <nm@ti.com>

On Man, Jan 18, 2010 at 01:59:19 +0530, Vishwanath BS wrote:
> DPLL4 for 3630 introduces a changed block called j type dpll, requiring
> special divisor bits and additional reg fields. To allow for silicons to
> use this, this is introduced as a flag and is enabled for 3630 silicon.
> OMAP4 also has j type dpll for usb.
> 
> Tested with 3630 ZOOM3 and OMAP3430 ZOOM2
[snip]

> +/* A new flag called flag has been added which indiciates what is the type
> +  * of dpll (like j_type, no_dco_sel)
> +  */
> +

I think this comment block violates coding style.

Regards,
--
Alex
