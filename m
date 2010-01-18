From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [PATCH] OMAP3630:DSS2:Enable Pre-Multiplied Alpha Support
Date: Mon, 18 Jan 2010 14:24:29 +0200
Message-ID: <1263817469.2352.7.camel@tubuntu.research.nokia.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94026B2DBBB2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:29770 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754953Ab0ARMWp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jan 2010 07:22:45 -0500
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026B2DBBB2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Y, Kishore" <kishore.y@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Mande, Nikhil" <nikhil@ti.com>

On Mon, 2010-01-18 at 12:26 +0100, ext Y, Kishore wrote:
> > -----Original Message-----
> > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> > Sent: Friday, January 15, 2010 4:00 PM
> > To: Y, Kishore
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: [PATCH] OMAP3630:DSS2:Enable Pre-Multiplied Alpha Support
> > 
> > Hi,
> > 
> > On Mon, 2009-12-21 at 16:06 +0100, ext Y, Kishore wrote:
> > > From 2f873819a4b9eb0bd658db1e59408d8f0aeb14b6 Mon Sep 17 00:00:00 2001
> > > From: Sudeep Basavaraj <sudeep.basavaraj@ti.com>
> > > Date: Mon, 14 Dec 2009 18:54:51 +0530
> > > Subject: [PATCH] OMAP3630:DSS2:Enable Pre-Multiplied Alpha Support
> > >
> > > Enables dss to process color formats with pre-mulitplied alpha values.
> > > With this we can have alpha values defined for each pixel
> > > and hence can have different blending values for each pixel.
> > 
> > What does pre-multiplied alpha mean? The TRM didn't really open it up...
> > Don't we already have per pixel alpha when using ARGB/RGBA?
> 
> When we set pixel format to ARGB/RGBA dss alpha blender would multiply the value present in 'A' with 'RGB'.
> By setting this bit display hardware assumes that the R,G,B are already multiplied with the alpha value and there is no need to multiply again.
> 
> Ex:-
> 			A	R	G	B
> argb data		128	255	128	100
> pre-multiplied	128	128	64	50
> 
> So this bit, when set, would not multiply the pixel with alpha value.

Ok, after staring long enough to the TRM's alpha-picture, I got it =).

But having this bit always on on 3630 would mean that the software
designed for 3430 would not work properly on 3630, wouldn't it?

> > This patch seems to always set the bit on, never set it off. Is that the
> > purpose?
> 
> As per TRM, this bit is valid only for ARGB formats and experts suggested that we can safely assume pre-multiplied data always in real world

I asked a few experts here, and they weren't so sure, and neither am I.

I don't see any problems making this feature configurable, but there may
be problems if it's hardcoded. So, it should be configurable. I think
the default should be the same as on 3430, so that they will work
similarly.

 Tomi


