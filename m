From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: omap3-beagle: Fix USB host on beagle boards
 (for 3.13)
Date: Tue, 26 Nov 2013 14:27:03 -0800
Message-ID: <20131126222703.GQ26766@atomide.com>
References: <1385387745-7162-1-git-send-email-rogerq@ti.com>
 <CAGo_u6ryFJvBwd=S9A-nJw+eoGguPj0jMOtgMiZ7mXXAbh4i+w@mail.gmail.com>
 <52946243.70903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:29666 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756818Ab3KZW1H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Nov 2013 17:27:07 -0500
Content-Disposition: inline
In-Reply-To: <52946243.70903@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Benoit Cousson <bcousson@baylibre.com>, dt list <devicetree@vger.kernel.org>, linux-usb@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, balbi@ti.com, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Roger Quadros <rogerq@ti.com> [131126 00:57]:
> On 11/25/2013 05:50 PM, Nishanth Menon wrote:
> > On Mon, Nov 25, 2013 at 7:55 AM, Roger Quadros <rogerq@ti.com> wrote:
> >> Beagle (rev. C4) and Beagle-XM (all revs) need VAUX2 1.8V supply
> >> for the USB PHY.
> >>
> >> As the generic PHY driver can't handle more than one supply
> >> at the moment, we configure this supply to be always on.
> >> This will cause a very small power impact if the USB host subsystem
> >> is not in use, about 76.86 micro-W + LDO power.
> > 
> >>
> >> Older Beagle boards (prior to C4) don't have VAUX2 connected anywhere,
> >> so there won't be any functional impact on those boards other than
> >> some additional LDO power consumption.
> >>
> >> Reported-by: Nishanth Menon <nm@ti.com>
> >> Signed-off-by: Roger Quadros <rogerq@ti.com>
> > 
> > Tested-by: Nishanth Menon <nm@ti.com>
> 
> Thanks Nishant.

Thanks, applying this into omap-for-v3.13/fixes-take4.

Tony
