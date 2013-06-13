From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 2/3] USB: OMAP: add omap-otg
Date: Fri, 14 Jun 2013 01:37:11 +0300
Message-ID: <20130613223711.GD18360@blackmetal.musicnaut.iki.fi>
References: <1370817606-1008-1-git-send-email-aaro.koskinen@iki.fi>
 <1370817606-1008-3-git-send-email-aaro.koskinen@iki.fi>
 <20130612151326.GE15056@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:48291 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899Ab3FMWhW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Jun 2013 18:37:22 -0400
Content-Disposition: inline
In-Reply-To: <20130612151326.GE15056@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

Hi,

On Wed, Jun 12, 2013 at 06:13:26PM +0300, Felipe Balbi wrote:
> On Mon, Jun 10, 2013 at 01:40:05AM +0300, Aaro Koskinen wrote:
> > +void omap_otg_set_mode(enum omap_otg_mode mode)
> > +{
> > +	if (!otg_dev) {
> > +		WARN(1, "%s: controller not present\n", __func__);
> > +		return;
> > +	}
> > +	mutex_lock(&otg_dev->serialize);
> > +	switch (mode) {
> > +	case OMAP_OTG_MODE_DEVICE:
> > +		/*
> > +		 * Set B-session valid.
> > +		 */
> > +		omap_otg_ctrl(OMAP_OTG_ID | OMAP_OTG_BSESSVLD);
> > +		break;
> > +	case OMAP_OTG_MODE_HOST:
> > +		/*
> > +		 * Set A-session valid.
> > +		 */
> > +		omap_otg_ctrl(OMAP_OTG_ASESSVLD);
> > +		break;
> > +	case OMAP_OTG_MODE_DISCONNECT:
> > +		/*
> > +		 * Set B-session end to indicate no VBUS.
> > +		 */
> > +		omap_otg_ctrl(OMAP_OTG_ID | OMAP_OTG_BSESSEND);
> > +		break;
> > +	default:
> > +		WARN(1, "%s: unknown mode: %d\n", __func__, mode);
> > +	}
> > +	mutex_unlock(&otg_dev->serialize);
> > +}
> > +EXPORT_SYMBOL_GPL(omap_otg_set_mode);
> 
> looks like this should provide a extcon interface for its users.

Is there any examples available? Anyway, I'll look into this.

Thanks,

A.
