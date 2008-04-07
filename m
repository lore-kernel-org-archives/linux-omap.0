From: David Brownell <david-b@pacbell.net>
Subject: Re: [Help 1/2] MUSB: ZiO! CF card reader will trigger a change from MUSB host mode to MUSB peripheral mode
Date: Mon, 7 Apr 2008 09:05:09 -0700
Message-ID: <200804070905.10048.david-b@pacbell.net>
References: <386072610804070408q16c5ffa1u6a0c2e35295aa327@mail.gmail.com> <af73f7a75d15439b4761e7b0baa612cf@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:35250 "HELO
	smtp111.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754086AbYDGQFv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Apr 2008 12:05:51 -0400
In-Reply-To: <af73f7a75d15439b4761e7b0baa612cf@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>, Bryan Wu <cooloney@kernel.org>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

On Monday 07 April 2008, Felipe Balbi wrote:
> I recall having some issues on 100mA devices. During enumeration some
> current spikes a few mAs above 100mA were occuring and we couldn't
> enumerate the device due to vbus_err interrupt.

Yeah, I think the Mentor core is unduly sensitive to voltage
fluctuation during enumeration.  There's supposed to be about
100 msec before VBUS must stabilize ... but the silicon doesn't
seem to accept routine instabilities in that period, and then
reports inappropriate VBUS errors.


> If you check drivers/usb/musb/tusb6010.c you'll see that we've 
> implemented a retry condition for those cases. The same retry can
> be found in musb_core.c

The DaVinci support needed the same kind of logic.  All in
all this is painful stuff to sort out, and it seems that
each platform rediscovers it.  It would be better if the
silicon itself weren't fighting back so hard...

- Dave


