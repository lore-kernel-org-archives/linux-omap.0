From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 9/9]HDQ driver:  Fix indentation and commenting style
Date: Wed, 24 Sep 2008 14:49:54 +0300
Message-ID: <20080924114954.GN24627@gandalf.research.nokia.com>
References: <61763.192.168.10.89.1222256190.squirrel@dbdmail.itg.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:17321 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbYIXLus (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 07:50:48 -0400
Content-Disposition: inline
In-Reply-To: <61763.192.168.10.89.1222256190.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: tony@atomide.com, johnpol@2ka.mipt.ru, felipe.balbi@nokia.com, linux-omap@vger.kernel.org

On Wed, Sep 24, 2008 at 05:06:30PM +0530, ext Madhusudhan Chikkature wrote:
> From: Madhusudhan Chikkature<madhu.cr@ti.com>
> 
> This patch fixes the indentation, commenting style of a single line comment.
> 
> Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>
> ---
>  drivers/w1/masters/omap_hdq.c |   81 +++++++++++++++---------------------------
>  1 files changed, 29 insertions(+), 52 deletions(-)
> 
> Index: linux-omap-2.6/drivers/w1/masters/omap_hdq.c
> ===================================================================
> --- linux-omap-2.6.orig/drivers/w1/masters/omap_hdq.c	2008-09-24
> 14:41:43.000000000 +0530
> +++ linux-omap-2.6/drivers/w1/masters/omap_hdq.c	2008-09-24 15:37:18.000000000
> +0530
> @@ -77,12 +77,12 @@ static int __init omap_hdq_probe(struct
>  static int omap_hdq_remove(struct platform_device *pdev);
> 
>  static struct platform_driver omap_hdq_driver = {
> -	.probe = omap_hdq_probe,
> -	.remove = omap_hdq_remove,
> -	.suspend = NULL,
> -	.resume = NULL,
> -	.driver = {
> -		.name = "omap_hdq",
> +	.probe =	omap_hdq_probe,
> +	.remove =	omap_hdq_remove,
> +	.suspend =	NULL,
> +	.resume =	NULL,

suspend and resume lines can be removed, that platform_driver is static,
which means any unitiliazed member will be nulled.

-- 
balbi
