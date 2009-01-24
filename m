From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] ARM: OMAP: board-omap3beagle: set i2c-3 to 100kHz
Date: Sat, 24 Jan 2009 12:30:34 -0800
Message-ID: <200901241230.34735.david-b@pacbell.net>
References: <1232047837-23052-1-git-send-email-koen@openembedded.net> <196A1830-3227-48D0-B3BE-C7D935601BF5@beagleboard.org> <A73F0912-41CB-43F7-BE84-A4B91183B66B@beagleboard.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:28360 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752491AbZAXUai (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 24 Jan 2009 15:30:38 -0500
In-Reply-To: <A73F0912-41CB-43F7-BE84-A4B91183B66B@beagleboard.org>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jason Kridner <jkridner@beagleboard.org>
Cc: Koen Kooi <koen@beagleboard.org>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Beagle Board <beagleboard@googlegroups.com>

On Saturday 24 January 2009, Jason Kridner wrote:
> 
> Given that this port is only used on the DVI port for the BeagleBoard,  
> I believe it is appropriate to set it to 100kHz as Koen has done.

That's what I meant to say (kHz not MHZ!) ... except, also add a
comment saying why the (un-obvious) restriction is being made.

Though I did note that since it's a nice level-shifted I2C, some
folk may want to use it for non-DDC purposes [1], where a 100 KHz
limit might not always be wanted.

- Dave

[1] http://www.paintyourdragon.com/uc/i2c/index.html

