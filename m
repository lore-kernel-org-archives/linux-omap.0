From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/2] Add recommended bpp for omap dss2 generic dpi
 panels
Date: Wed, 16 Feb 2011 17:58:06 +0200
Message-ID: <1297871886.14556.21.camel@deskari>
References: <1297530130-10355-1-git-send-email-daniel.morsing@gmail.com>
	 <1297861914.988.1.camel@deskari>  <1297865193.8777.8.camel@morsing>
	 <1297866996.988.69.camel@deskari>  <1297870958.8777.21.camel@morsing>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35940 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751795Ab1BPP6L (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 10:58:11 -0500
In-Reply-To: <1297870958.8777.21.camel@morsing>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Morsing <daniel.morsing@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Bryan Wu <bryan.wu@canonical.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2011-02-16 at 09:42 -0600, Daniel Morsing wrote:
> On Wed, 2011-02-16 at 16:36 +0200, Tomi Valkeinen wrote:

> > And I found:
> > 
> > http://www.timll.com/chinese/download/files/CHILIN_TECHNOLOGY.pdf
> > 
> > It looks like 24bpp display.
> > 
> 
> Ok I looked through the datasheet and it looks to me that i got
> the .config field right. Only thing that's vague from that sheet is
> which pixel clock edge the v-sync and h-sync are driven low and the
> color distortion is still there with either option.
> 
> > What kind of color distortion do you see? Perhaps the problem is
> > somewhere else, like wrong horizontal sync, vertical sync or pixel clock
> > signal setting in .config field. This info should be in the panel
> > datasheet, but it usually takes some deciphering to understand it =).
> > 
> >  Tomi
> > 
> 
> I'm seeing a light cyan tint to everything when running at 24bpp. Using
> 16 datalines causes a heavy blue tint.

But with 24 datalines and 16 bpp it works? Sounds strange =). 

One thing to check are the pinmuxings (or pad configuration, as it's
called in omap3 trm).

Are you using 2.6.37 or newer kernel?

Is this also happening with other devkit8000 devices, so it's not just a
broken device?

Have you tried with an image with full red, green and blue areas, to see
if only certain colors are affected? 

And the last option is of course get a scope and see what's going on in
the datalines.

 Tomi


