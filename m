From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH v7 00/11] usb: musb: adding multi instance support
Date: Fri, 3 Aug 2012 18:01:17 +0200
Message-ID: <AC2C96E3-514C-4D1A-B2A6-4B634D21874B@dominion.thruhere.net>
References: <1343909574-15633-1-git-send-email-ravibabu@ti.com> <501AFA6B.4010005@gmail.com> <6C6B28D4DC342643927BEAFCE8707BF63E9DB6AE@DBDE01.ent.ti.com> <501B8997.2070307@gmail.com> <F20D4CDD972CFA4D89D3A083D2D561967FF1F67DE3@BGMAIL01.nvidia.com> <501B93AB.7050501@gmail.com> <79CD15C6BA57404B839C016229A409A83EA7F4A3@DBDE01.ent.ti.com> <501BB8F2.8030909@gmail.com> <79CD15C6BA57404B839C016229A409A83EA7FB18@DBDE01.ent.ti.com>
Mime-Version: 1.0 (Mac OS X Mail 6.0 \(1485\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:60083 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220Ab2HCQBE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Aug 2012 12:01:04 -0400
Received: by eeil10 with SMTP id l10so271599eei.19
        for <linux-omap@vger.kernel.org>; Fri, 03 Aug 2012 09:01:02 -0700 (PDT)
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA7FB18@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Daniel Mack <zonque@gmail.com>, Ajay Gupta <ajayg@nvidia.com>, "B, Ravi" <ravibabu@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "tony@atomide.com" <tony@atomide.com>, "ajayguptaj@gmail.com" <ajayguptaj@gmail.com>


Op 3 aug. 2012, om 17:48 heeft "Hiremath, Vaibhav" <hvaibhav@ti.com> het volgende geschreven:

> On Fri, Aug 03, 2012 at 17:11:38, Daniel Mack wrote:
>> On 03.08.2012 11:07, Hiremath, Vaibhav wrote:
>>> I have just pushed the code (V7 which Ravi submitted), so can you please try 
>>> with below branch? 
>>> 
>>> https://github.com/hvaibhav/am335x-linux/tree/am335x-upstream-staging-usb
>> 
>> Thanks for doing this, but I'm unfortunately getting tons of merge
>> conflicts when I try to put this on top of 3.6-rc1. Still pondering
>> which way around is the easiest to get this solved.
>> 
>> OTOH, I wonder whether your staging branches would need to rebased
>> sooner or later anyway?
>> 
> 
> I have already pushed branch based on v3.6-rc1 (boot tested),
> 
> https://github.com/hvaibhav/am335x-linux/tree/am335x-linux-next-master

I think Daniel meant without the linux-next stuff in between. E.g. on top of the v3.6-rc1 tag. I can see that such a tree is not of much use for you, since you now need to target the 3.7 merge window for new patches. But I can't and won't speak for both of you :)

regards,

Koen