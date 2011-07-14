From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 2/5] regulator: omap smps regulator driver
Date: Thu, 14 Jul 2011 10:51:46 +0300
Message-ID: <1310629906.4331.116.camel@sokoban>
References: <1310565638-13140-1-git-send-email-t-kristo@ti.com> <1310565638-13140-3-git-send-email-t-kristo@ti.com> <20110713144019.GA7861@opensource.wolfsonmicro.com> <1310572425.4331.96.camel@sokoban> <20110713225524.GA9770@opensource.wolfsonmicro.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39509 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753715Ab1GNHvw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jul 2011 03:51:52 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <20110713225524.GA9770@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-omap@vger.kernel.org, "Girdwood, Liam" <lrg@ti.com>, "Hilman, Kevin" <khilman@ti.com>, toddpoynor@google.com

On Thu, 2011-07-14 at 00:55 +0200, Mark Brown wrote:
> On Wed, Jul 13, 2011 at 06:53:45PM +0300, Tero Kristo wrote:
> > On Wed, 2011-07-13 at 16:40 +0200, Mark Brown wrote:
> 
> > > I do strongly prefer the idiom of just registering all the regulators
> > > even if they're read only.
> 
> > Number of available SMPS regulators is kind of board specific issue.
> > OMAP3 has 2 available, OMAP4 has 3. If we are using some custom powering
> > solution, we might have even different amounts for these.
> 
> Right, but the interface to them is always there?

The library used in this driver will attempt to lookup for the
voltagedomains, and this will fail for 'iva' on omap3, as it does not
exist. I could change the driver to always try to look for all of the
possible known domains, and just register the ones it finds, and apply
user settings for the ones that board file provides. This contradicts
now a bit on the comment I just said to Todd, but you believe this to be
a better way?

> 
> > > No, this is bad.  We *always* pay attention to the constraints the user
> > > set even if they're nuts or won't work, the machine driver has the final
> > > say on what is or isn't allowed on a given board.  The mode setting is
> > > especially suspect as there's no mode support in the driver.
> 
> > Just a clarification on this one that I have understood your comment
> > right... Do you mean that I should be checking the constraints user sets
> > more thoroughly to see if there is something bogus? I was looking at
> > some of the other regulator drivers and they seem to be fiddling with
> > the constraints in similar manner.
> 
> No!  You should *always* use the constraints the user has set, don't
> randomly add new permissions without them doing so.

Ah ok, so no fiddling with the constraints at all, core should take care
of proper functioning regarding this part.

-Tero


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

