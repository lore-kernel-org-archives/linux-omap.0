From: David Brownell <david-b@pacbell.net>
Subject: Re: USB serial devices not working on linux-omap musb.
Date: Mon, 6 Oct 2008 18:20:09 -0700
Message-ID: <200810061820.09437.david-b@pacbell.net>
References: <e5e6ade50809302135q172a83b7pb87e9309499b5821@mail.gmail.com> <e5e6ade50810011158h12091ca1ocea1243d9437d692@mail.gmail.com> <19F8576C6E063C45BE387C64729E739403DC1D5565@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:22002 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754380AbYJGBUM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 21:20:12 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E739403DC1D5565@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: Nathan Monson <nmonson@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wednesday 01 October 2008, Gupta, Ajay Kumar wrote:
> Currently all the BULK request are multiplexed on one hardware endpoint
> and when a wifi or eth device is in use they never release BULK hardware
> endpoint so that it can be used by other devices. This causes failure of
> serial device when any of wifi/eth is in use.

Any driver that keeps a bulk request posted at all times, usually
an IN transfer as with most stuff in drivers/net, has this issue.


> I am working on to use different hardware endpoint for different BULK
> devices and would submit a patch once it is done.

Be careful of that strategy.  It'll die quickly on a number of the
non-OMAP platforms, which don't populte as many endpoints.

The strategy I had thought about was to allow use of more endpoints
if they were available, as a way to improve performance if enough
resources were available ... but primarily, act more like "normal"
hardware, and use a mechanism that's currently disabled.

That mechanism being NAK limits.  See the REVISIT comment in
the musb_urb_enqueue() function, where it sets interval to zero
for bulk and control transfers.

The way it would work:  if the NAK limit gets hit, the transfer
will stop "early".  Finish cleaning it up (DMA might be an issue),
rotate that bulk transfer to the end of that bulk queue, stuff the
next transfer where that one was, repeat.

Using that mechanism on one bulk endpoint would mean it wouldn't be
possible for transfers on it to starve everything else going the
same direction.

Using that on a periodic endpoint would mean not tying down one
endpoint doing, say, an every-256-msec hub poll for one hub,
while there's no endpoint free for an every-8-msec mouse or
keyboard poll ...

In short:  I strongly encourage you to find a way to use the
NAK limit scheme to let incomplete host side transfers stop
themselves and free up their resources for re-use, without
giving up the ability to continue those transfers later.

- Dave


