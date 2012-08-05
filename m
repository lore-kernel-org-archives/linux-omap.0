From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v7 00/11] usb: musb: adding multi instance support
Date: Sun, 05 Aug 2012 21:52:53 +0200
Message-ID: <501ECF15.2040409@gmail.com>
References: <1343909574-15633-1-git-send-email-ravibabu@ti.com> <501AFA6B.4010005@gmail.com> <6C6B28D4DC342643927BEAFCE8707BF63E9DB6AE@DBDE01.ent.ti.com> <501B8997.2070307@gmail.com> <F20D4CDD972CFA4D89D3A083D2D561967FF1F67DE3@BGMAIL01.nvidia.com> <501B93AB.7050501@gmail.com> <79CD15C6BA57404B839C016229A409A83EA7F4A3@DBDE01.ent.ti.com> <501BB8F2.8030909@gmail.com> <79CD15C6BA57404B839C016229A409A83EA7FB18@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33116 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754887Ab2HETw5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Aug 2012 15:52:57 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA7FB18@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Ajay Gupta <ajayg@nvidia.com>, "B, Ravi" <ravibabu@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "tony@atomide.com" <tony@atomide.com>, "ajayguptaj@gmail.com" <ajayguptaj@gmail.com>

On 03.08.2012 17:48, Hiremath, Vaibhav wrote:
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

Sorry, I don't get it yet. Your am335x-linux-next-master can be merged
into v3.6-rc1 without problems, but it doesn't contain Ravi's patches.
And am335x-upstream-staging-usb doesn't apply on top of either
am335x-linux-next-master or v3.6-rc1.

Maybe I just miss a detail here. Could you again explain which branch
will you publish for merging in the 3.7 merge window, and what are its
dependencies?


Thanks for your work,
Daniel
