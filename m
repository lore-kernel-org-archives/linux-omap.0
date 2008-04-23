From: Tony Lindgren <tony@atomide.com>
Subject: Re: [alsa-devel] [RFC/PATCH 1/1] ASoC: Add drivers for the Texas
	Instruments OMAP processors
Date: Wed, 23 Apr 2008 16:59:13 -0700
Message-ID: <20080423235913.GB27546@atomide.com>
References: <1207300948-11598-1-git-send-email-jarkko.nikula@nokia.com> <1207300948-11598-2-git-send-email-jarkko.nikula@nokia.com> <20080421181614.GZ12099@atomide.com> <20080422094845.722a949c.jarkko.nikula@nokia.com> <20080422084928.GA1853@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:52427 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755452AbYDWX7Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Apr 2008 19:59:16 -0400
Content-Disposition: inline
In-Reply-To: <20080422084928.GA1853@rakim.wolfsonmicro.main>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

* Mark Brown <broonie@opensource.wolfsonmicro.com> [080422 01:49]:
> On Tue, Apr 22, 2008 at 09:48:45AM +0300, Jarkko Nikula wrote:
> > "ext Tony Lindgren" <tony@atomide.com> wrote:
> 
> > > The platform_device_register() should be done in board-*.c files.
> 
> > This is a valid point. I think it should be possible to have also in
> > ASoC v1 e.g n810_mcbsp_aic33 driver whose probe function would be more
> > or less like n810_soc_init now. At least sound/soc/fsl/mpc8610_hpcd.c is
> > doing similar thing.
> 
> > Mark, any thoughts?
> 
> Leave it as-is for ASoC v1, the soc-audio device can't meaningfully be
> defined in the platform data.  ASoC v2 lets you define a device for the
> platform driver for the particular board (as well as for things like I2S
> controllers on the SoC) which deals with this a lot better.

I'll push this to linux-omap tree, and will replace it with whatever
falls from mainline tree later on.

Tony
