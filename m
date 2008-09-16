From: David Brownell <david-b@pacbell.net>
Subject: Re: [rfc] [patch] clean up to ehci-omap (Was: Re: [patch] omap: usb: ehci: fix use of hcd->regs)
Date: Mon, 15 Sep 2008 22:49:33 -0700
Message-ID: <200809152249.34233.david-b@pacbell.net>
References: <20080912121024.GG759@gandalf.research.nokia.com> <FCCFB4CDC6E5564B9182F639FC356087022A25316B@dbde02.ent.ti.com> <20080914185721.GB6943@frodo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:47311 "HELO
	smtp111.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751428AbYIPF4R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Sep 2008 01:56:17 -0400
In-Reply-To: <20080914185721.GB6943@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, Tony Lindgren <tony@atomide.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

> +       dev_dbg(&dev->dev, "failed to initialized host controller\n");

... and include the status code, to help identify *WHY* it failed
(this is re #3 ... should have sent three separate emails, with
inlined patches)
