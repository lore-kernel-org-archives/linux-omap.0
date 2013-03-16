From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 33/50] staging: omap-thermal: refactor APIs handling
 threshold values
Date: Sat, 16 Mar 2013 11:39:52 +0300
Message-ID: <20130316083952.GO9138@mwanda>
References: <1363352438-15935-1-git-send-email-eduardo.valentin@ti.com>
 <1363352438-15935-34-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:26112 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981Ab3CPIkI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Mar 2013 04:40:08 -0400
Content-Disposition: inline
In-Reply-To: <1363352438-15935-34-git-send-email-eduardo.valentin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Fri, Mar 15, 2013 at 09:00:21AM -0400, Eduardo Valentin wrote:
>  	if (ret) {
>  		dev_err(bg_ptr->dev, "failed to read thot\n");
> -		return -EIO;
> +		ret = -EIO;
> +		goto exit;
>  	}
>  
> -	*thot = temp;
> +	*val = temp;
>  
> +exit:
>  	return 0;
>  }


The bunny hop has introduced a bug and this always returns success.

regards,
dan carpenter

