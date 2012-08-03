From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH v7 00/11] usb: musb: adding multi instance support
Date: Fri, 3 Aug 2012 14:35:54 +0200
Message-ID: <A4FE42D3-CC9E-4758-A476-B5CC9FB4C97A@dominion.thruhere.net>
References: <1343909574-15633-1-git-send-email-ravibabu@ti.com> <501AFA6B.4010005@gmail.com> <6C6B28D4DC342643927BEAFCE8707BF63E9DB6AE@DBDE01.ent.ti.com> <501B8997.2070307@gmail.com> <F20D4CDD972CFA4D89D3A083D2D561967FF1F67DE3@BGMAIL01.nvidia.com> <501B93AB.7050501@gmail.com> <79CD15C6BA57404B839C016229A409A83EA7F4A3@DBDE01.ent.ti.com> <501BB8F2.8030909@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.0 \(1485\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:56573 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753730Ab2HCMfq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Aug 2012 08:35:46 -0400
Received: by eeil10 with SMTP id l10so182395eei.19
        for <linux-omap@vger.kernel.org>; Fri, 03 Aug 2012 05:35:45 -0700 (PDT)
In-Reply-To: <501BB8F2.8030909@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, Ajay Gupta <ajayg@nvidia.com>, "B, Ravi" <ravibabu@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "tony@atomide.com" <tony@atomide.com>, "ajayguptaj@gmail.com" <ajayguptaj@gmail.com>


Op 3 aug. 2012, om 13:41 heeft Daniel Mack <zonque@gmail.com> het volgende geschreven:

> On 03.08.2012 11:07, Hiremath, Vaibhav wrote:
>> I have just pushed the code (V7 which Ravi submitted), so can you please try 
>> with below branch? 
>> 
>> https://github.com/hvaibhav/am335x-linux/tree/am335x-upstream-staging-usb
> 
> Thanks for doing this, but I'm unfortunately getting tons of merge
> conflicts when I try to put this on top of 3.6-rc1. Still pondering
> which way around is the easiest to get this solved.

A number of those patches are already in 3.6rc1 (the first 10 or so). I use this set: 

	https://github.com/beagleboard/kernel/tree/beaglebone-3.6/patches/usb 

Those where pulled from the staging branch and refreshed this morning. Matching git branch (will get rebased):

	https://github.com/koenkooi/linux/commits/beaglebone-3.6-dont-use

That gives me rootfs on USB on beaglebone port1 and g_ether gadget on beaglebone port0. Hopefully this will work on your custom board as well.

regards,

Koen