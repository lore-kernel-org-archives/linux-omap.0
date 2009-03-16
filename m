From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [patch] twl4030-regulator: expose VPLL2
Date: Mon, 16 Mar 2009 15:51:04 +0000
Message-ID: <20090316155103.GJ16539@sirena.org.uk>
References: <200903131754.54997.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:1676 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbZCPPvI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2009 11:51:08 -0400
Content-Disposition: inline
In-Reply-To: <200903131754.54997.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dbrownell@users.sourceforge.net
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, OMAP <linux-omap@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

On Fri, Mar 13, 2009 at 05:54:54PM -0700, David Brownell wrote:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Add VPLL2 to the set of twl4030-family regulators exposed for
> use by various drivers.  It's commonly used to power the digital
> video outputs (e.g. LCD or DVI displays) on OMAP3 systems.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
