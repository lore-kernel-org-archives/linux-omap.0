From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 3/4] ARM: OMAP3: Add support for 3430 SDP, v3
Date: Tue, 31 Mar 2009 19:07:59 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FB085DF0@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02FB085D68@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38824 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751500AbZCaNig convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Mar 2009 09:38:36 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02FB085D68@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> > * Tony Lindgren <tony@atomide.com> [090316 11:14]:
> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [090315 08:48]:
> > > > On Sun, Mar 15, 2009 at 03:47:01PM +0000, Russell King - ARM Linux wrote:
> > > > > On Fri, Mar 13, 2009 at 03:47:26PM -0700, Tony Lindgren wrote:
> > > > > > +#include <mach/mcspi.h>
> > > > > > +#include <mach/gpio.h>
> > > > > 
> > > > > Shouldn't this be linux/gpio.h ?
> > > > 
> > > > Note that Syed Mohammed Khasim <x0khasim@ti.com> address is not valid.
> > > 
> > > Thanks, updated patch below.
> > 
> > Oops, forgot to run stg refresh before sending out this, v3 below
> > 
> > Tony
> > 
> 
> Tony, Russell,
> 
> Sorry for not catching this before it got merged.
> 
> I could not run the 3430 SDP defconfig from mainline. The image hangs at
> "Starting kernel ...". Enabling CONFIG_DEBUG_LL does not help.
>  
> The omap_3430sdp_defconfig seems to have too many differences from the
> defconfigs for other OMAP3 boards. In fact, it's not even similar to the
> file present in the linux-omap tree.
> 
> So I took the SDP defconfig from the l-o tree and replaced the one on
> mainline with it. And we have a compile break in a display file. Removing
> CONFIG_FB_OMAP works around the compile break.
> 
> Please consider merging this patch (l-o SDP defconfig minus CONFIG_FB_OMAP)
> so that we can finally use an SDP with mainline.
> 


Oops. Now, this doesn't work for me either. Sorry for the noise.

Confused,
Anand
