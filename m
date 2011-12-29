From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: It looks like snd-soc-rx51 only works as built-in, not as a
 module
Date: Thu, 29 Dec 2011 21:27:07 +0000
Message-ID: <20111229212707.GA9737@opensource.wolfsonmicro.com>
References: <CAMP44s1DPE3ey+Cf48ShbAu_-vv2NC8ppkABT7fDmsE3_j9AmQ@mail.gmail.com>
 <20111210082741.GA32605@earth.universe>
 <CAMP44s3c68z-+3j9OR3pyBFVzH-LJ7WcMu-BnejhkfrxnF4rqA@mail.gmail.com>
 <20111229183712.GB32392@sirena.org.uk>
 <CAMP44s2Vo0iPa6aq6PGy8YSEnEQuNVi1345BtLV9U8zng61uFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:52255 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753962Ab1L2V1L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Dec 2011 16:27:11 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s2Vo0iPa6aq6PGy8YSEnEQuNVi1345BtLV9U8zng61uFA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Sebastian Reichel <sre@debian.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

On Thu, Dec 29, 2011 at 11:25:50PM +0200, Felipe Contreras wrote:
> On Thu, Dec 29, 2011 at 8:37 PM, Mark Brown
> > On Sat, Dec 10, 2011 at 05:59:57PM +0200, Felipe Contreras wrote:

> >> It was not working for me, but it seems the problem was related to
> >> mdev/udev; snd_soc_tlv320aic3x has to be loaded before snd-soc-rx51.

> > That should not be required, the modules should be loadable in any
> > order.

> Are you sure? I recall having a similar discussion with Rusell King,
> and the conclusion is that certain modules are supposed to be loaded
> by udev at boot time, and it seems snd_soc_tlv320aic3x is one of them.

I'm absolutely positive.  ASoC supports loading the modules in any
order.  udev is supposed to load anything autoloadable at boot time,
including I2C devices, but that's orthogonal to the order in which
things actually get loaded - udev can randomly reorder things if it
feels like it.
