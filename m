From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 11/14] OMAP4: PRCM: reorganize existing OMAP4 PRCM header
 files
Date: Tue, 7 Dec 2010 23:40:03 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012072338130.13430@utopia.booyaka.com>
References: <20101207012242.3708.45451.stgit@twilight.localdomain> <20101207012514.3708.87532.stgit@twilight.localdomain> <4CFE9C7C.6060101@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52317 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482Ab0LHGkF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 01:40:05 -0500
In-Reply-To: <4CFE9C7C.6060101@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, tony@atomide.com, khilman@deeprootsystems.com, "Nayak, Rajendra" <rnayak@ti.com>

On Tue, 7 Dec 2010, Cousson, Benoit wrote:

> On 12/7/2010 2:25 AM, Paul Walmsley wrote:
> 
> [...]
> 
> > + *
> > + * XXX This file needs to be updated to align on one of "OMAP4",
> > "OMAP44XX",
> > + *     or "OMAP4430".
> 
> Yep, I was thinking to change that as well. My first thought was OMAP4 to get
> a shorter name, but when we will introduce OMAP4440, we might have some new
> entries, that will looks ugly close to OMAP4.
> So at the end I will prefer OMAP44XX for the moment and we might renamed to
> OMAP4430 or OMAP4440 for the entries that will diverge.
> 
> Do you want to change that for 2.6.38?
> It will require some sync with the various users of these defines, but that
> should be doable.

I don't mind waiting until after 2.6.38, I think we'll have a pretty huge 
pile of patches on our hands to merge already for .38... maybe Tony or 
Kevin have some opinions though.


- Paul
