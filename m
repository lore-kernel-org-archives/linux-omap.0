From: Tony Lindgren <tony@atomide.com>
Subject: Re: isp1301 build breakage
Date: Wed, 12 Mar 2008 14:00:24 +0200
Message-ID: <20080312120023.GR7524@atomide.com>
References: <200803120428.45006.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62344 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208AbYCLMAe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Mar 2008 08:00:34 -0400
Content-Disposition: inline
In-Reply-To: <200803120428.45006.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [080312 13:28]:
>   CC      drivers/i2c/chips/isp1301_omap.o
> drivers/i2c/chips/isp1301_omap.c: In function 'isp1301_set_peripheral':
> drivers/i2c/chips/isp1301_omap.c:1360: error: implicit declaration of function 'machine_is_omap_h2'
> drivers/i2c/chips/isp1301_omap.c:1360: error: implicit declaration of function 'machine_is_omap_h3'
> make[3]: *** [drivers/i2c/chips/isp1301_omap.o] Error 1
> make[2]: *** [drivers/i2c/chips] Error 2
> make[1]: *** [drivers/i2c] Error 2
> 
> This is on an H4 config, if that matters at all.

I've pushed a quick fix to include mach-types.h.. In the long run that
should use platform_data for passing any special options..

Tony
