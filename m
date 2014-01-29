From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 4/4] power_supply: bq24261 charger driver
Date: Wed, 29 Jan 2014 16:26:45 +0900
Message-ID: <000001cf1cc3$7747ac20$65d70460$%han@samsung.com>
References: <1390411194-21410-1-git-send-email-jenny.tc@intel.com>
 <1390411194-21410-5-git-send-email-jenny.tc@intel.com>
 <20140128141445.GC8713@xo-6d-61-c0.localdomain>
 <20140129132334.GB15355@jenny-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:30011 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbaA2H0t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Jan 2014 02:26:49 -0500
In-reply-to: <20140129132334.GB15355@jenny-desktop>
Content-language: ko
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Jenny Tc' <jenny.tc@intel.com>, 'Pavel Machek' <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, 'Dmitry Eremin-Solenikov' <dbaryshkov@gmail.com>, 'Anton Vorontsov' <cbouatmailru@gmail.com>, 'Anton Vorontsov' <anton.vorontsov@linaro.org>, 'Kim Milo' <Milo.Kim@ti.com>, 'Lee Jones' <lee.jones@linaro.org>, 'Chanwoo Choi' <cw00.choi@samsung.com>, 'Sachin Kamat' <sachin.kamat@linaro.org>, 'Rupesh Kumar' <rupesh.kumar@stericsson.com>, 'Lars-Peter Clausen' <lars@metafoo.de>, 'Pali Roh?r' <pali.rohar@gmail.com>, 'Mark Brown' <broonie@opensource.wolfsonmicro.com>, 'Rhyland Klein' <rklein@nvidia.com>, 'David Woodhouse' <dwmw2@infradead.org>, 'Tony Lindgren' <tony@atomide.com>, 'Russell King' <linux@arm.linux.org.uk>, 'Sebastian Reichel' <sre@ring0.de>, aaro.koskinen@iki.fi, freemangordon@abv.bg, linux-omap@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

On Wednesday, January 29, 2014 10:24 PM, Jenny Tc wrote:
> On Tue, Jan 28, 2014 at 07:14:45AM -0700, Pavel Machek wrote:
> > > +#define BQ24261_ICHRG_MASK		(0x1F << 3)
> > > +#define BQ24261_ICHRG_100ma		(0x01 << 3)
> > > +#define BQ24261_ICHRG_200ma		(0x01 << 4)
> > > +#define BQ24261_ICHRG_400ma		(0x01 << 5)
> > > +#define BQ24261_ICHRG_800ma		(0x01 << 6)
> > > +#define BQ24261_ICHRG_1600ma		(0x01 << 7)
> >
> > First, its mA, not ma.
> 
> Camel Case allowed? Ignore Checkpatch.pl warning?

Yep, Camel Case is allowed by the commit d8b0771 "checkpatch:
extend CamelCase types and ignore existing CamelCase uses in
a patch".

Thus, the following cases are currently allowed.

#define BQ24261_ICHRG_1600ma           (0x01 << 7)
#define BQ24261_ICHRG_1600MA           (0x01 << 7)
#define BQ24261_ICHRG_1600mA           (0x01 << 7)
....

Best regards,
Jingoo Han

> > > +u16 bq24261_iterm[][2] = {
> > > +	{0, 0x00}
> > > +	,
> > > +	{50, BQ24261_ITERM_50ma}
> > > +	,
> > > +	{100, BQ24261_ITERM_100ma}
> > > +	,
> > > +	{150, BQ24261_ITERM_100ma | BQ24261_ITERM_50ma}
> >
> > ...this is very obscure way to do with table what can be done with
> >
> > (x/50) << 3, right ?
> 
> Few register settings need table mapping, but some can have logic as your
> comment say. Just wanted to keep same logic for all register settings.
> Doesn't it make more readable?
> 
> > > +u16 bq24261_cc[][2] = {
> > > +
> > > +	{500, 0x00}
> > > +	,
> > > +	{600, BQ24261_ICHRG_100ma}
> > > +	,
> > > +	{700, BQ24261_ICHRG_200ma}
> > > +	,
> > > +	{800, BQ24261_ICHRG_100ma | BQ24261_ICHRG_200ma}
> > > +	,
> > > +	{900, BQ24261_ICHRG_400ma}
> >
> > I suspect you can get rid of this, too, if you expand macros.
> Same as above comment.
> 
> -Jenny

