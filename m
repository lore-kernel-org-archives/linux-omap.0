From: David Brownell <david-b@pacbell.net>
Subject: Re: Issue: TWL4030-USB
Date: Tue, 16 Dec 2008 13:24:11 -0800
Message-ID: <200812161324.11277.david-b@pacbell.net>
References: <A24693684029E5489D1D202277BE894415E6E3C1@dlee02.ent.ti.com> <200812161236.17658.david-b@pacbell.net> <FCCFB4CDC6E5564B9182F639FC356087025127BDFE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:28286 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751609AbYLPVYN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Dec 2008 16:24:13 -0500
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087025127BDFE@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tuesday 16 December 2008, Pandita, Vikram wrote:
> >Exactly why that code is removed in the latest code ... I
> >don't see it in drivers/usb/otg/twl4030-usb.c do you?
> 
> I looked into: drivers/i2c/chips/twl4030-usb.c
> Is this supposed to be removed then? 

It's been moved, since new i2c/chips code can't be
merged to mainline.

- dave
