From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 2/2] OMAP: McBSP: Do not enable or disable clocks on
 failed path
Date: Tue, 10 Mar 2009 16:30:27 +0200
Message-ID: <20090310163027.5444259e.jarkko.nikula@nokia.com>
References: <12365823123402-git-send-email-ext-eero.nurkkala@nokia.com>
	<12365823142066-git-send-email-ext-eero.nurkkala@nokia.com>
	<1236582316453-git-send-email-ext-eero.nurkkala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:34415 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864AbZCJObW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Mar 2009 10:31:22 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n2AEVA89014138
	for <linux-omap@vger.kernel.org>; Tue, 10 Mar 2009 16:31:17 +0200
In-Reply-To: <1236582316453-git-send-email-ext-eero.nurkkala@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 9 Mar 2009 08:05:12 +0100
"Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
wrote:

> From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> 
> McBSP clocks are being double enabled in the event the
> McBSP is already active. Also, they are unnecessarily
> disabled when there's no active McBSP in use. Fix this
> phenomenom by enabling and disabling the clocks at a
> proper location.
> 
> @@ -226,9 +226,6 @@ int omap_mcbsp_request(unsigned int id)
>  	if (mcbsp->pdata && mcbsp->pdata->ops &&
> mcbsp->pdata->ops->request) mcbsp->pdata->ops->request(id);
>  
> -	for (i = 0; i < mcbsp->num_clks; i++)
> -		clk_enable(mcbsp->clks[i]);
> -
>  	spin_lock(&mcbsp->lock);
>  	if (!mcbsp->free) {
>  		dev_err(mcbsp->dev, "McBSP%d is currently in use\n",
> @@ -240,6 +237,9 @@ int omap_mcbsp_request(unsigned int id)
>  	mcbsp->free = 0;
>  	spin_unlock(&mcbsp->lock);
>  
> +	for (i = 0; i < mcbsp->num_clks; i++)
> +		clk_enable(mcbsp->clks[i]);
> +

Valid fix.

> @@ -319,9 +319,6 @@ void omap_mcbsp_free(unsigned int id)
>  	if (mcbsp->pdata && mcbsp->pdata->ops &&
> mcbsp->pdata->ops->free) mcbsp->pdata->ops->free(id);
>  
> -	for (i = mcbsp->num_clks - 1; i >= 0; i--)
> -		clk_disable(mcbsp->clks[i]);
> -
>  	spin_lock(&mcbsp->lock);
>  	if (mcbsp->free) {
>  		dev_err(mcbsp->dev, "McBSP%d was not reserved\n",
> @@ -333,6 +330,9 @@ void omap_mcbsp_free(unsigned int id)
>  	mcbsp->free = 1;
>  	spin_unlock(&mcbsp->lock);
>  
> +	for (i = mcbsp->num_clks - 1; i >= 0; i--)
> +		clk_disable(mcbsp->clks[i]);
> +

Race here? See, McBSP is marked free before disabling the clocks and
thus omap_mcbsp_request can start enabling them. So should you keep
clock disabling after test for mcbsp->free as here now but mark McBSP
free only after clocks are disabled?

I think you should send this as an separate fix since this should go to
the upstream also.


Jarkko
