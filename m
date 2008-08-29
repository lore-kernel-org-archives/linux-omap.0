From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/1] ARM:OMAP3: Smartreflex disable/enable fix
Date: Fri, 29 Aug 2008 11:47:49 +0100
Message-ID: <20080829104749.GE22816@flint.arm.linux.org.uk>
References: <1220004344-32542-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49904 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbYH2KsB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Aug 2008 06:48:01 -0400
Content-Disposition: inline
In-Reply-To: <1220004344-32542-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Cc: linux-omap@vger.kernel.org

On Fri, Aug 29, 2008 at 01:05:44PM +0300, Kalle Jokiniemi wrote:
> Smartreflex modules have to be disabled when device enters WFI.
> Previously only suspend idle path had these calls. By moving the
> disable/enable calls to omap_sram_idle, all idle paths will be covered.

Won't deleting the calls from the suspend path break suspend/resume?
