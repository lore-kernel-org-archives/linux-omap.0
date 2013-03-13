From: Andrew Chew <AChew@nvidia.com>
Subject: RE: [PATCH 2/2 v2] pwm_bl: Add mandatory backlight enable regulator
Date: Wed, 13 Mar 2013 14:39:06 -0700
Message-ID: <643E69AA4436674C8F39DCC2C05F7638629CA51A27@HQMAIL03.nvidia.com>
References: <1363126934-8754-1-git-send-email-achew@nvidia.com>
 <1363126934-8754-3-git-send-email-achew@nvidia.com>
 <51403F59.2090303@ti.com>
 <643E69AA4436674C8F39DCC2C05F7638629CA51A0B@HQMAIL03.nvidia.com>
 <20130313213610.GB29402@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:8316 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755265Ab3CMVjX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Mar 2013 17:39:23 -0400
In-Reply-To: <20130313213610.GB29402@avionic-0098.mockup.avionic-design.de>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Alex Courbot <acourbot@nvidia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> On Wed, Mar 13, 2013 at 02:10:16PM -0700, Andrew Chew wrote:
> > > > +static void pwm_backlight_enable(struct backlight_device *bl) {
> > > > +	struct pwm_bl_data *pb = dev_get_drvdata(&bl->dev);
> > > > +
> > > > +	/* Bail if we are already enabled. */
> > > > +	if (pb->enabled)
> > > > +		return;
> > > > +
> > > > +	pwm_enable(pb->pwm);
> > > > +
> > > > +	if (regulator_enable(pb->enable_supply) != 0)
> > >
> > > I would loose the '!= 0'
> >
> > I think I prefer the '!= 0'.  Without it, it looks at first glance
> > like regulator_enable() is following boolean semantics, so it reads
> > kind of weird.  But I'll defer to Thierry on this one.  Thierry,
> > what's your preference?
> 
> Why not assign the return value of regulator_enable() to a variable, for
> instance "err", and make that part of the warning message so that people will
> have a better chance to diagnose what's going wrong?

That's a good idea.  I'll have that modification in the next patch series that I
post.
