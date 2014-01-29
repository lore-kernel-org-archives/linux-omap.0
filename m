From: Jenny Tc <jenny.tc@intel.com>
Subject: Re: [PATCH 4/4] power_supply: bq24261 charger driver
Date: Wed, 29 Jan 2014 18:53:34 +0530
Message-ID: <20140129132334.GB15355@jenny-desktop>
References: <1390411194-21410-1-git-send-email-jenny.tc@intel.com>
 <1390411194-21410-5-git-send-email-jenny.tc@intel.com>
 <20140128141445.GC8713@xo-6d-61-c0.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19555 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750845AbaA2FbM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Jan 2014 00:31:12 -0500
Content-Disposition: inline
In-Reply-To: <20140128141445.GC8713@xo-6d-61-c0.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Anton Vorontsov <anton.vorontsov@linaro.org>, Kim Milo <Milo.Kim@ti.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Rupesh Kumar <rupesh.kumar@stericsson.com>, Lars-Peter Clausen <lars@metafoo.de>, Pali Roh?r <pali.rohar@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Rhyland Klein <rklein@nvidia.com>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Sebastian Reichel <sre@ring0.de>, "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>, "freemangordon@abv.bg" <freemangordon@abv.bg>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Jan 28, 2014 at 07:14:45AM -0700, Pavel Machek wrote:
> > +#define BQ24261_ICHRG_MASK		(0x1F << 3)
> > +#define BQ24261_ICHRG_100ma		(0x01 << 3)
> > +#define BQ24261_ICHRG_200ma		(0x01 << 4)
> > +#define BQ24261_ICHRG_400ma		(0x01 << 5)
> > +#define BQ24261_ICHRG_800ma		(0x01 << 6)
> > +#define BQ24261_ICHRG_1600ma		(0x01 << 7)
> 
> First, its mA, not ma.

Camel Case allowed? Ignore Checkpatch.pl warning?
> > +u16 bq24261_iterm[][2] = {
> > +	{0, 0x00}
> > +	,
> > +	{50, BQ24261_ITERM_50ma}
> > +	,
> > +	{100, BQ24261_ITERM_100ma}
> > +	,
> > +	{150, BQ24261_ITERM_100ma | BQ24261_ITERM_50ma}
> 
> ...this is very obscure way to do with table what can be done with
> 
> (x/50) << 3, right ?

Few register settings need table mapping, but some can have logic as your
comment say. Just wanted to keep same logic for all register settings.
Doesn't it make more readable?

> > +u16 bq24261_cc[][2] = {
> > +
> > +	{500, 0x00}
> > +	,
> > +	{600, BQ24261_ICHRG_100ma}
> > +	,
> > +	{700, BQ24261_ICHRG_200ma}
> > +	,
> > +	{800, BQ24261_ICHRG_100ma | BQ24261_ICHRG_200ma}
> > +	,
> > +	{900, BQ24261_ICHRG_400ma}
> 
> I suspect you can get rid of this, too, if you expand macros.
Same as above comment.

-Jenny
