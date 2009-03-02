From: Tony Lindgren <tony@atomide.com>
Subject: Re: Suggestion regarding the ordering of GPIO MUX configurations
Date: Mon, 2 Mar 2009 08:40:10 -0800
Message-ID: <20090302164008.GA11864@atomide.com>
References: <4d34a0a70903011837k2a1467b5s9c3b56e065d4b5c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57552 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146AbZCBQkR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 11:40:17 -0500
Content-Disposition: inline
In-Reply-To: <4d34a0a70903011837k2a1467b5s9c3b56e065d4b5c8@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kim Kyuwon <chammoru@gmail.com>
Cc: OMAP <linux-omap@vger.kernel.org>, David Brownell <david-b@pacbell.net>

* Kim Kyuwon <chammoru@gmail.com> [090301 18:37]:
> Hi All.
> 
> The current order of GPIO mux configurations is not sorted. It seems
> that all new GPIO MUX configurations are being inserted to the end as
> shown in next code
> 
> /* arch/arm/plat-omap/include/mach/mux.h */
> 791         AH8_34XX_GPIO29,
> 792         J25_34XX_GPIO170,
> 793         AF26_34XX_GPIO0,
> 794         AF22_34XX_GPIO9,
> 795         L8_34XX_GPIO63,
> 796         AF6_34XX_GPIO140_UP,
> 797         AE6_34XX_GPIO141,
> 798         AF5_34XX_GPIO142,
> 799         AE5_34XX_GPIO143,
> 800         AG4_34XX_GPIO134,
> 801         U8_34XX_GPIO54,
> 802         AE4_34XX_GPIO136,
> 
> 
> I wonder if we can sort the order of GPIO MUX configurations and then
> insert new MUXs at right position. Can I ask your opinions?

Yes, I was thinking about the same. I'll combine the pending mux patches
and merge them into a single patch for mainline tree. While doing that
I'll sort them by gpio number. Will post the patch here for testing
probably today.

Regards,

Tony
