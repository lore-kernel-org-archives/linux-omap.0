From: Tony Lindgren <tony@atomide.com>
Subject: Re: Missing OMAP nand drivers from 2.6.30?
Date: Mon, 22 Jun 2009 09:07:33 +0300
Message-ID: <20090622060731.GC4657@atomide.com>
References: <1245431093.24284.4.camel@blitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61152 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbZFVGHi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jun 2009 02:07:38 -0400
Content-Disposition: inline
In-Reply-To: <1245431093.24284.4.camel@blitz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peterb@logicpd.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

* Peter Barada <peterb@logicpd.com> [090619 20:03]:
> Looking at the current linux-omap tree from yesterday, I'm wondering
> where the NAND chip driver for the OMAP34x/35x is.  It used to be in
> drivers/mtd/nand/omap2.c, but there's no trace of it now (that I can
> find).
> 
> Any ideas where it went?

Please see $ git log | grep "REMOVE OMAP LEGACY CODE".

Basically those drivers should be cleaned up and sent to the MTD
list for integration to the mainline tree. If you are you using
them, please go for it if you have a chance!

Regards,

Tony
