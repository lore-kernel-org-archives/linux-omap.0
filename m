From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH 5/9] ARM: OMAP2+: gpmc-smc91x: Adapt to use gpmc driver
Date: Thu, 14 Jun 2012 09:26:24 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9997BD@DBDE01.ent.ti.com>
References: <cover.1339419379.git.afzal@ti.com>
 <0bdbc293fc98613011d37ec59559ba6d475eadf2.1339419379.git.afzal@ti.com>
 <20120613122950.GR12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998EC1@DBDE01.ent.ti.com>
 <20120613134323.GX12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53674 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755461Ab2FNJ0a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 05:26:30 -0400
In-Reply-To: <20120613134323.GX12766@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Tony,

On Wed, Jun 13, 2012 at 19:13:24, Tony Lindgren wrote:
> * Mohammed, Afzal <afzal@ti.com> [120613 06:43]:

> > Do you mean for all the gpmc-* helpers existing initialization
> > needs to be modified to use the new interface, the previous version
> > was doing so. But then that will cause all boards using the same
> > gpmc-* helper to be converted at once (tusb6010 is not an issue as
> > only one board uses it), then the problem will be that there would
> > be a few commits where gpmc may not work properly.
> > 
> > And for a particular board, either it has to use old interface
> > or either the new interface, it cannot use both.
> > 
> > Consider the case of this one, smc91x, all sdp boards use it,
> > that requires nand, onenand, nor gpmc-* helpers to be converted
> > before board migration for say 3430sdp board, that would mean
> > that 2430sdp board would be broken w.r.t gpmc at that commit as
> > board modifications are not yet done for 2430. That in turn means
> > all the boards using nand, onenand would be broken at that point.
> 
> What I mean is keep the old interface in gpmc.c, then convert
> users one at a time to the new interface, and remove the old
> interface code from the users. But yeah you're right, it may
> not be immediately doable for the smc91x case before we dump
> out the register values. But at least tusb6010 should be able
> to just convert to use the new interface and drop the old code.

Yesterday, I overlooked the fact that n8x0 have onenand in addition
to tusb6010. As that is the case, to have boards work properly,
we may need to keep old interface along with new interface for at
least a few commits even for tusb6010.

Straightaway if existing tusb6010 interface is modified (without
having new interface alongside), it will create problem for n8x0
as it has onenand still using old interface. And a board at a time
cannot use both.

And if we proceed in the reverse, i.e. convert onenand to use
new interface first (w/o having new interface alongside),
still n8x0 would have problems as tusb6010 would be using the old
interface then

So it seems, both interface has to live side-by-side till all
boards are converted (or at least till all boards using the
peripheral in question has to get converted to use new interface)

Regards
Afzal
