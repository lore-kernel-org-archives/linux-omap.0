From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [PATCH] MTD: OMAP2-NAND: Fix partition reading from board info
Date: Mon, 4 Aug 2008 22:17:15 +0200
Message-ID: <20080804201715.GD31974@xi.wantstofly.org>
References: <9c9fda240807011627v60428f9eh3c2bb17cdc8ce6ea@mail.gmail.com> <DFEF307E035C8647B119E6A60DB62D4AE47C155A@dlee02.ent.ti.com> <20080804142426.GK8885@atomide.com> <200808041302.46323.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from xi.wantstofly.org ([83.160.184.112]:56481 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753205AbYHDUgp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Aug 2008 16:36:45 -0400
Content-Disposition: inline
In-Reply-To: <200808041302.46323.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "Kamat, Nishant" <nskamat@ti.com>, Tony Lindgren <tony@atomide.com>, Kyungmin Park <kmpark@infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

On Mon, Aug 04, 2008 at 01:02:46PM -0700, David Brownell wrote:

> > Looks like this driver does not exist outside linux-omap tree,
> > care to send the whole driver to MTD list?
> 
> Unless someone created a big-endian OMAP,

Don't they use standard ARM ARM cores, which can all be used in both
LE and BE modes?
