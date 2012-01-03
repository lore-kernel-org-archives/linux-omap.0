From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 0/4] OMAPDSS/ASoC: Repair broken HDMI audio in K3.2-rcX
Date: Mon, 2 Jan 2012 23:57:54 -0600
Message-ID: <1325570274.2082.5.camel@dexx0075479.dextra-mty.naucm.ext.ti.com>
References: <1324018993-31466-1-git-send-email-ricardo.neri@ti.com>
	 <CAP5A+B8ZPMBROeu6wkT8G5v_e1jhYTNrCATP0mi71wcsC2DZHg@mail.gmail.com>
	 <20111229184829.GC32392@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42957 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810Ab2ACF6A (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Jan 2012 00:58:00 -0500
In-Reply-To: <20111229184829.GC32392@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "K, Mythri P" <mythripk@ti.com>, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com

Hi Mythri, Mark,
On Thu, 2011-12-29 at 18:48 +0000, Mark Brown wrote:
> On Thu, Dec 29, 2011 at 03:26:48PM +0530, K, Mythri P wrote:
> 
> > We could not also try to move the ASoC HDMI audio codec driver from
> > DSS to sound, but this is good for now.
> 
> You should certainly send the driver for review on the ALSA list...

Yes, the goal is to move the ASoC OMAP4 HDMI codec to sound for K3.3. I
will submit to the ALSA list when I have a first draft.

Thanks,

Ricardo


