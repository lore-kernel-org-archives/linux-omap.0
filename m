From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] dspbridge: use linux memory allocator directly
Date: Thu, 3 Sep 2009 09:57:02 +0300
Message-ID: <20090903065702.GA31145@nokia.com>
References: <20090902174941.GA25799@localhost>
 <1251960538-24736-1-git-send-email-andy.shevchenko@gmail.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:20846 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754384AbZICG63 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Sep 2009 02:58:29 -0400
Content-Disposition: inline
In-Reply-To: <1251960538-24736-1-git-send-email-andy.shevchenko@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shevchenko Andriy (EXT-Teleca/Helsinki)" <ext-andriy.shevchenko@nokia.com>

Hi,

On Thu, Sep 03, 2009 at 08:48:58AM +0200, ext Andy Shevchenko wrote:
> @@ -85,9 +85,9 @@ struct LST_LIST {
>  static inline struct LST_LIST *LST_Create(void)
>  {
>  	struct LST_LIST *pList;
> +	gfp_t flags = (in_atomic()) ? GFP_ATOMIC : GFP_KERNEL;
>  
> -	pList = (struct LST_LIST *) MEM_Calloc(sizeof(struct LST_LIST),
> -		MEM_NONPAGED);
> +	pList = (struct LST_LIST *) kzalloc(sizeof(struct LST_LIST), flags);

no need for casting either :-)

-- 
balbi
