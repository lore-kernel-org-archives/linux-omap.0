From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] cbus-retu-wdt: Remove unused nonstandard interfaces
Date: Thu, 3 Mar 2011 11:42:51 +0200
Message-ID: <20110303094251.GG2644@legolas.emea.dhcp.ti.com>
References: <1299082318.13604.14.camel@marge>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:37751 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750909Ab1CCJmz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 04:42:55 -0500
Received: by mail-bw0-f53.google.com with SMTP id 12so1133233bwg.26
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 01:42:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1299082318.13604.14.camel@marge>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Buesch <mb@bu3sch.de>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Wed, Mar 02, 2011 at 05:11:58PM +0100, Michael Buesch wrote:
> @@ -175,9 +124,9 @@ static int retu_wdt_release(struct inode
>  	struct retu_wdt_dev *wdev = file->private_data;
>  
>  #ifndef CONFIG_WATCHDOG_NOWAYOUT
> -	retu_wdt_ping_enable(retu_wdt);
> +	retu_wdt_ping_enable(wdev);
>  #endif
> -	clear_bit(0, &retu_wdt->users);
> +	clear_bit(0, &wdev->users);

this hunk isn't part of this patch.

-- 
balbi
