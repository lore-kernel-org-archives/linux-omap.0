From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 09/15] OMAP: DSS2: HDMI: implement detect()
Date: Wed, 14 Sep 2011 17:11:49 +0300
Message-ID: <1316009509.2118.6.camel@deskari>
References: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
	 <1315818818-18733-10-git-send-email-tomi.valkeinen@ti.com>
	 <CAP5A+B9_Jsg23oR49q2bkBGVLDWHBiBZj_=_G1SRf7ftrMt_iw@mail.gmail.com>
	 <CAF6AEGuhjZgH9zFuigjfvHGM9r7jSLY2TTCD0LjZbT+Ubrb12A@mail.gmail.com>
	 <CAP5A+B87w6Hir-0+SNnckQaDcO=ixgq-U8pFo2U42dwQgtUrZQ@mail.gmail.com>
	 <1315984468.2172.10.camel@deskari>
	 <CAP5A+B9uDj4kCowbEKgX1J74zWvBarp64Cn4YVom-a8BYtab4w@mail.gmail.com>
	 <1315989282.2172.36.camel@deskari>
	 <CAP5A+B-GWN+oJhcVbB24swfmH=-dE4sViNqF+hX6=D1owzOLzA@mail.gmail.com>
	 <1315990630.2172.51.camel@deskari>
	 <CAP5A+B9Me0RX3PY7Uwf=VuaHzaPtoNY0q9gxFg9H-Q3N2giC2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:53738 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754489Ab1INOL4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Sep 2011 10:11:56 -0400
In-Reply-To: <CAP5A+B9Me0RX3PY7Uwf=VuaHzaPtoNY0q9gxFg9H-Q3N2giC2Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: Rob Clark <robdclark@gmail.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

On Wed, 2011-09-14 at 17:50 +0530, K, Mythri P wrote:
> Hi,
> 
> On Wed, Sep 14, 2011 at 2:27 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On Wed, 2011-09-14 at 14:18 +0530, K, Mythri P wrote:
> >> On Wed, Sep 14, 2011 at 2:04 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> >> > On Wed, 2011-09-14 at 13:57 +0530, K, Mythri P wrote:
> >> >> On Wed, Sep 14, 2011 at 12:44 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> >
> > <snip>
> >
> >> > I don't understand this one. How could this be more dynamic? The
> >> > function checks the HPD bit, which (based on my observation) shows the
> >> > status whether a display is connected or not.
> >> There is a GPIO which detects the +3.3V on the line and detects the
> >> cable connect , there is also an interrupt based way.This is ideally
> >> called a Hot-plug detect event according to the spec in HDMI terms.
> >> But what you are saying here is that it is just a poll on the state?
> >
> > Yes, it's just for polling, but I don't quite see the difference. A
> > hot-plug event notifies when the display is connected or disconnected,
> > and detect() tells if a display is connected. They are all about the
> > same thing.
> >
> >> >> So I said if the purpose of this function is only to check for the HPD
> >> >> state bit it is fine.
> >> >
> >> > What does HPD bit tell us then?
> >>
> >> HPD state bit tells whether the cable is connected and whether EDID is
> >
> > This sounds like a good bit to test then. So is there something wrong
> > with using HPD? How does the GPIO differ from HPD bit?
> >
> >> ready to be read, But this is a static check that is done in this
> >> function.
> >
> > I don't understand what you mean with "static". The bit changes
> > dynamically according to the connect/disconnect state, and the bit is
> > checked dynamically when detect() is called.
> >
> Well ! Who would call the detect and why ? By Dynamic i meant when the
> cable is physically disconnected and connected there is detection
> logic which can be implemented either by GPIo/Interrupts.
> When you say the cable is connected , what happens in this case when
> the cable is connected to say monitor of one resolution and then
> plugged out and put to the other. Instead with dynamic method the
> based on the physical connect and disconnect the notification would be
> sent to any listener.

Ok, I see now what you mean.

Yes, you are right, detect() does not "know" if the monitor has changed
between polls, so both notification and polling are needed. I
implemented only polling as there's no HPD event mechanism yet in
omapdss, and also because this was simple and gives DRM basic ability to
detect a monitor.

 Tomi


