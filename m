From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [patch 2.6.29-rc7-omap-git] Overo: MMC regulator configuration
Date: Wed, 11 Mar 2009 22:59:45 +0200
Message-ID: <20090311205944.GA19038@gandalf>
References: <200903111158.29860.david-b@pacbell.net> <20090311193347.GC19730@gandalf> <200903111334.59499.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:51531 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbZCKU74 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 16:59:56 -0400
Content-Disposition: inline
In-Reply-To: <200903111334.59499.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: me@felipebalbi.com, OMAP <linux-omap@vger.kernel.org>, Steve Sakoman <steve@sakoman.com>, Mark Brown <broonie@sirena.org.uk>

On Wed, Mar 11, 2009 at 12:34:59PM -0800, David Brownell wrote:
> On Wednesday 11 March 2009, Felipe Balbi wrote:
> > with this patch I get:
> > 
> > regulator: Unable to get requested regulator: vmmc_aux
> 
> That's completely safe; annoying and useless noise from
> the regulator core, that's all.

You're right. And the appended patch should probably get merged via
Mark as it really makes sense when bootloader keeps the regulator on.

-- 
balbi
