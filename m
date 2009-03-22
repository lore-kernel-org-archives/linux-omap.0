From: Samuel Ortiz <sameo@openedhand.com>
Subject: Re: [patch] twl4030-regulator: expose VPLL2
Date: Sun, 22 Mar 2009 20:19:35 +0100
Message-ID: <20090322191935.GB2832@sortiz.org>
References: <200903131754.54997.david-b@pacbell.net> <20090316155103.GJ16539@sirena.org.uk> <1237486426.6781.345.camel@vega.slimlogic.co.uk>
Reply-To: Samuel Ortiz <sameo@openedhand.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:30386 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754587AbZCVTR0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Mar 2009 15:17:26 -0400
Content-Disposition: inline
In-Reply-To: <1237486426.6781.345.camel@vega.slimlogic.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: dbrownell@users.sourceforge.net, OMAP <linux-omap@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Mark Brown <broonie@sirena.org.uk>

On Thu, Mar 19, 2009 at 06:13:46PM +0000, Liam Girdwood wrote:
> On Mon, 2009-03-16 at 15:51 +0000, Mark Brown wrote:
> > On Fri, Mar 13, 2009 at 05:54:54PM -0700, David Brownell wrote:
> > > From: David Brownell <dbrownell@users.sourceforge.net>
> > > 
> > > Add VPLL2 to the set of twl4030-family regulators exposed for
> > > use by various drivers.  It's commonly used to power the digital
> > > video outputs (e.g. LCD or DVI displays) on OMAP3 systems.
> > > 
> > > Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> > 
> > Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> Samuel, I've applied this to the regulator tree as the part that touches
> mfd is relatively minor and twl4030 specific (doesn't touch core).
Thanks a lot, and sorry for the late reply...
Feel free to add my Acked-by: if needed.

Cheers,
Samuel.

 
> Thanks
> 
> Liam
> 

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
