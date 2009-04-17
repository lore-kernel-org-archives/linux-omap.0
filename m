From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3: lessen amount of noisy messages
Date: Fri, 17 Apr 2009 01:34:45 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0904170133390.29400@utopia.booyaka.com>
References: <1239288072.3390.8.camel@localhost.localdomain>  <49E5D188.8060508@yandex.ru>  <alpine.DEB.2.00.0904150917520.3313@utopia.booyaka.com> <1239810161.3390.190.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38292 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759881AbZDQHer (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Apr 2009 03:34:47 -0400
In-Reply-To: <1239810161.3390.190.camel@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <dedekind@infradead.org>
Cc: Artem Bityutskiy <dedekind@yandex.ru>, Tony Lindgen <tony@atomide.com>, paul@pwsan.com, linux-omap@vger.kernel.org

Hi Artem,

On Wed, 15 Apr 2009, Artem Bityutskiy wrote:

> If you do not want re-compilation, I may send a different patch
> like this:
> 
> -	printk(KERN_INFO "Disabling unused clock \"%s\"\n", clk->name);
> +	printk(KERN_DEBUG "Disabling unused clock \"%s\"\n", clk->name);
> 
> in which case you would not loose the messages, but the messages
> would not go to the serial line.

Yes, that patch is fine.  I'll add that to the omap-clock-upstream branch.


- Paul

