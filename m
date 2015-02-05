From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/PATCH 2/2] of: allow for boolean flags to have value
Date: Thu, 5 Feb 2015 10:34:12 -0800
Message-ID: <20150205183411.GC25235@atomide.com>
References: <1423159266-25561-1-git-send-email-balbi@ti.com>
 <1423159266-25561-2-git-send-email-balbi@ti.com>
 <20150205182240.GD20735@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp6.ore.mailhop.org ([54.149.35.133]:40310 "EHLO
	smtp6.ore.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516AbbBESgy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Feb 2015 13:36:54 -0500
Content-Disposition: inline
In-Reply-To: <20150205182240.GD20735@leverpostej>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Felipe Balbi <balbi@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

* Mark Rutland <mark.rutland@arm.com> [150205 10:26]:
> On Thu, Feb 05, 2015 at 06:01:06PM +0000, Felipe Balbi wrote:
> > allowing values to boolean flags lets us setup
> > defaults on DTSI which can get disabled later
> > at board DTS if, for whatever reason, board can't
> > use that default.
> > 
> > One such example is DM81xx EVM where we can't use
> > MUSB's multipoint feature even though SoC supports
> > it. Something at the board level prevents us from
> > using the feature.
> > 
> > Instead of removing "multipoint;" from DTSI and
> > adding it to all board DTS just so we can remove
> > it from our quirky board seems like overkill when
> > we could just add:
> > 
> > 	multipoint = <0>;
> > 
> > to that quirky board's DTS.
> > 
> > Note that the description here is but one example
> > and it's likely many others have faced something
> > similar.
> > 
> 
> While I appreciate that adding and removing properties in this way is
> painful, I think that this must be dealt with at DTB compile-time rather
> than kernel run-time.
> 
> There are codebases other than Linux which parse DTs, and not all
> drivers call of_property_read_bool to parse boolean properties, an awful
> lot still just check of_find_property. Additionally, some bindings
> _explicitly_ state boolean properties are empty and have no value, which
> this extension would break.
> 
> I think that this patch only adds to the inconsistency we currently
> have, and given that, I would rather not have this extension to
> of_property_read_bool.
> 
> Arguably of_proeprty_read_bool should warn if it encounters a non-empty
> property.

How about a WARN_ON there as in that case the value will always
be set to 1 in kernel even if specified as 0 in the .dts file?

Regards,

Tony
