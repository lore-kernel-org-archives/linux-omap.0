From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: Re: omap_musb_board_data -- trouble specifying 500mA supply
Date: Tue, 4 May 2010 11:02:57 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E3514C2@dbde02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E7394044E3514BC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36504 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753223Ab0EDFdF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 May 2010 01:33:05 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044E3514BC@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Users <linux-omap@vger.kernel.org>
Cc: Cliff Brake <cliff.brake@gmail.com>

Hi,
> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >> owner@vger.kernel.org] On Behalf Of Cliff Brake
> >> Sent: Wednesday, April 28, 2010 7:40 PM
> >> To: Linux OMAP Users
> >> Subject: omap_musb_board_data -- trouble specifying 500mA supply
> >>
> >> Hello,
> >>
> >> We are designing a custom OMAP board that will have a 500mA supply on
> >> the OTG port.  It looks like the power is set with:
> >>
> >> struct omap_musb_board_data {
> >>       u8      interface_type;
> >>       u8      mode;
> >>       u8      power;
> >> };
> >>
> >> However, with a u8, the max value is 255.  Should power be changed to a
> >> u16?
> >
> > There is already a fix submitted and is available at Greg's queue,
> > http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-
> 2.6/patches/usb.current/musb-fix-power-field-to-hold-all-possible-
> values.patch
> 
> I'm also having trouble figuring out the correct way to convince the
> OTG system not to use the internal phy VBUS power supply.  Are there
> any examples of a board config that does this?  Perhaps the AM35xx,
> etc?
You can refer OMAP3EVM (REV-G) or AM35x.

Ajay
> 
> Thanks,
> Cliff
