From: "B, Ravi" <ravibabu@ti.com>
Subject: RE: [PATCH v7 00/11] usb: musb: adding multi instance support
Date: Fri, 3 Aug 2012 11:48:22 +0000
Message-ID: <6C6B28D4DC342643927BEAFCE8707BF63E9DBCA9@DBDE01.ent.ti.com>
References: <1343909574-15633-1-git-send-email-ravibabu@ti.com>
 <501AFA6B.4010005@gmail.com>
 <6C6B28D4DC342643927BEAFCE8707BF63E9DB6AE@DBDE01.ent.ti.com>
 <501B8997.2070307@gmail.com>
 <F20D4CDD972CFA4D89D3A083D2D561967FF1F67DE3@BGMAIL01.nvidia.com>
 <501B93AB.7050501@gmail.com>
 <79CD15C6BA57404B839C016229A409A83EA7F4A3@DBDE01.ent.ti.com>
 <501BB8F2.8030909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43839 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751730Ab2HCLsa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Aug 2012 07:48:30 -0400
In-Reply-To: <501BB8F2.8030909@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Ajay Gupta <ajayg@nvidia.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "tony@atomide.com" <tony@atomide.com>, "ajayguptaj@gmail.com" <ajayguptaj@gmail.com>

 
> On 03.08.2012 11:07, Hiremath, Vaibhav wrote:
> > I have just pushed the code (V7 which Ravi submitted), so can you 
> > please try with below branch?
> > 
> > 
> https://github.com/hvaibhav/am335x-linux/tree/am335x-upstream-staging-
> > usb
> 
> Thanks for doing this, but I'm unfortunately getting tons of 
> merge conflicts when I try to put this on top of 3.6-rc1. 
> Still pondering which way around is the easiest to get this solved.
> 
> OTOH, I wonder whether your staging branches would need to 
> rebased sooner or later anyway?
> 

Sorry, We don't have patches on latest v3.6-rc1 and will take couple of days.

> 
> Daniel
> 
> 