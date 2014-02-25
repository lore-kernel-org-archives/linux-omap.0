From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/2] ARM: dts: duovero-parlor: Add HDMI output
Date: Tue, 25 Feb 2014 12:39:21 +0000
Message-ID: <20140225123921.GY27282@n2100.arm.linux.org.uk>
References: <1393261669-32039-1-git-send-email-florian.vaussard@epfl.ch> <1393261669-32039-3-git-send-email-florian.vaussard@epfl.ch> <20140224180336.GU27282@n2100.arm.linux.org.uk> <CABxcv=kKxidVJWcMrueB+edW=g_6gcucvi6=7p=EZ_WooCpbMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:50146 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752639AbaBYMjf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Feb 2014 07:39:35 -0500
Content-Disposition: inline
In-Reply-To: <CABxcv=kKxidVJWcMrueB+edW=g_6gcucvi6=7p=EZ_WooCpbMA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Florian Vaussard <florian.vaussard@epfl.ch>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ash Charles <ash@gumstix.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Feb 24, 2014 at 05:22:27PM -0300, Javier Martinez Canillas wrote:
> Hi Russell,
> 
> On Mon, Feb 24, 2014 at 3:03 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Feb 24, 2014 at 06:07:49PM +0100, Florian Vaussard wrote:
> >> +     hdmi0: connector@0 {
> >> +             compatible = "hdmi-connector";
> >
> > This looks way to generic a compatible string.  Are you sure it's
> > correct?
> >
> 
> That compatible string is correct according to the latest series
> posted by Tomi Valkeinen to add DT bindings for the OMAP Display
> SubSystem (DSS) [0].

in which case:

N    N   AA     CCCC  K  K
NN   N  A  A   C    C K K
N N  N A    A C       KK
N  N N AAAAAA C       KK
N   NN A    A  C    C K K
N    N A    A   CCCC  K  K

Yes, that's a very big nack.  Two things:

1. OMAP really doesn't have the right to define a compatible string which
   is as generic as "hdmi-connector".

2. Even with "omapdss," before it, the convention that DT people have adopted
   is for the prefix to be "companyname," and not a subsystem.

I'm not the only one with this concern - I discussed it with Arnd last
night and his comments were about it being "obviously bogus".

> The property is added on this patch [1] and as far as I understood the
> idea is that it could be a generic DT binding that can be used by
> platform specific HDMI connectors like the omap dss HDMI connector [2].

Why do the physical connectors need a DT binding?  Surely what needs the
DT binding is the HDMI encoder - and that certainly should no way be a
generic name, because there's no such thing as a generic HDMI encoder
chip.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
