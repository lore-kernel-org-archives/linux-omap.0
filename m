From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ASoC: OMAP: HDMI: Prevent DSS module from going idle
 when playing audio
Date: Fri, 16 Dec 2011 02:13:08 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112160211400.12660@utopia.booyaka.com>
References: <1324019032-31532-1-git-send-email-ricardo.neri@ti.com>  <alpine.DEB.2.00.1112160107380.12660@utopia.booyaka.com>  <1324023504.1859.11.camel@deskari>  <alpine.DEB.2.00.1112160121250.12660@utopia.booyaka.com> <1324025267.1859.29.camel@deskari>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54431 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051Ab1LPJNJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 04:13:09 -0500
In-Reply-To: <1324025267.1859.29.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Ricardo Neri <ricardo.neri@ti.com>, b-cousson@ti.com, linux-omap@vger.kernel.org, mythripk@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com

On Fri, 16 Dec 2011, Tomi Valkeinen wrote:

> On Fri, 2011-12-16 at 01:27 -0700, Paul Walmsley wrote:
> > On Fri, 16 Dec 2011, Tomi Valkeinen wrote:
> > 
> > > But with DT we can't use func pointers in platform_data either, right?
> > 
> > In the future, if someone wants to run a platform_data-less kernel, 
> > they'll have to come up with a replacement mechanism for these.  Several 
> > replacements have been proposed internally, such as having an 
> > omap_bus/omap_device for devices with OMAP-specific integration, but right 
> > now there are more pressing crises to deal with...
> 
> Ok. Benoit was telling me not to use pdata, so I thought it's a hard
> rule for DT. He didn't give me a clear alternative, though =).

As far as I know, we've got no other choice.  And if we don't add these, 
then not only will current code be broken, but when the time comes to 
convert away from using platform_data function pointers, then no one will 
know what functions should be exposed from the integration code for the 
driver to call.


- Paul
