From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP3EVM: TWL4030 Keypad irq error fix
Date: Tue, 23 Sep 2008 12:45:42 -0700
Message-ID: <200809231245.42614.david-b@pacbell.net>
References: <c656a4d20809192351x39f71fach7145236a9e8e0552@mail.gmail.com> <20080923110001.GL5102@atomide.com> <102CAAD1-D554-4CAD-B26F-DBFB2C418E9A@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:26379 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751545AbYIWTpu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Sep 2008 15:45:50 -0400
In-Reply-To: <102CAAD1-D554-4CAD-B26F-DBFB2C418E9A@student.utwente.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Tuesday 23 September 2008, Koen Kooi wrote:
> >>
> >> The clean fix requires twl4030 to be a "new style" driver.
> >> Fix not yet available. :(
> >
> > Pushing until we have a better fix.
> 
> But twl4030 now is a "new style" driver, so we have a start :)

But who's working on it?  :)

Sketch of solution:

 - twl4030.h defines keypad platform_data

 - add_children() adds a platform device for keypad,
   and passes that platform_data

 - twl4030 keypad driver switches to platform_bus
   and uses that platform_data

 - board-specific init code provides the relevant
   platform_data (or none)

I'll do the GPIO code, which will be a slightly more
interesting example than the RTC.

