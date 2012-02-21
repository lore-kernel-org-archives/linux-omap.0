From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] Move most of omap io.h into omap-iomap.h
Date: Tue, 21 Feb 2012 14:34:08 -0800
Message-ID: <20120221223408.GS18185@atomide.com>
References: <20120213235216.26087.66303.stgit@kaulin.local>
 <20120214171816.GN1426@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:24595 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755978Ab2BUWeL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Feb 2012 17:34:11 -0500
Content-Disposition: inline
In-Reply-To: <20120214171816.GN1426@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [120214 08:47]:
> * Tony Lindgren <tony@atomide.com> [120213 15:22]:
> > Hi all,
> > 
> > This is intended as clean-up before we apply Rob Herring's series
> > to remove mach/io.h.
> 
> Need to update this to fix up more driver modules though.

Also we can move almost everything into local iomap.h files.

So let's scrap this series, I will post a new series shortly.

Regards,

Tony
