From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: lessen amount of noisy messages
Date: Fri, 17 Apr 2009 08:41:21 -0500
Message-ID: <87myaf8kji.fsf@deeprootsystems.com>
References: <1239288072.3390.8.camel@localhost.localdomain>
	<49E5D188.8060508@yandex.ru>
	<alpine.DEB.2.00.0904150917520.3313@utopia.booyaka.com>
	<1239810161.3390.190.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:43842 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134AbZDQNl0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Apr 2009 09:41:26 -0400
Received: by rv-out-0506.google.com with SMTP id f9so917335rvb.1
        for <linux-omap@vger.kernel.org>; Fri, 17 Apr 2009 06:41:23 -0700 (PDT)
In-Reply-To: <1239810161.3390.190.camel@localhost.localdomain> (Artem Bityutskiy's message of "Wed\, 15 Apr 2009 18\:42\:41 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dedekind@infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, Artem Bityutskiy <dedekind@yandex.ru>, Tony Lindgen <tony@atomide.com>, linux-omap@vger.kernel.org

Artem Bityutskiy <dedekind@infradead.org> writes:

> Hi,
>
> On Wed, 2009-04-15 at 09:22 -0600, Paul Walmsley wrote:
>> stil thinking about it.  These messages have made it easy to catch bugs 
>> with the PM code in the past (e.g., sad2d).  Making them debug-level will 
>> require booting a kernel with clock debugging specifically 
>> compiled in.  So I wonder if there might be a better way to deal with 
>> these...
>
> Yeah, I see your concern. I'm your user, and from my perspective this is
> an excessive output to slow serial line.
>
> If you do not want re-compilation, I may send a different patch
> like this:
>
> -	printk(KERN_INFO "Disabling unused clock \"%s\"\n", clk->name);
> +	printk(KERN_DEBUG "Disabling unused clock \"%s\"\n", clk->name);
>
> in which case you would not loose the messages, but the messages
> would not go to the serial line.
>

I prefer this method as well since i can see them simply by adding
debug to the cmdline.

Kevin

