From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: McBSP: Add support for omap4 in McBSP
 driver
Date: Wed, 12 May 2010 11:15:08 +0300
Message-ID: <20100512111508.48780edb.jhnikula@gmail.com>
References: <1273108546-2507-1-git-send-email-jorge.candelaria@ti.com>
	<1273108546-2507-2-git-send-email-jorge.candelaria@ti.com>
	<1273108546-2507-3-git-send-email-jorge.candelaria@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:63441 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547Ab0ELINf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 May 2010 04:13:35 -0400
Received: by ey-out-2122.google.com with SMTP id d26so78974eyd.19
        for <linux-omap@vger.kernel.org>; Wed, 12 May 2010 01:13:34 -0700 (PDT)
In-Reply-To: <1273108546-2507-3-git-send-email-jorge.candelaria@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Cc: linux-omap@vger.kernel.org, Margarita Olaya Cabrera <magi.olaya@ti.com>

On Wed,  5 May 2010 20:15:46 -0500
Jorge Eduardo Candelaria <jorge.candelaria@ti.com> wrote:

> McBSP module in OMAP4 needs to be able to set its tx/rx threshold
> and enable the transmitter/receiver when starting an audio stream.
> 
> Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
> Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
> ---
...
> @@ -899,7 +899,7 @@ void omap_mcbsp_stop(unsigned int id, int tx, int rx)
>  
>  	/* Reset receiver */
>  	rx &= 1;
> -	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
> +	if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx) {

Parentheses missing here from cpu_is_omap44xx. Otherwise looks good.


-- 
Jarkko
