From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH v7 3/5] OMAP: McBSP: Introduce caching in register write
 operations
Date: Fri, 11 Dec 2009 15:11:49 +0200
Message-ID: <20091211151149.c20acce5.jhnikula@gmail.com>
References: <200912092124.14430.jkrzyszt@tis.icnet.pl>
	<200912092131.21517.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f209.google.com ([209.85.219.209]:64743 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbZLKNKb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 08:10:31 -0500
Received: by ewy1 with SMTP id 1so991448ewy.28
        for <linux-omap@vger.kernel.org>; Fri, 11 Dec 2009 05:10:37 -0800 (PST)
In-Reply-To: <200912092131.21517.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, linux-omap@vger.kernel.org

On Wed, 9 Dec 2009 21:31:20 +0100
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

> @@ -391,6 +405,10 @@ int omap_mcbsp_request(unsigned int id)
>  	}
>  	mcbsp = id_to_mcbsp_ptr(id);
>  
> +	mcbsp->reg_cache = kzalloc(omap_mcbsp_cache_size, GFP_KERNEL);
> +	if (!mcbsp->reg_cache)
> +		return -ENOMEM;
> +
>  	spin_lock(&mcbsp->lock);
>  	if (!mcbsp->free) {
>  		dev_err(mcbsp->dev, "McBSP%d is currently in use\n",

Great work. Could have my ack to patches 1-4 by moving the cache
allocation after the mcbsp->free test lines. Memory leak and other
badness would happen otherwise in case of multiple call to
omap_mcbsp_request.

Just send an update to this mail if there is no comments to another
patches.


-- 
Jarkko
