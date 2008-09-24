From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] OMAP3EVM: TWL4030 Keypad irq error fix
Date: Wed, 24 Sep 2008 13:44:31 +0300
Message-ID: <20080924104431.GL24627@gandalf.research.nokia.com>
References: <c656a4d20809192351x39f71fach7145236a9e8e0552@mail.gmail.com> <20080923110001.GL5102@atomide.com> <102CAAD1-D554-4CAD-B26F-DBFB2C418E9A@student.utwente.nl> <200809231245.42614.david-b@pacbell.net>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:55841 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbYIXKpT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 06:45:19 -0400
Content-Disposition: inline
In-Reply-To: <200809231245.42614.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Tue, Sep 23, 2008 at 12:45:42PM -0700, David Brownell wrote:
> On Tuesday 23 September 2008, Koen Kooi wrote:
> > >>
> > >> The clean fix requires twl4030 to be a "new style" driver.
> > >> Fix not yet available. :(
> > >
> > > Pushing until we have a better fix.
> > 
> > But twl4030 now is a "new style" driver, so we have a start :)
> 
> But who's working on it?  :)
> 
> Sketch of solution:
> 
>  - twl4030.h defines keypad platform_data
> 
>  - add_children() adds a platform device for keypad,
>    and passes that platform_data
> 
>  - twl4030 keypad driver switches to platform_bus
>    and uses that platform_data
> 
>  - board-specific init code provides the relevant
>    platform_data (or none)
> 
> I'll do the GPIO code, which will be a slightly more
> interesting example than the RTC.

I can do the keypad since I'm already working on the usb as well. Dave,
I'm gonna add twl_has_rtc(), twl_had_keypad() and twl_has_usb() to clean
a bit add_children. With those, we're gonna be able to:

if (twl_has_keypad() && pdata->keypad) {
	...
}

-- 
balbi
