From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 1/3] [RFC] clk: introduce clk_associate
Date: Wed, 15 Oct 2008 17:41:49 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE89671620365CA801A@dlee02.ent.ti.com>
References: <200810010851.47774.david-b@pacbell.net>
 <20081001155755.GG7412@gandalf.research.nokia.com>
 <200810010915.46032.david-b@pacbell.net>
 <20081001.213437.22091635.Hiroshi.DOYU@nokia.com>
 <alpine.DEB.2.00.0810140712570.15253@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40484 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195AbYJOWmK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 18:42:10 -0400
In-Reply-To: <alpine.DEB.2.00.0810140712570.15253@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "david-b@pacbell.net" <david-b@pacbell.net>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

Hi,

> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Paul Walmsley

> between omap_clk_associate() and vclk, my preference is for the
> omap_clk_associate() approach.
>
> The core problem is that the vclk patches create clocks with multiple
> parents in a way that is hidden from the clock framework.  This causes
> both semantic and practical problems.
>
> Semantically, the patches cause the meaning of set_rate() and set_parent()
> to be confused, and any driver that wants to call set_parent() or
> set_rate() on those clocks will need to have their own custom functions
> for those operations.  I'd like to keep the amount of that custom code
> minimized.

I agree and these mirror my comments when it was first proposed.

Having a virtual node does however have some benefits which may be worth exploiting for future.

For these types of nodes it might be they just return an error if someone tries to use them.  Or have some way to get its attributes.

When you do allow a set rate on a virtual clock it will have to be custom.  There may be a number of valid internal combinations.  Providing a "clock-cluster" OPP table is probably enough.

Regards,
Richard W.

