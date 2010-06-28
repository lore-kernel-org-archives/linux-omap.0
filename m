From: "Anders, David" <x0132446@ti.com>
Subject: RE: [PATCH] Add OMAP4 Panda Support
Date: Mon, 28 Jun 2010 12:47:13 -0500
Message-ID: <7B4574D56E4ADF438756313E9A172A879A96D2F6@dlee01.ent.ti.com>
References: <1277407989-30914-1-git-send-email-x0132446@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB032194B79C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45348 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210Ab0F1RrQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Jun 2010 13:47:16 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB032194B79C@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>

> -----Original Message-----
> From: Gadiyar, Anand
> Sent: Thursday, June 24, 2010 8:29 PM
> To: Anders, David; linux-omap@vger.kernel.org
> Cc: tony@atomide.com
> Subject: RE: [PATCH] Add OMAP4 Panda Support
> 
> > +static void __init omap4_panda_init(void)
> > +{
> > +	int status;
> > +
> > +	omap4_panda_i2c_init();
> > +	omap_serial_init();
> > +	omap4_twl6030_hsmmc_init(mmc);
> > +	/* OMAP4 Panda uses internal transceiver so register nop transceiver
> */
> > +	usb_nop_xceiv_register();
> > +	/* FIXME: allow multi-omap to boot until musb is updated for omap4
> */
> > +	if (!cpu_is_omap44xx())
> > +		usb_musb_init(&musb_board_data);
> > +}
> 
> Dave,
> 
> I think this should be resolved by now - the OMAP4 MUSB support went
> through linux-usb for .35-rc1. So it should be safe to call
> usb_musb_init() unconditionally.
> 
> (Not actually tested by me yet. I'll try and do this tomorrow).
> 
> 
> - Anand

Anand,

I've done a few tests and still have a few errors with unconditional calls to musb_init. I'd like for core support to go ahead and move forward with the patch as is. I did a quick check and didn't see any patches submitted to change these lines in the 4430sdp, and for now, I would like to mirror as much as possible the functionality in the machine files for the panda and 4430sdp.

Tony,
If there are no objections, can we get someone to signoff on this so we can get it in the window?

Thanks
Dave

