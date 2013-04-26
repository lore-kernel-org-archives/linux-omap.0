From: Luciano Coelho <coelho@ti.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: Legacy support for wl12xx when booted
 with devicetree
Date: Fri, 26 Apr 2013 14:16:26 +0300
Message-ID: <1366974986.4029.32.camel@cumari.coelho.fi>
References: <20130426034858.26065.65118.stgit@muffinssi.local>
	 <20130426035210.26065.39995.stgit@muffinssi.local>
	 <0104F687-1726-476D-B2DF-7E72223B127A@dominion.thruhere.net>
	 <1366974032.4029.31.camel@cumari.coelho.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33439 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097Ab3DZLRy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Apr 2013 07:17:54 -0400
In-Reply-To: <1366974032.4029.31.camel@cumari.coelho.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>, Pantelis Antoniou <pantelis.antoniou@gmail.com>, Jason Kridner <jkridner@beagleboard.org>

On Fri, 2013-04-26 at 14:00 +0300, Luciano Coelho wrote:
> Hi Koen,
> 
> On Fri, 2013-04-26 at 11:33 +0200, Koen Kooi wrote:
> > Op 26 apr. 2013, om 05:52 heeft Tony Lindgren <tony@atomide.com> het volgende geschreven:
> > 
> > > Without WLAN we cannot switch omap4 to use device tree
> > > only booting. This patch can be reverted when the
> > > binding for wl12xx is added.
> > 
> > How much boards am I allowed to add to this? I need to get the wl12xx wifi expansionboards for beagleboard, beagleboard xM and beaglebone working with DT :)
> 
> Do you know where I can get a wl12xx wifi expansion board for
> beaglebone?

Uhmmm, never mind.  I somehow thought this was with the WiLink 8 chip,
but you said wl12xx, so it's not. ;)

-- 
Luca.

