From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] am33xx: cpsw: default to ethernet hwaddr from efuse if
 not defined in dt
Date: Thu, 17 Jan 2013 09:45:29 -0800
Message-ID: <20130117174528.GM14149@atomide.com>
References: <1358370073-32545-1-git-send-email-jacmet@sunsite.dk>
 <loom.20130117T105358-639@post.gmane.org>
 <87a9s7lq09.fsf@dell.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:57030 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752776Ab3AQRpd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jan 2013 12:45:33 -0500
Content-Disposition: inline
In-Reply-To: <87a9s7lq09.fsf@dell.be.48ers.dk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Michal Bachraty <michal.bachraty@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Peter Korsgaard <jacmet@sunsite.dk> [130117 08:46]:
> >>>>> "Michal" == Michal Bachraty <michal.bachraty@gmail.com> writes:
> 
> Hi Michael,
> 
>  Michal> I made changes to cpsw driver two weeks ago, which add support
>  Michal> for reading MAC address from CPU and also I posted it to
>  Michal> review.  You can find patch here :
>  Michal> https://patchwork.kernel.org/patch/1966481/ I will create
>  Michal> updated patch next week, depended on reactions. Can you try
>  Michal> that patch? I'll be glad to hear your opinion.
> 
> Thanks, I missed that patch. Functionality wise the patches do the same,
> but I must say I find my patch cleaner, as it doesn't involve any new dt
> bindings or access to the am33xx specific control module registers from
> the cpsw driver.
> 
> The way I've handled it is similar to how it is done on atleast one
> other arm subarchicture, see
> arch/arm/mach-mxs/mach-mxs.c::update_fec_mac_prop()

Cool this seems like the cleanest way to deal with it so far. Can
you please resend with also linux-net and DT list Cc:d too?

Also the arch_initcall should be omap_arch_initcall in linux next
for consistency if we ever have SoC specific sections for those.

Regards,

Tony
