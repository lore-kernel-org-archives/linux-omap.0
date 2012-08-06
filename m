From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH v7 00/11] usb: musb: adding multi instance support
Date: Mon, 6 Aug 2012 06:40:54 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA85C87@DBDE01.ent.ti.com>
References: <1343909574-15633-1-git-send-email-ravibabu@ti.com>
 <501AFA6B.4010005@gmail.com>
 <6C6B28D4DC342643927BEAFCE8707BF63E9DB6AE@DBDE01.ent.ti.com>
 <501B8997.2070307@gmail.com>
 <F20D4CDD972CFA4D89D3A083D2D561967FF1F67DE3@BGMAIL01.nvidia.com>
 <501B93AB.7050501@gmail.com>
 <79CD15C6BA57404B839C016229A409A83EA7F4A3@DBDE01.ent.ti.com>
 <501BB8F2.8030909@gmail.com>
 <79CD15C6BA57404B839C016229A409A83EA7FB18@DBDE01.ent.ti.com>
 <501ECF15.2040409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53221 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751728Ab2HFGlK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Aug 2012 02:41:10 -0400
In-Reply-To: <501ECF15.2040409@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Ajay Gupta <ajayg@nvidia.com>, "B, Ravi" <ravibabu@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "tony@atomide.com" <tony@atomide.com>, "ajayguptaj@gmail.com" <ajayguptaj@gmail.com>

On Mon, Aug 06, 2012 at 01:22:53, Daniel Mack wrote:
> On 03.08.2012 17:48, Hiremath, Vaibhav wrote:
> > On Fri, Aug 03, 2012 at 17:11:38, Daniel Mack wrote:
> >> On 03.08.2012 11:07, Hiremath, Vaibhav wrote:
> >>> I have just pushed the code (V7 which Ravi submitted), so can you please try 
> >>> with below branch? 
> >>>
> >>> https://github.com/hvaibhav/am335x-linux/tree/am335x-upstream-staging-usb
> >>
> >> Thanks for doing this, but I'm unfortunately getting tons of merge
> >> conflicts when I try to put this on top of 3.6-rc1. Still pondering
> >> which way around is the easiest to get this solved.
> >>
> >> OTOH, I wonder whether your staging branches would need to rebased
> >> sooner or later anyway?
> >>
> > 
> > I have already pushed branch based on v3.6-rc1 (boot tested),
> > 
> > https://github.com/hvaibhav/am335x-linux/tree/am335x-linux-next-master
> 
> Sorry, I don't get it yet. Your am335x-linux-next-master can be merged
> into v3.6-rc1 without problems, but it doesn't contain Ravi's patches.
> And am335x-upstream-staging-usb doesn't apply on top of either
> am335x-linux-next-master or v3.6-rc1.
> 
> Maybe I just miss a detail here. Could you again explain which branch
> will you publish for merging in the 3.7 merge window, and what are its
> dependencies?
> 

Daniel,

Every developer is supposed to submit the patches on top of their 
maintainer's repository, which may or may not be in-sync with latest linux-
next or Linus's tree at given time OR their could be some extra dependency 
from framework. For example, linux-omap is still not updated to v3.6-rc1, 
but I have to use linux-omap/master for all patch submissions.

It becomes extra work for each developers to maintain branch for both, one 
against their maintainer HEAD and one against linux-next/master.

So I am just pushing the branch which is being tested/validated (on 
BeagleBone) before submitting patches to the list.

I hope this clarifies all your confusion.

Thanks,
Vaibhav
> 
> Thanks for your work,
> Daniel
> 

