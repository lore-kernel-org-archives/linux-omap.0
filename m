From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH] am33xx: cpsw: default to ethernet hwaddr from efuse if not defined in dt
Date: Thu, 17 Jan 2013 17:43:02 +0100
Message-ID: <87a9s7lq09.fsf@dell.be.48ers.dk>
References: <1358370073-32545-1-git-send-email-jacmet@sunsite.dk>
	<loom.20130117T105358-639@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f176.google.com ([209.85.215.176]:48688 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411Ab3AQQnG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jan 2013 11:43:06 -0500
Received: by mail-ea0-f176.google.com with SMTP id a13so776171eaa.7
        for <linux-omap@vger.kernel.org>; Thu, 17 Jan 2013 08:43:04 -0800 (PST)
In-Reply-To: <loom.20130117T105358-639@post.gmane.org> (Michal Bachraty's
	message of "Thu, 17 Jan 2013 15:14:20 +0000 (UTC)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michal Bachraty <michal.bachraty@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

>>>>> "Michal" == Michal Bachraty <michal.bachraty@gmail.com> writes:

Hi Michael,

 Michal> I made changes to cpsw driver two weeks ago, which add support
 Michal> for reading MAC address from CPU and also I posted it to
 Michal> review.  You can find patch here :
 Michal> https://patchwork.kernel.org/patch/1966481/ I will create
 Michal> updated patch next week, depended on reactions. Can you try
 Michal> that patch? I'll be glad to hear your opinion.

Thanks, I missed that patch. Functionality wise the patches do the same,
but I must say I find my patch cleaner, as it doesn't involve any new dt
bindings or access to the am33xx specific control module registers from
the cpsw driver.

The way I've handled it is similar to how it is done on atleast one
other arm subarchicture, see
arch/arm/mach-mxs/mach-mxs.c::update_fec_mac_prop()

-- 
Bye, Peter Korsgaard
