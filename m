From: Andrew Chew <AChew@nvidia.com>
Subject: RE: [PATCH 2/2 v2] pwm_bl: Add mandatory backlight enable regulator
Date: Wed, 13 Mar 2013 14:10:16 -0700
Message-ID: <643E69AA4436674C8F39DCC2C05F7638629CA51A0B@HQMAIL03.nvidia.com>
References: <1363126934-8754-1-git-send-email-achew@nvidia.com>
 <1363126934-8754-3-git-send-email-achew@nvidia.com> <51403F59.2090303@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:5591 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934216Ab3CMVKX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Mar 2013 17:10:23 -0400
In-Reply-To: <51403F59.2090303@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: "thierry.reding@avionic-design.de" <thierry.reding@avionic-design.de>, Alex Courbot <acourbot@nvidia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> > +static void pwm_backlight_enable(struct backlight_device *bl) {
> > +	struct pwm_bl_data *pb = dev_get_drvdata(&bl->dev);
> > +
> > +	/* Bail if we are already enabled. */
> > +	if (pb->enabled)
> > +		return;
> > +
> > +	pwm_enable(pb->pwm);
> > +
> > +	if (regulator_enable(pb->enable_supply) != 0)
> 
> I would loose the '!= 0'

I think I prefer the '!= 0'.  Without it, it looks at first glance
like regulator_enable() is following boolean semantics,
so it reads kind of weird.  But I'll defer to Thierry on this
one.  Thierry, what's your preference?
