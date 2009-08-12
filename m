From: Tony Lindgren <tony@atomide.com>
Subject: Re: linux-omap-2.6 git not updated?
Date: Wed, 12 Aug 2009 20:41:03 +0300
Message-ID: <20090812174103.GO7278@atomide.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB03060505F9@dbde02.ent.ti.com> <20090812134839.GJ7278@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53723 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbZHLRlF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 13:41:05 -0400
Content-Disposition: inline
In-Reply-To: <20090812134839.GJ7278@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

* Tony Lindgren <tony@atomide.com> [090812 16:48]:
> * Gadiyar, Anand <gadiyar@ti.com> [090812 16:27]:
> > Tony,
> > 
> > Is something wrong with the kernel.org mirror? The last commit
> > I see is:
> > 
> > commit 4baadee6e2dd5228e1b17cb5f931c4e0ed8fcb96
> > Author: Anand Gadiyar <gadiyar@ti.com>
> > Date:   Wed Aug 5 16:22:59 2009 +0300
> > 
> > I do see that the other branches (upstream, omap4, ...)
> > are updated. Looks like only the master is not yet
> > reflecting the patches you applied in the last 7 days.
> 
> Yeah I have not updated master yet with the patches going upstream.
> Will reset arch/arm/*omap* in master, and merge in the posted
> upstream branches.

Updated now with the patches queued for mainline.

Tony
