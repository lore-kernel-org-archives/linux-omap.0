From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 4/8] musb: Update setup_usb() call for all Davinci boards
Date: Tue, 17 Nov 2009 19:10:17 +0300
Message-ID: <4B02CAE9.4050106@ru.mvista.com>
References: <1258470596-24321-1-git-send-email-ajay.gupta@ti.com>	<1258470596-24321-2-git-send-email-ajay.gupta@ti.com>	<1258470596-24321-3-git-send-email-ajay.gupta@ti.com>	<1258470596-24321-4-git-send-email-ajay.gupta@ti.com> <1258470596-24321-5-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:1388 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1752130AbZKQQJl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 11:09:41 -0500
In-Reply-To: <1258470596-24321-5-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-usb@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, cooloney@kernel.org, felipe.balbi@nokia.com, linux-omap@vger.kernel.org, gadiyar@ti.com

Ajay Kumar Gupta wrote:

> setup_usb() has been modified to pass board specific data so updating
> this function call from all Davinci based boards.

> Added "struct device;" to fix below compilation warning for Davinci boards.
> "musb.h: struct device, defined within parameter list"

> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>

[...]

> diff --git a/arch/arm/mach-davinci/usb.c b/arch/arm/mach-davinci/usb.c
> index 06f5593..1b164dc 100644
> --- a/arch/arm/mach-davinci/usb.c
> +++ b/arch/arm/mach-davinci/usb.c
> @@ -85,10 +85,10 @@ static struct platform_device usb_dev = {
>  	.num_resources  = ARRAY_SIZE(usb_resources),
>  };
>  
> -void __init setup_usb(unsigned mA, unsigned potpgt_msec)
> +void __init setup_usb(struct musb_hdrc_board_data *board_data)
>  {
> -	usb_data.power = mA / 2;
> -	usb_data.potpgt = potpgt_msec / 2;

    Hm, again, you can't separate this patch from patch 1/8 to keep the code 
compiling between the patches.  It looks like you have no choice but lump 
most of your patches together (and get rid of some others :-). Either that 
or better separate your change to the struct musb_hdrc_platfrpom_data and 
your change to setup_usb() prototype.

WBR, Sergei
