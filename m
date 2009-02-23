From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [rft/rfc/patch-v2.6.29-rc5+ 05/23] usb: host: ehci: use
	resource helpers
Date: Tue, 24 Feb 2009 00:34:47 +0200
Message-ID: <20090223223446.GG4676@gandalf>
References: <1235415171-17376-1-git-send-email-me@felipebalbi.com> <1235415171-17376-2-git-send-email-me@felipebalbi.com> <1235415171-17376-3-git-send-email-me@felipebalbi.com> <1235415171-17376-4-git-send-email-me@felipebalbi.com> <1235415171-17376-5-git-send-email-me@felipebalbi.com> <1235415171-17376-6-git-send-email-me@felipebalbi.com> <49A32352.1060009@vocollect.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:49468 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459AbZBWWez (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 17:34:55 -0500
Content-Disposition: inline
In-Reply-To: <49A32352.1060009@vocollect.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Josh Karabin <gkarabin@vocollect.com>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>, Anand Gadiyar <gadiyar@ti.com>, Syed Mohammed Khasim <x0khasim@ti.com>

On Mon, Feb 23, 2009 at 05:29:38PM -0500, Josh Karabin wrote:
> > -	if (pdev->resource[1].flags != IORESOURCE_IRQ) {
> > -		dev_dbg(&pdev->dev, "resource[1] is not IORESOURCE_IRQ\n");
> > -		retval = -ENOMEM;
> > -	}
> > -
> 
> Your patch description doesn't explain why you removed this code.  Was it intentional?
> I didn't see that any of the helpers called below covered the case, but I didn't look too hard.

int irq = platform_get_irq(pdev, 0);

-- 
balbi
