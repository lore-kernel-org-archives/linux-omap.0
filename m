From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] ARM: OMAP: I2C: prepare to use hwmod reset in
 driver
Date: Fri, 16 Dec 2011 13:59:41 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112161357250.12660@utopia.booyaka.com>
References: <alpine.DEB.2.00.1112160254320.12660@utopia.booyaka.com> <20111216195002.GL32251@atomide.com> <alpine.DEB.2.00.1112161314180.12660@utopia.booyaka.com> <20111216204123.GM32251@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38875 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760017Ab1LPU7m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 15:59:42 -0500
In-Reply-To: <20111216204123.GM32251@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Shubhrajyoti <shubhrajyoti@ti.com>, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

Hi

On Fri, 16 Dec 2011, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [111216 11:45]:
> > On Fri, 16 Dec 2011, Tony Lindgren wrote:
> > 
> > > * Paul Walmsley <paul@pwsan.com> [111216 01:24]:
> > >
> > > > Shubhrajyoti D (2):
> > > >       ARM: OMAP: omap_device: add omap_device_reset to reset all the hwmods in the device
> > > >       ARM: OMAP: I2C: Reset support
> > > > 
> > > Can you please update shi to leave out the extra callback
> > > function int (*device_reset) (struct device *dev) as I'd
> > > rather see that happen with pm_runtime calls?
> > 
> > What PM runtime call is used to reset a device?
> 
> Hmm how about pm_runtime_disable? Or do we need a new
> call for reset?

Looking at the last few hunks of:

http://marc.info/?l=linux-omap&m=132377389204328&w=2

it appears to me that the driver needs to reset the device while it's 
still active & powered on, etc.

Shubhrajyoti, care to comment further?


- Paul
