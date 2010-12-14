From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 0/3] OMAP: Introduce Backlight driver for Sharp
 LS037V7DW01 LCD panel
Date: Tue, 14 Dec 2010 15:53:30 +0200
Message-ID: <1292334810.6893.126.camel@tubuntu>
References: <1291118860-10325-1-git-send-email-bryan.wu@canonical.com>
	 <1291217575.10133.165.camel@tubuntu>
	 <AANLkTikMzXs=Rp8Wgm5PRD-VEGn=O9ii+by_27hsP-ar@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:34235 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753219Ab0LNNxq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Dec 2010 08:53:46 -0500
In-Reply-To: <AANLkTikMzXs=Rp8Wgm5PRD-VEGn=O9ii+by_27hsP-ar@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Bryan Wu <bryan.wu@canonical.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com, rpurdie@rpsys.net

On Mon, 2010-12-06 at 13:06 +0800, ext Bryan Wu wrote:

> > This kind of backlight is, in a sense, totally separate component from
> > the panel itself. All they have in common is that they are packaged in
> > the same physical display module, and they usually share the same
> > connector.
> >
> > I have seen three kinds of backlights on OMAP devices:
> > - on/off GPIO (like on 3430 SDP)
> It seems like that we need a gpio_bl.c driver for this kind of usage.
> 
> > - PWM based (zoom seems to have this)
> 
> I failed to find any PWM or Backlight code in ZOOM boards source file.
> Is that possible to us pwm_bl.c driver which is used by pxa?

It's not yet in the official kernel. You can find it in
arch/arm/mach-omap2/board-zoom-display.c in my tree, under devel-branch.

I haven't looked at pwm_bl.c, but I wouldn't be surprised if there
already was a driver we can use for this.

> > - Panel controlled (Taal-panel. Also PWM based, but OMAP doesn't see
> > that)
> >
> Yeah, I don't plan to reform this driver at this time.
> 
> > The first two could (should?) be totally separate backlights from the
> > panel itself. For those, a generic backlight driver could perhaps work.
> > The third one needs to be quite tied to the panel driver, and I'm not
> > sure how easy it would be to have a separate driver for that.
> >
> 
> OK, I totally understand you concern now. How about a GPIO based
> backlight driver for the first 2 cases.

GPIO based backlight driver would work properly only for the first case.

 Tomi


