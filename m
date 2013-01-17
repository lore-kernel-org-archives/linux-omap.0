From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH] am33xx: cpsw: default to ethernet hwaddr from efuse if not defined in dt
Date: Thu, 17 Jan 2013 23:19:24 +0100
Message-ID: <871udjlafn.fsf@dell.be.48ers.dk>
References: <1358370073-32545-1-git-send-email-jacmet@sunsite.dk>
	<loom.20130117T105358-639@post.gmane.org>
	<87a9s7lq09.fsf@dell.be.48ers.dk> <20130117174528.GM14149@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f176.google.com ([209.85.215.176]:36767 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869Ab3AQWT3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jan 2013 17:19:29 -0500
Received: by mail-ea0-f176.google.com with SMTP id a13so938796eaa.21
        for <linux-omap@vger.kernel.org>; Thu, 17 Jan 2013 14:19:28 -0800 (PST)
In-Reply-To: <20130117174528.GM14149@atomide.com> (Tony Lindgren's message of
	"Thu, 17 Jan 2013 09:45:29 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Michal Bachraty <michal.bachraty@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

>>>>> "Tony" == Tony Lindgren <tony@atomide.com> writes:

Hi,

 >> The way I've handled it is similar to how it is done on atleast one
 >> other arm subarchicture, see
 >> arch/arm/mach-mxs/mach-mxs.c::update_fec_mac_prop()

 Tony> Cool this seems like the cleanest way to deal with it so far. Can
 Tony> you please resend with also linux-net and DT list Cc:d too?

 Tony> Also the arch_initcall should be omap_arch_initcall in linux next
 Tony> for consistency if we ever have SoC specific sections for those.

Sure, resent with the initcall change and netdev/devicetree-discuss added.

-- 
Bye, Peter Korsgaard
