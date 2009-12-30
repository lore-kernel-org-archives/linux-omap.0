From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH v2 1/2] ARM : OMAP: MUSB : Pass board specific data
 using a structure
Date: Wed, 30 Dec 2009 16:43:35 +0200
Message-ID: <1262184215.17250.11.camel@gandalf>
References: <1262183048-14709-1-git-send-email-x0082077@ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:34254 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836AbZL3Onm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Dec 2009 09:43:42 -0500
In-Reply-To: <1262183048-14709-1-git-send-email-x0082077@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maulik Mankad <x0082077@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>, David Brownell <david-b@pacbell.net>, Greg Kroah-Hartman <gregkh@suse.de>, Gupta Ajay Kumar <ajay.gupta@ti.com>

Hi,

On Wed, 2009-12-30 at 19:54 +0530, Maulik Mankad wrote:
> Index: felipe_musb/include/linux/usb/musb.h
> ===================================================================
> --- felipe_musb.orig/include/linux/usb/musb.h
> +++ felipe_musb/include/linux/usb/musb.h
> @@ -84,6 +84,9 @@ struct musb_hdrc_platform_data {
>  
>  	/* MUSB configuration-specific details */
>  	struct musb_hdrc_config	*config;
> +
> +	/* Board specific data	*/
> +	struct omap_musb_board_data	*board_data;

here it should be void *board_data;
so that other archs can pass whatever data structure they want.

-- 
balbi

