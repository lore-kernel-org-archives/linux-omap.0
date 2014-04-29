From: Jenny Tc <jenny.tc@intel.com>
Subject: Re: [RFC] power_supply: Introduce generic psy charging driver
Date: Tue, 29 Apr 2014 09:05:09 +0530
Message-ID: <20140429033509.GA24114@jenny-desktop>
References: <1396843810-16743-1-git-send-email-jenny.tc@intel.com>
 <20140428165436.GA23310@jenny-desktop>
 <20140428175606.GA26042@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:3588 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460AbaD2DfR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Apr 2014 23:35:17 -0400
Content-Disposition: inline
In-Reply-To: <20140428175606.GA26042@amd.pavel.ucw.cz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Anton Vorontsov <anton.vorontsov@linaro.org>, Kim Milo <Milo.Kim@ti.com>, Jingoo Han <jg1.han@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Rhyland Klein <rklein@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Sebastian Reichel <sre@ring0.de>, aaro.koskinen@iki.fi, Pallala Ramakrishna <ramakrishna.pallala@intel.com>, freemangordon@abv.bg, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

On Mon, Apr 28, 2014 at 07:56:06PM +0200, Pavel Machek wrote:
> On Mon 2014-04-28 22:24:36, Jenny Tc wrote:
> > Dmitry/Pavel,
> > 
> > Request your feedback on this. Fixed the comments from Pavel and waiting for 
> > your feedback on the changes
> 
> IIRC, my latest comments were "this is completely misdesigned, it is
> using strings and table searches where it should use pointers". Did
> that change?

Yes, that's changed.

> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
