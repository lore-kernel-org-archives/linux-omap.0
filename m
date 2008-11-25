From: David Brownell <david-b@pacbell.net>
Subject: Re: PWM drivers for TWL4030
Date: Tue, 25 Nov 2008 13:26:35 -0800
Message-ID: <200811251326.36259.david-b@pacbell.net>
References: <6ed0b2680811250857p59195e4dh7dab4e1109769b0c@mail.gmail.com> <200811251206.54848.david-b@pacbell.net> <612C6524-68F3-43C0-A127-4531F6B9B58F@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:41773 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752023AbYKYV0i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Nov 2008 16:26:38 -0500
In-Reply-To: <612C6524-68F3-43C0-A127-4531F6B9B58F@student.utwente.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: Grazvydas Ignotas <notasas@gmail.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Tuesday 25 November 2008, Koen Kooi wrote:
> 
> Op 25 nov 2008, om 21:06 heeft David Brownell het volgende geschreven:
> 
> > On Tuesday 25 November 2008, Koen Kooi wrote:
> >>>
> >>> How about a standard LED driver (optionally with a brightness
> >>> control) and the newish "backlight" trigger?
> >>
> >> Does the backlight trigger hook into the backlight class?
> >
> > It doesn't seem to call backlight_device_register(), though
> > I don't know why not.  It just looks like it hooks into the
> > same notification events the backlight class does.

Re "why not" ... partial answer:  because it doesn't have
a way to associate itself with the panel whose backlight
it's supplying.  Seems like that should be solvable.


> > If you think that's trouble, it would probably be a good
> > thing to bring that up with the author of that new trigger
> > code (drivers/leds/ledtrig-backlight.c) ... it's very new,
> > and I'd expect such userspace interface goofs still ought
> > to be fixable.
> 
> Our mails on this subject crossed eachother :)
> 
> Short recap: the backlight trigger is usefull for turnign on/off e.g.  
> status leds at the same the the backlight goes on/off, but shouldn't  
> be (ab)used for backlight control.

That's not what its Kconfig description says.  So I think
that if you care about this, you should raise the issue
with someone more involved.


> Mark Brown in that thread [1] does raise an interesting use-case,

i.e [2] ... a simpler situation than we have with TWL4030,
where we have LED signals supporting

 - real LEDs

    * simple leds that don't really need PWM brightness
      controls:  Beagle LEDB == pmu_stat

    * backlights which probably *do* want PWM controls:  on
      those two EVMs, LEDA == backlight, using more of its
      peak 160 mA current draw

  - general GPIO usage, where PWM capability "must not"
    kick in:  Beagle LEDA == nEN_USB_PWR

His comment focussed on the two "real LEDs" cases.


> since we are in the same boat. A solution is needed, but I guess the  
> wolfson people can work it out :)

Or maybe the Pandora people.  ;)

If they're using the LEDA or LEDB PWMs, providing and exporting
a brightness control would be easy.  If they're using the other
two PWMs, it'd be more work.

- Dave


> [1] http://linux.derkeiler.com/Mailing-Lists/Kernel/2008-10/threads.html#02359
> 

[2] http://linux.derkeiler.com/Mailing-Lists/Kernel/2008-10/msg02610.html
