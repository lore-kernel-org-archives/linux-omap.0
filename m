From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] ARM:OMAP3: Smartreflex disable/enable fix
Date: Wed, 10 Sep 2008 10:55:22 -0700
Message-ID: <20080910175522.GE21163@atomide.com>
References: <1220004344-32542-1-git-send-email-ext-kalle.jokiniemi@nokia.com> <20080829104749.GE22816@flint.arm.linux.org.uk> <1220010935.6269.47.camel@kj-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50972 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbYIJRzg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 13:55:36 -0400
Content-Disposition: inline
In-Reply-To: <1220010935.6269.47.camel@kj-ubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Cc: ext Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org

* Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com> [080829 04:54]:
> On pe, 2008-08-29 at 11:47 +0100, ext Russell King - ARM Linux wrote:
> > On Fri, Aug 29, 2008 at 01:05:44PM +0300, Kalle Jokiniemi wrote:
> > > Smartreflex modules have to be disabled when device enters WFI.
> > > Previously only suspend idle path had these calls. By moving the
> > > disable/enable calls to omap_sram_idle, all idle paths will be covered.
> > 
> > Won't deleting the calls from the suspend path break suspend/resume?
> 
> No, since omap3_pm_suspend calls omap_sram_idle. The disabling is just
> moves one step later. Also omap3_pm_idle and the idle loop in cpu idle
> call omap_sram_idle, so they get covered as well.

Pushing today.

Tony
