From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 5/10] HDQ driver: Convert few declarations to static
Date: Thu, 25 Sep 2008 13:02:32 +0300
Message-ID: <20080925100232.GU24627@gandalf.research.nokia.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC8EB7@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:37910 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753010AbYIYKCw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 06:02:52 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC8EB7@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gadiyar, Anand" <gadiyar@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "johnpol@2ka.mipt.ru" <johnpol@2ka.mipt.ru>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>

On Thu, Sep 25, 2008 at 12:25:11PM +0530, ext Gadiyar, Anand wrote:
> From: Madhusudhan Chikkature <madhu.cr@ti.com>
> 
> Convert declaration to static.
> 
> Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/w1/masters/omap_hdq.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> Index: linux-omap-2.6/drivers/w1/masters/omap_hdq.c
> ===================================================================
> --- linux-omap-2.6.orig/drivers/w1/masters/omap_hdq.c	2008-09-24 10:10:07.000000000 +0530
> +++ linux-omap-2.6/drivers/w1/masters/omap_hdq.c	2008-09-24 10:19:28.000000000 +0530
> @@ -49,8 +49,8 @@
>  
>  #define OMAP_HDQ_MAX_USER			4
>  
> -DECLARE_WAIT_QUEUE_HEAD(hdq_wait_queue);
> -int W1_ID;
> +static DECLARE_WAIT_QUEUE_HEAD(hdq_wait_queue);
> +static int w1_id;
>  
>  struct hdq_data {
>  	struct device		*dev;
> @@ -249,8 +249,8 @@ static void omap_w1_search_bus(void *_hd
>  {
>  	u64 module_id, rn_le, cs, id;
>  
> -	if (W1_ID)
> -		module_id = W1_ID;
> +	if (w1_id)
> +		module_id = w1_id;
>  	else
>  		module_id = 0x1;
>  
> @@ -715,7 +715,7 @@ omap_hdq_exit(void)
>  module_init(omap_hdq_init);
>  module_exit(omap_hdq_exit);
>  
> -module_param(W1_ID, int, S_IRUSR);
> +module_param(w1_id, int, S_IRUSR);
>  
>  MODULE_AUTHOR("Texas Instruments");
>  MODULE_DESCRIPTION("HDQ driver Library");
-- 
balbi
