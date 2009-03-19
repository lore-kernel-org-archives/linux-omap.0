From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [patch] twl4030-regulator: expose VPLL2
Date: Thu, 19 Mar 2009 18:13:46 +0000
Message-ID: <1237486426.6781.345.camel@vega.slimlogic.co.uk>
References: <200903131754.54997.david-b@pacbell.net>
	 <20090316155103.GJ16539@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760673AbZCSSOJ@vger.kernel.org>
In-Reply-To: <20090316155103.GJ16539@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@openedhand.com>
Cc: dbrownell@users.sourceforge.net, OMAP <linux-omap@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Mark Brown <broonie@sirena.org.uk>
List-Id: linux-omap@vger.kernel.org

On Mon, 2009-03-16 at 15:51 +0000, Mark Brown wrote:
> On Fri, Mar 13, 2009 at 05:54:54PM -0700, David Brownell wrote:
> > From: David Brownell <dbrownell@users.sourceforge.net>
> > 
> > Add VPLL2 to the set of twl4030-family regulators exposed for
> > use by various drivers.  It's commonly used to power the digital
> > video outputs (e.g. LCD or DVI displays) on OMAP3 systems.
> > 
> > Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Samuel, I've applied this to the regulator tree as the part that touches
mfd is relatively minor and twl4030 specific (doesn't touch core).

Thanks

Liam
