From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv3] media: i2c/adp1653: devicetree support for adp1653
Date: Fri, 3 Apr 2015 22:29:53 +0200
Message-ID: <20150403202953.GA5116@amd>
References: <20150402143846.GA11687@amd>
 <20150402161453.GH20756@valkosipuli.retiisi.org.uk>
 <20150402203043.GB29963@amd>
 <20150402234823.GI20756@valkosipuli.retiisi.org.uk>
 <20150403082344.GA14721@amd>
 <20150403112355.GJ20756@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46980 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277AbbDCU3z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2015 16:29:55 -0400
Content-Disposition: inline
In-Reply-To: <20150403112355.GJ20756@valkosipuli.retiisi.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: Andrew Morton <akpm@osdl.org>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, galak@codeaurora.org, bcousson@baylibre.com, m.chehab@samsung.com, devicetree@vger.kernel.org

On Fri 2015-04-03 14:23:56, Sakari Ailus wrote:
> Hi Pavel,
> 
> On Fri, Apr 03, 2015 at 10:23:44AM +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > Hi Pawel,
> > 
> > I'm still Pavel. v, not w.
> 
> I know too many Pawels. Sorry about that. :-)
> 

> > I guess it uses adp1653_id_table. I'd hade to add redundand
> > information, because if it would just mask the errors if the code
> > changed...
> 
> Indeed, that's true. This is comparing "adp1653" vs. comparing
> "adi,adp1653". I think I still prefer the latter since it's got also the
> vendor prefix included.
> 
> Suppose we change this later and someone misspelled the vendor prefix ---
> their board would break.

Suppose we do what you suggest. That does not fix the problem, since
code will still match the "adp1653" in case someone misspells it.

If you want to change how i2c device matching works, well, you can do
it, but my patch is not right place to do that.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
