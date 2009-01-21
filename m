From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/1] TWL: USB: disable VUSB regulators
Date: Wed, 21 Jan 2009 13:47:05 -0800
Message-ID: <200901211347.05694.david-b@pacbell.net>
References: <1232543718-18199-1-git-send-email-kalle.jokiniemi@digia.com> <200901211238.33229.david-b@pacbell.net> <13B9B4C6EF24D648824FF11BE896716203751D487F@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp104.sbc.mail.gq1.yahoo.com ([67.195.15.63]:40595 "HELO
	smtp104.sbc.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1749667AbZAUVxr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Jan 2009 16:53:47 -0500
In-Reply-To: <13B9B4C6EF24D648824FF11BE896716203751D487F@dlee02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Kalle Jokiniemi <kalle.jokiniemi@digia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

On Wednesday 21 January 2009, Woodruff, Richard wrote:
> A simple but impacting point is a LDO when left on, wastes a lot of system power.

So I guess I'll poke a bit harder at finding ways to
make sure the LDOs on the twl4030 get turned off..
this patch looks like a good start (since the VUSB
regulators are completely set up).

VAUX3 seems to be inappropriately enabled on a lot
of OMAP3 boards; short of fixing u-boot, that'd be
another bit of low-hanging fruit.


> Didn't know Dave was such a poet :)

Well, I dunno about the rhyme or scansion, but I
do sort of like the "feral code" imagery.  It seems
to highlight some key behaviors better than many
more familiar terms!

- Dave
