From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCHv3] media: i2c/adp1653: devicetree support for adp1653
Date: Sat, 4 Apr 2015 00:35:19 +0300
Message-ID: <20150403213519.GN20756@valkosipuli.retiisi.org.uk>
References: <20150402143846.GA11687@amd>
 <20150402161453.GH20756@valkosipuli.retiisi.org.uk>
 <20150402203043.GB29963@amd>
 <20150402234823.GI20756@valkosipuli.retiisi.org.uk>
 <20150403082344.GA14721@amd>
 <20150403112355.GJ20756@valkosipuli.retiisi.org.uk>
 <20150403202953.GA5116@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:51100 "EHLO
	hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751256AbbDCVf4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2015 17:35:56 -0400
Content-Disposition: inline
In-Reply-To: <20150403202953.GA5116@amd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, galak@codeaurora.org, bcousson@baylibre.com, m.chehab@samsung.com, devicetree@vger.kernel.org

On Fri, Apr 03, 2015 at 10:29:53PM +0200, Pavel Machek wrote:
> On Fri 2015-04-03 14:23:56, Sakari Ailus wrote:
> > Hi Pavel,
> > 
> > On Fri, Apr 03, 2015 at 10:23:44AM +0200, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > Hi Pawel,
> > > 
> > > I'm still Pavel. v, not w.
> > 
> > I know too many Pawels. Sorry about that. :-)
> > 
> 
> > > I guess it uses adp1653_id_table. I'd hade to add redundand
> > > information, because if it would just mask the errors if the code
> > > changed...
> > 
> > Indeed, that's true. This is comparing "adp1653" vs. comparing
> > "adi,adp1653". I think I still prefer the latter since it's got also the
> > vendor prefix included.
> > 
> > Suppose we change this later and someone misspelled the vendor prefix ---
> > their board would break.
> 
> Suppose we do what you suggest. That does not fix the problem, since
> code will still match the "adp1653" in case someone misspells it.
> 
> If you want to change how i2c device matching works, well, you can do
> it, but my patch is not right place to do that.

Good point. Let's leave it as-is.

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
