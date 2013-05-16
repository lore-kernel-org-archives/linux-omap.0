From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP3: Fix iva2_pwrdm settings for 3703
Date: Thu, 16 May 2013 11:54:44 -0700
Message-ID: <20130516185444.GK5600@atomide.com>
References: <20130515002537.GG5600@atomide.com>
 <20130515015212.GB3268@animalcreek.com>
 <20130515170734.GI5600@atomide.com>
 <20130515215028.GA11883@animalcreek.com>
 <5194B2A8.8020608@visionsystems.de>
 <20130516183516.GJ5600@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:45655 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750835Ab3EPSyt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 May 2013 14:54:49 -0400
Content-Disposition: inline
In-Reply-To: <20130516183516.GJ5600@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Yegor Yefremov <yegor_sub1@visionsystems.de>
Cc: "Mark A. Greer" <mgreer@animalcreek.com>, Kevin Hilman <khilman@linaro.org>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [130516 11:40]:
> * Yegor Yefremov <yegor_sub1@visionsystems.de> [130516 05:13]:
> > 
> > I think this issue is relevant to am3517 as you can see from this thread: http://thread.gmane.org/gmane.linux.ports.arm.omap/97903
> > I could boot only with your patch http://www.spinics.net/lists/arm-kernel/msg168865.html
> 
> OK sounds like Mark's patch as http://www.spinics.net/lists/arm-kernel/msg168865.html
> is needed as a fix.

Yegor, thinking about your boot issue more, I'm thinking that you
have your board .init_time = omap3_secure_sync32k_timer_init, or
some non-waking gpt timer. And that means the system won't wake to
timer events.

The system should still wake to timer events even if you have no
wake-up events configred, so Mark's patch probably does not fix
the right issue for you.

Regards,

Tony
