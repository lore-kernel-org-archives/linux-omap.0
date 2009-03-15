From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc8 regulator-next] regulator: init fixes (v4)
Date: Sat, 14 Mar 2009 21:05:29 -0700
Message-ID: <200903142105.29382.david-b@pacbell.net>
References: <200903111743.34708.david-b@pacbell.net> <200903141725.35541.david-b@pacbell.net> <20090315003743.GB11052@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n29.bullet.mail.mud.yahoo.com ([68.142.207.48]:43647 "HELO
	n29.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757349AbZCOEFd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 15 Mar 2009 00:05:33 -0400
In-Reply-To: <20090315003743.GB11052@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Saturday 14 March 2009, Mark Brown wrote:
> On Sat, Mar 14, 2009 at 05:25:35PM -0700, David Brownell wrote:
> 
> > +	} else if (ops->is_enabled) {
> > +		/* ... if the bootloader left it on, drivers need a
> > +		 * nonzero enable count else it can't be disabled.
> > +		 */
> > +		ret = ops->is_enabled(rdev);
> > +		if (ret > 0)
> > +			rdev->use_count = 1;
> > +		ret = 0;
> 
> This means that drivers that do balanced enables and disables will never
> be able to cause the regulator to actually be disabled since there will
> always be this extra reference count there. 

That's already true for every regulator for which the "boot_on"
flag was set ... nothing changes.  Except that things act the
same now regardless of whether Linux or the bootloader enabled
the regulator in the first place; win!  :)

On the other hand, every driver using a regulator for which that
flag could have be set (== ALL of them) needs to be able to cope
with the regulator having been enabled when the device probe()
was called.  It's not exactly hard to check if it was enabled, then
act accordingly, in the typical "single consumer of the regulator"
case.


> Without this patch what'll 
> happen with those drivers is that they'll do an enable then later on
> when the last one disables its supply the reference count will fall to
> zero and the regulator will be disabled.

If they're prepared to work with a regulator enabled at boot time
by either the bootloader or (as its proxy) Linux, they'll first look
to see if the regulator is enabled.

Of course, trying to share a regulator that's set up like that can
bring its own joys.  This patch doesn't change that issue, but it
does get rid of one nasty initialization problem.


