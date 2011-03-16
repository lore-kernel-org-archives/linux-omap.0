From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
Date: Wed, 16 Mar 2011 12:21:42 +0530
Message-ID: <1300258302.1917.32.camel@lappyti>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>
	 <1299764643.2017.177.camel@deskari> <4D78E3F5.2090600@openelec.tv>
	 <1299827578.2567.1.camel@deskari> <4D79E0A0.9040900@openelec.tv>
	 <1299849774.2479.3.camel@deskari> <4D7A4B44.2030801@openelec.tv>
	 <1299868049.2479.33.camel@deskari> <4D7A6D0F.40906@openelec.tv>
	 <AANLkTin+fnZfFte5v8+G0saDcjCqsT=oQ4U_oGSm-UGn@mail.gmail.com>
	 <4D7CD588.3080100@openelec.tv>  <4D7CEEC8.50803@openelec.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43580 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751675Ab1CPGvu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Mar 2011 02:51:50 -0400
In-Reply-To: <4D7CEEC8.50803@openelec.tv>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephan Raue <mailinglists@openelec.tv>
Cc: "K, Mythri P" <mythripk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sun, 2011-03-13 at 11:20 -0500, Stephan Raue wrote:
> Am 13.03.2011 15:32, schrieb Stephan Raue:

<snip>

> > i have tried this omap2plus defconfig now too, with some little 
> > changes needed to boot my system (config: 
> > http://paste.pocoo.org/show/352917/). Now i get this error (see also: 
> > http://paste.pocoo.org/show/352915/)
> >
> > [    3.255065] omapdss HDMI: fallback to VGA 
> > [    3.271636] omapdss HDMI error: Failed to set PHY_PWR_STATUS
> > [    3.277587] omapdss HDMI error: failed to power on device
> > [    3.283325] omapdss error: failed to power on
> > [    3.287902] omapfb omapfb: Failed to enable display 'hdmi'
> > [    3.293853] Console: switching to colour dummy device 80x30
> > [    3.304595] omapfb omapfb: failed to setup omapfb
> > [    3.309539] omapfb: probe of omapfb failed with error -5
> 
> using omap2plus defconfig with my little changes i need to boot my 
> system i get the error above, also if i remove CONFIG_ARCH_OMAP2. but if 
> i remove CONFIG_ARCH_OMAP3 too i get the error i reported originally 
> (the kernel begins to boot, but crashes) (diff between omap2plus 
> defconfig without CONFIG_ARCH_OMAP2 and omap2plus defconfig without 
> CONFIG_ARCH_OMAP2, CONFIG_ARCH_OMAP3: http://paste.pocoo.org/show/352960/)

I'm currently traveling for this week so I have quite limited ability to
test this. Mythri still haven't been able to reproduce any of these
errors, right?

Anybody else there to test HDMI on Panda and/or Blaze? I pushed the
latest DSS + HDMI patches to a test branch for easier testing (I'll push
Panda DVI patches there also when I get the new version):

git://gitorious.org/linux-omap-dss2/linux.git test

 Tomi


