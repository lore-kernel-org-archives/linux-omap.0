From: Darren Etheridge <detheridge@ti.com>
Subject: Re: [PATCH] arm/dts: am335x-evmsk enable display and lcd panel
 support
Date: Fri, 9 May 2014 09:47:49 -0500
Message-ID: <20140509144748.GI2626@ti.com>
References: <1398199063-3026-1-git-send-email-detheridge@ti.com>
 <20140506161001.GH18474@atomide.com>
 <536CBBFE.40508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60362 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744AbaEIOsc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 10:48:32 -0400
Content-Disposition: inline
In-Reply-To: <536CBBFE.40508@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

Tomi Valkeinen <tomi.valkeinen@ti.com> wrote on Fri [2014-May-09 14:29:02 +0300]:
> On 06/05/14 19:10, Tony Lindgren wrote:
> > * Darren Etheridge <detheridge@ti.com> [140422 13:39]:
> >> Add the necessary nodes to enable the LCD controller and the
> >> LCD panel that is attached to the Texas Instruments AM335x
> >> EVMSK platform.  Also setup the necessary pin mux within the
> >> DT file to drive the LCD connector and add the correct
> >> pinmux settings for the lcd pins to be configured to when
> >> the SoC goes into sleep state for the minimum power
> >> consumption.
> >>
> >> For the sleep mode LCD pin settings, MUX_MODE7 is chosen as
> >> this corresponds to switching the pins into input GPIO's with
> >> an internal pulldown.  Which has been determined to offer the
> >> lowest power solution vs leaving the pins configured in LCD
> >> mode.
> > 
> > Probably best that Tomi queues all the panel .dts changes into
> > a separate immutable branch that I can merge too.
> 
> This is not for OMAP DSS, but for the LCDC used in beaglebone, so there
> are no dependencies to any of my work.
> 

Benoit had always queued these LCDC dts patches in the past.  This is
exactly the same as what had been done for AM335x-EVM and
AM335x-BeagleBone both of which are already in the mainline kernel.  I
had just missed the EVMSK previously.

Darren


