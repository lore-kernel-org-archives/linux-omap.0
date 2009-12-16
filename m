From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 3/5 v8] OMAP: McBSP: Introduce caching in register write
 operations
Date: Wed, 16 Dec 2009 10:12:55 +0200
Message-ID: <20091216101255.91e28a5f.jhnikula@gmail.com>
References: <200912092124.14430.jkrzyszt@tis.icnet.pl>
	<20091211151149.c20acce5.jhnikula@gmail.com>
	<200912111451.29185.jkrzyszt@tis.icnet.pl>
	<200912150136.49087.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:33921 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761788AbZLPILk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 03:11:40 -0500
Received: by ewy19 with SMTP id 19so274064ewy.21
        for <linux-omap@vger.kernel.org>; Wed, 16 Dec 2009 00:11:37 -0800 (PST)
In-Reply-To: <200912150136.49087.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, linux-omap@vger.kernel.org

On Tue, 15 Dec 2009 01:36:47 +0100
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

> 3. In omap_mcbsp_free(), marking the port as free before deallocating the 
>    cache, could result in memory leak as well.
> 
> I hope all are addressed correctly. Since releasing the port with
> 
> 	mcbsp->free = 1;
> 
> after kzalloc() failure should be atomic, I have assumed this doesn't require 
> locking.
> 
Good catch. One comment below.

> @@ -471,6 +491,9 @@ void omap_mcbsp_free(unsigned int id)
>  		free_irq(mcbsp->tx_irq, (void *)mcbsp);
>  	}
>  
> +	kfree(mcbsp->reg_cache);
> +	mcbsp->reg_cache = NULL;
> +
>  	spin_lock(&mcbsp->lock);
>  	if (mcbsp->free) {
>  		dev_err(mcbsp->dev, "McBSP%d was not reserved\n",

This is fine in current form but to play safe, lets do the kfree
inside the spin_lock section where the mcbsp->free is set. Then there
is no risk if some future code would use the mcbsp->free as a guard for
cache etc. access.


-- 
Jarkko
