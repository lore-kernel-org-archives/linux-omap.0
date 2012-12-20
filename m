From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: BUG: spinlock bad magic on CPU#0 on BeagleBone
Date: Thu, 20 Dec 2012 06:44:46 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EC9B964@DBDE01.ent.ti.com>
References: <B5906170F1614E41A8A28DE3B8D121433EC9A69C@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1212191650430.16873@utopia.booyaka.com>
 <50D2224E.4060300@codeaurora.org>
 <B5906170F1614E41A8A28DE3B8D121433EC9B6FE@DBDE01.ent.ti.com>
 <50D2AF54.7050402@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54184 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751484Ab2LTGoy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Dec 2012 01:44:54 -0500
In-Reply-To: <50D2AF54.7050402@codeaurora.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Dec 20, 2012 at 11:55:24, Stephen Boyd wrote:
> On 12/19/2012 8:48 PM, Bedia, Vaibhav wrote:
> > I tried out 3 variants of AM335x boards - 2 of these (BeagleBone and EVM) have DDR2
> > and 1 has DDR3 (EVM-SK). The BUG is triggered on all of these at the same point.
> >
> > With Stephen's change I don't see this on any of the board variants :)
> > New bootlog below.
> 
> Great! Can I have your Tested-by then? I'll wrap it up into a patch. Is
> this is a new regression? From a glance at the code it looks to have
> existed for quite a while now.

I went back to a branch based off 3.7-rc4 and don't see the issue there. Not sure
what is triggering this now.

Tested-by: Vaibhav Bedia <vaibhav.bedia@ti.com>

