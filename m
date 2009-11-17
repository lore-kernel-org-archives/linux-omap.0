From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/8] musb: Add structure to get board specific data
Date: Tue, 17 Nov 2009 18:56:41 +0300
Message-ID: <4B02C7B9.8030805@ru.mvista.com>
References: <1258470596-24321-1-git-send-email-ajay.gupta@ti.com> <1258470596-24321-2-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:52411 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1753841AbZKQP4C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 10:56:02 -0500
In-Reply-To: <1258470596-24321-2-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-usb@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, cooloney@kernel.org, felipe.balbi@nokia.com, linux-omap@vger.kernel.org, gadiyar@ti.com

Ajay Kumar Gupta wrote:

> Adding 'musb_hdrc_board_data' which will have all the board specific
> parameters such as; mA power, potpgt, extvbus, gpios etc.
> 
> Currently only 'power' and 'potpgt' is being moved from existing
> 'musb_hdrc_platform_data' to 'musb_hdrc_board_data' but any further
> board specific functions or parameter can be added to this structure
> later.
> 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>

[...]

> diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
> index d437556..6e1426c 100644
> --- a/include/linux/usb/musb.h
> +++ b/include/linux/usb/musb.h
[...]
> @@ -67,15 +76,9 @@ struct musb_hdrc_platform_data {
>  	/* (HOST or OTG) switch VBUS on/off */
>  	int		(*set_vbus)(struct device *dev, int is_on);
>  
> -	/* (HOST or OTG) mA/2 power supplied on (default = 8mA) */
> -	u8		power;
> -

    Oh, this will break compilation of the existing code! This patch 
shouldn't be separated from patch 2/8.

WBR, Sergei
