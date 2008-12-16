From: David Brownell <david-b@pacbell.net>
Subject: Re: Issue: TWL4030-USB
Date: Tue, 16 Dec 2008 12:36:17 -0800
Message-ID: <200812161236.17658.david-b@pacbell.net>
References: <A24693684029E5489D1D202277BE894415E6E3C1@dlee02.ent.ti.com> <200812111524.57050.david-b@pacbell.net> <FCCFB4CDC6E5564B9182F639FC356087025127BDF7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:25351 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751619AbYLPUgV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Dec 2008 15:36:21 -0500
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087025127BDF7@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tuesday 16 December 2008, Pandita, Vikram wrote:
> 
> I have not been following much of the TWL4030 USB development.
> I came across this code:
> 
> <snip-start>
> static int twl4030_set_peripheral(struct otg_transceiver *x,
>                 struct usb_gadget *gadget)
> {
> ...
> if (!gadget) {
> >>>>>       omap_writew(0, OTG_IRQ_EN);
> ...
> <snip-end>
> 
> This code will not work for OMAP3. There is no OHCI OTG block on OMAP3.

Exactly why that code is removed in the latest code ... I don't
see it in drivers/usb/otg/twl4030-usb.c do you?

- Dave



> 
> 
> Regards,
> Vikram 
> 
> 


