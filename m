From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [alsa-devel] [PATCHv4 0/7] TWL6030 audio codec initial support
Date: Thu, 25 Feb 2010 09:13:02 +0000
Message-ID: <1267089182.3255.58.camel@odin>
References: <1889FA7136B567478A67D4B0F85B0CCE65DD1B12@dlee06.ent.ti.com>
	 <1267011618.3274.202.camel@odin>
	 <1889FA7136B567478A67D4B0F85B0CCE65DD2303@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f219.google.com ([209.85.220.219]:49327 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233Ab0BYJOk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Feb 2010 04:14:40 -0500
Received: by fxm19 with SMTP id 19so6004106fxm.21
        for <linux-omap@vger.kernel.org>; Thu, 25 Feb 2010 01:14:39 -0800 (PST)
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCE65DD2303@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Olaya, Margarita" <magi.olaya@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>

On Wed, 2010-02-24 at 18:17 -0600, Olaya, Margarita wrote:
> 
> > -----Original Message-----
> > From: Liam Girdwood [mailto:lrg@slimlogic.co.uk]
> > Sent: Wednesday, February 24, 2010 5:40 AM
> > To: Olaya, Margarita
> > Cc: alsa-devel@alsa-project.org; linux-omap@vger.kernel.org; broonie@opensource.wolfsonmicro.com
> > Subject: Re: [PATCHv4 0/7] TWL6030 audio codec initial support
> > 
> > On Tue, 2010-02-23 at 18:10 -0600, Olaya, Margarita wrote:
> > > Following patch series add initial support for TWL6030 codec driver.
> > > The patch set is based on the series sent from Misael Lopez in October 2009.
> > >
> > > Changes from v3:
> > > - Remove snd_soc_init_card function
> > > - Adapt to latest twl core changes based on Balaji's comment
> > >
> > > Regards,
> > > Margarita
> > >
> > > ---
> > > Misael Lopez Cruz (7):
> > >   OMAP4: PMIC: Add support for twl6030 codec
> > >   ASoC: TWL6030: Add twl6030 codec driver
> > >   ASoC: TWL6030: Manual power-up/down sequences
> > >   ASoC: TWL6030: Add support for low-power PLL
> > >   ASoC: TWL6030: Add restrictions for low-power playback mode
> > >   ASoC: TWL6030: Enable audio interrupt
> > >   ASoC: TWL6030: Detect power-up sequence completion
> > 
> > Btw, since this is a new driver can you rebase the 6 codec patches into
> > a single patch.
> > 
> 
> The second patch adds the basic support for the codec and the others add features, that way it could be easier to review.

Some of the subsequent patches are actually removing chunks of code
rather than just adding new features. In this case it's actually easier
to review the complete codec driver as one patch rather than a series of
changes (showing your internal development history).

Thanks

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk

