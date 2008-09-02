From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/2] twl4030-usb patches
Date: Tue, 2 Sep 2008 13:15:39 -0700
Message-ID: <200809021315.39502.david-b@pacbell.net>
References: <1220358712-25737-1-git-send-email-felipe.balbi@nokia.com> <200809021237.56825.david-b@pacbell.net> <20080902194917.GF6814@frodo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:22347 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753072AbYIBUPm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 16:15:42 -0400
In-Reply-To: <20080902194917.GF6814@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

On Tuesday 02 September 2008, Felipe Balbi wrote:
> > > One thing we might say, Jean Delvare won't accept twl4030 the way it is
> > > now. Old style i2c drivers will be dropped soon. We have to get twl4030
> > > properly done otherwise it'll be a pain later.
> > 
> > He's also not keen on growing drivers/i2c/chips ...
> > So this driver should probably move to drivers/mfd too.
> 
> Sure... it should really be there since it really is a multifunction
> device. In that case it would be merged through Samuel Ortiz, right ?
> Most likely Cc:ing i2c@lm-sensors.org so i2c people could comment on the
> code as well.

Yes.  Though considering it's an irq_chip that dispatches
through I2C ... maybe an LKML review too, for the core.

 
> > (When it starts moving upstream, I suspect some folk will
> > ask why it doesn't support the drivers/regulator calls;
> > that's still new, I'd not worry much.)
> 
> Well, but if we have proper APIs for doing stuff, we should really start
> using them, don't you think ?

That's why I mentioned that.  My priority would be getting
the existing core code fixed/merged.  Then other bits as
needed to get widely-available boards (Beagle, soon Overo)
working in mainline.  (Then the rest.)

Being the first "external" user of a new API framework is
something to take slowly... IMO it's not worth holding up
twl4030 support to do that.

 
> I'll postpone my twl4030-usb patch and try to work on twl4030-core.c.
> It'll be a huge task moving all of that to new style i2c driver.

Well, it's got obvious increments that are simple.  Core first;
then the other bits, incrementally.  Maybe the core could be
pushed upstream without a lot of the other functions exposed.

Note that the LED support isn't written yet, so there'd be
nothing to convert.  :)

- Dave

