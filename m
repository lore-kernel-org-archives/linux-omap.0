From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: Re: [PATCH 1/1] ARM:OMAP3: Smartreflex disable/enable fix
Date: Fri, 29 Aug 2008 14:55:35 +0300
Message-ID: <1220010935.6269.47.camel@kj-ubuntu>
References: <1220004344-32542-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
	 <20080829104749.GE22816@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:46905 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757067AbYH2LwE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Aug 2008 07:52:04 -0400
In-Reply-To: <20080829104749.GE22816@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

On pe, 2008-08-29 at 11:47 +0100, ext Russell King - ARM Linux wrote:
> On Fri, Aug 29, 2008 at 01:05:44PM +0300, Kalle Jokiniemi wrote:
> > Smartreflex modules have to be disabled when device enters WFI.
> > Previously only suspend idle path had these calls. By moving the
> > disable/enable calls to omap_sram_idle, all idle paths will be covered.
> 
> Won't deleting the calls from the suspend path break suspend/resume?

No, since omap3_pm_suspend calls omap_sram_idle. The disabling is just
moves one step later. Also omap3_pm_idle and the idle loop in cpu idle
call omap_sram_idle, so they get covered as well.

regards,
Kalle
