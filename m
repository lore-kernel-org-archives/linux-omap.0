From: David Brownell <david-b@pacbell.net>
Subject: Re: Git tree updated to v2.6.28-rc2, old sound and v4l drivers removed
Date: Mon, 27 Oct 2008 19:08:27 -0700
Message-ID: <200810271908.28099.david-b@pacbell.net>
References: <20081027204323.GA7539@atomide.com> <20081028012538.GA32518@frodo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:20482 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752199AbYJ1CIa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Oct 2008 22:08:30 -0400
In-Reply-To: <20081028012538.GA32518@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Monday 27 October 2008, Felipe Balbi wrote:
> we should get anything out of drivers/i2c/chips since Jean wanna get rid
> of that directory. So if you apply the patches I wrote to lp5521 I'm
> fixing a few stuff and moving that driver to drivers/leds. After that I
> could send that driver to Richard.

I have a hard time seeing that directory vanish *too* quickly,
but it's true that the linux-omap drivers now living only there
should be moved ...

There's gpio_expander_omap.c there, which seems to be used
exclusively by H3 and H4 board support.  Luckily I have some
patches to remove that from H4 sitting around somewhere (and
not *completely* dust-encrusted) so that's partly done already.


We have a good start on moving the twl4030 stuff out, but
there's work yet to be done on that.  The USB transceiver
stuff is probably the most significant bit.  I could see
that, and some other bits, living in a drivers/usb/otg
directory.

- Dave
