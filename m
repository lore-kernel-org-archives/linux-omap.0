From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: usb_nop_xceiv_register() missing when OTG built as modules
Date: Wed, 26 May 2010 11:50:48 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E616B33@dbde02.ent.ti.com>
References: <87635d54nn.fsf@deeprootsystems.com>
 <19F8576C6E063C45BE387C64729E7394044DB7B6BD@dbde02.ent.ti.com>
 <87eik03scn.fsf@deeprootsystems.com> <20100305090426.GG12757@nokia.com>
 <871vfy3azr.fsf@deeprootsystems.com>
 <558f5bffd42210a777154737d6730232@secure211.sgcpanel.com>
 <87y6i6zatj.fsf@deeprootsystems.com> <20100522235310.GA15859@matterhorn.lan>
 <19F8576C6E063C45BE387C64729E7394044E61643A@dbde02.ent.ti.com>
 <20100526060321.GE3069@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60443 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752218Ab0EZGVK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 May 2010 02:21:10 -0400
In-Reply-To: <20100526060321.GE3069@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: Amit Kucheria <amit.kucheria@verdurent.com>, Kevin Hilman <khilman@deeprootsystems.com>, "me@felipebalbi.com" <me@felipebalbi.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

Hi,
> On Mon, May 24, 2010 at 09:07:37AM +0200, ext Gupta, Ajay Kumar wrote:
> >> Attempting to remove usb_nop_xceiv_register() completely will require
> >> someone
> >> with more knowledge of davinci and blackfin archs to comment on what
> >> boards
> >> need the platform_device defined.
> >
> >NAK..
> >This is an incorrect fix as it duplicates the code snippet which
> >is already present in nop file.

> I don't believe you understood the purpose of the original patch:
I did and that's why an alternative patch.

> The idea is that currently, it's impossible to build a board which uses
> nop transceiver and have that be a module because when you'll have an
> undefined function being used on a board file.
I know.

> 
> Removing the call to nop_xceiv_register() and using a
> platform_device_register() is the way to go, since it's only 4 ~ 5 lines
> of code anyway.
4 ~5 lines would keep on repeating for all current and future boards
requiring to use NOP.

> 
> ps: you really think that adding more and more ifdefs is better than
> Amit's patch ??
Yes, when compared to the approach of repeating those 4 ~5 line in all
the board files requiring NOP.

-Ajay
> 
> --
> balbi
