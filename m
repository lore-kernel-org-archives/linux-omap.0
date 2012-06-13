From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/9] ARM: OMAP2+: gpmc-smc91x: Adapt to use gpmc driver
Date: Wed, 13 Jun 2012 06:43:24 -0700
Message-ID: <20120613134323.GX12766@atomide.com>
References: <cover.1339419379.git.afzal@ti.com>
 <0bdbc293fc98613011d37ec59559ba6d475eadf2.1339419379.git.afzal@ti.com>
 <20120613122950.GR12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998EC1@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61400 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664Ab2FMNn1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jun 2012 09:43:27 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E998EC1@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Mohammed, Afzal <afzal@ti.com> [120613 06:43]:
> Hi Tony,
> 
> On Wed, Jun 13, 2012 at 17:59:50, Tony Lindgren wrote:
> 
> > Here too we just need to care about the mainline kernel users
> > and convert them to use the new interface. No need to keep
> > gpmc_cs_set_timings around. The same applies for other similar
> > patches.
> 
> Not sure whether I follow you here.
> 
> Do you mean for all the gpmc-* helpers existing initialization
> needs to be modified to use the new interface, the previous version
> was doing so. But then that will cause all boards using the same
> gpmc-* helper to be converted at once (tusb6010 is not an issue as
> only one board uses it), then the problem will be that there would
> be a few commits where gpmc may not work properly.
> 
> And for a particular board, either it has to use old interface
> or either the new interface, it cannot use both.
> 
> Consider the case of this one, smc91x, all sdp boards use it,
> that requires nand, onenand, nor gpmc-* helpers to be converted
> before board migration for say 3430sdp board, that would mean
> that 2430sdp board would be broken w.r.t gpmc at that commit as
> board modifications are not yet done for 2430. That in turn means
> all the boards using nand, onenand would be broken at that point.

What I mean is keep the old interface in gpmc.c, then convert
users one at a time to the new interface, and remove the old
interface code from the users. But yeah you're right, it may
not be immediately doable for the smc91x case before we dump
out the register values. But at least tusb6010 should be able
to just convert to use the new interface and drop the old code.

Tony
