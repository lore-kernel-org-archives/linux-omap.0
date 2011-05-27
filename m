From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 2/2] OMAP: add omap_device_reset()
Date: Fri, 27 May 2011 19:40:27 +0300
Message-ID: <1306514427.1905.27.camel@deskari>
References: <1306481908-7386-1-git-send-email-tomi.valkeinen@ti.com>
	 <1306481908-7386-3-git-send-email-tomi.valkeinen@ti.com>
	 <4DDF9B5D.7060408@ti.com> <1306500367.1905.18.camel@deskari>
	 <4DDFB8AF.1080800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:42308 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754322Ab1E0Qkc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 May 2011 12:40:32 -0400
Received: by mail-ey0-f180.google.com with SMTP id 24so1102458eyg.39
        for <linux-omap@vger.kernel.org>; Fri, 27 May 2011 09:40:31 -0700 (PDT)
In-Reply-To: <4DDFB8AF.1080800@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, 2011-05-27 at 16:43 +0200, Cousson, Benoit wrote:
> On 5/27/2011 2:46 PM, Valkeinen, Tomi wrote:
> > On Fri, 2011-05-27 at 14:38 +0200, Cousson, Benoit wrote:
> >> Hi Tomi,
> >>
> >> On 5/27/2011 9:38 AM, Valkeinen, Tomi wrote:
> >>> Add omap_device_reset() function which can be used to reset the hwmods
> >>> associated with the given platform device.
> >>
> >> We've never exposed it because we are trying to avoid that any driver
> >> play with asynchronous HW reset. That can lead to undefined HW behavior :-(
> >>
> >> Do you have some strong need for that?
> >
> > DSS driver has been designed so that it resets the HW before it begins
> > programming it. That way we get the HW into known state. Otherwise we
> > need to be extra careful to program all possible registers to a sane
> > value. Not impossible, of course, but requires extra work.
> >
> > I noticed the problem with DSI driver, it didn't work anymore if I
> > didn't reset it.
> >
> > Why does it lead to undefined HW behaviour? Isn't it much better to
> > reset the HW before starting to use it to be 100% sure it's in known and
> > valid state?
> 
> In theory, but since your are resetting only the DSS IP, it can leads to 
> side effect at SoC level. Especially wrt to clock management.

Out of interest, can you tell more what problems it could cause? Can
they be solved in the hwmod reset code?

Also one thing to note, VENC needs a softreset after changing certain
configurations, as per TRM. However, VENC doesn't use the standard
syscontrol mechanism, so that cannot be done via omap_device interface
anyway.

> > Especially in error situations it may be difficult (even impossible) to
> > recover without reset. DISPC has been known to froze in some sync lost
> > situations, and, if I recall right, if DSI transfer is aborted the only
> > way to recover is to reset the DSI block (on OMAP3).
> 
> In case of recovery error it makes sense. What we did with hardreset is 
> to re-assert the reset upon disable of the module and then the next 
> enable will de-assert it. Softreset does not do that today.
> 
> My only concern is that people might start abusing that kind of API to 
> use that for funtionnal purpose instead of error recovery.

Why do you see it's abusing? I think it's a good driver design to reset
the HW before starting operation. Perhaps it's true that in some cases
reset could hide (or fix, in a way) a bug in the driver, but in the end
what we want is a driver that works in every situation. And doing a HW
reset sounds a good way to make the driver more robust.

> This other issue is that it will add another OMAP specific IP to the driver.

I presume IP == API. And that is true. But isn't reset functionality
present in most HW blocks, and thus would it make a good addition to the
generic API?

 Tomi


