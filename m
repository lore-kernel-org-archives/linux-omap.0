From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 09/15] OMAP: DSS2: HDMI: implement detect()
Date: Mon, 19 Sep 2011 09:50:46 +0300
Message-ID: <1316415046.1978.19.camel@deskari>
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
	 <1316009509.2118.6.camel@deskari>
	 <CAP5A+B-_19gPDmjJGBHpcDcGPGyt9QvFXFwgjGPUqr-QY9SPJg@mail.gmail.com>
	 <1316066265.1880.6.camel@deskari>
	 <CAP5A+B_WvtNTi9ckyor-+5bo7n6GkeTSAvhDsrGQxhPZWgXO0w@mail.gmail.com>
	 <1316068371.1880.25.camel@deskari>
	 <CAP5A+B9upB3VUaRme84Fm6ewx9KkyOu4hCavMetkEeKcSHORXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:54930 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751757Ab1ISGuw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Sep 2011 02:50:52 -0400
In-Reply-To: <CAP5A+B9upB3VUaRme84Fm6ewx9KkyOu4hCavMetkEeKcSHORXw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: Rob Clark <robdclark@gmail.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

On Fri, 2011-09-16 at 18:11 +0530, K, Mythri P wrote:
> Hi,

> >> Sequence with HPD:
> >> 1.Register for HPD connect.
> >> 2.Enable display
> >> 3.Notify DRM/Audio/Kernel component that wants to listen to this event.
> >
> > Why would you enable the display even if there's no monitor connected?
> >
> > And when the DRM starts, how does DRM know if the display was already
> > connected? Would you send a HPD event when DRM registers to the event
> > even if there's no actual plug-in event done (i.e. user actually
> > connecting the cable)?
> >
> HPD event would be triggered only when the cable is connected , and
> the EDID is ready to be read by the monitor. So the question enabling
> display doesnt exist. When HDMI is enabled in the HPD mode it will be
> in minimal power mode.

I don't think that will work correctly. "enable" in the current driver
means that the DISPC output will be enabled, and the display is showing
an image.

How would you implement the case with your model where the user wants to
get the EDID information, but doesn't want to enable the display yet
(send an output signal)?

I think we need a new power state for the displays. DSI panels could use
it also, as there's a need to turn them on for configuration before
actually turning on the actual display.

 Tomi


