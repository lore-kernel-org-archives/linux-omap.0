From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: It looks like snd-soc-rx51 only works as built-in, not as a
 module
Date: Thu, 29 Dec 2011 21:54:08 +0000
Message-ID: <20111229215407.GB9737@opensource.wolfsonmicro.com>
References: <CAMP44s1DPE3ey+Cf48ShbAu_-vv2NC8ppkABT7fDmsE3_j9AmQ@mail.gmail.com>
 <20111210082741.GA32605@earth.universe>
 <CAMP44s3c68z-+3j9OR3pyBFVzH-LJ7WcMu-BnejhkfrxnF4rqA@mail.gmail.com>
 <20111229183712.GB32392@sirena.org.uk>
 <CAMP44s2Vo0iPa6aq6PGy8YSEnEQuNVi1345BtLV9U8zng61uFA@mail.gmail.com>
 <20111229212707.GA9737@opensource.wolfsonmicro.com>
 <CAMP44s2SU_M0Fpt43YDLLhPrgsGzkgpHRWHLcJO4f8N=0HHdvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:55121 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754314Ab1L2VyM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Dec 2011 16:54:12 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s2SU_M0Fpt43YDLLhPrgsGzkgpHRWHLcJO4f8N=0HHdvg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Sebastian Reichel <sre@debian.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

On Thu, Dec 29, 2011 at 11:51:11PM +0200, Felipe Contreras wrote:
> On Thu, Dec 29, 2011 at 11:27 PM, Mark Brown
> > On Thu, Dec 29, 2011 at 11:25:50PM +0200, Felipe Contreras wrote:
> >> On Thu, Dec 29, 2011 at 8:37 PM, Mark Brown
> >> > On Sat, Dec 10, 2011 at 05:59:57PM +0200, Felipe Contreras wrote=
:

> >> >> It was not working for me, but it seems the problem was related=
 to
> >> >> mdev/udev; snd_soc_tlv320aic3x has to be loaded before snd-soc-=
rx51.

> >> > That should not be required, the modules should be loadable in a=
ny
> >> > order.

> >> Are you sure? I recall having a similar discussion with Rusell Kin=
g,
> >> and the conclusion is that certain modules are supposed to be load=
ed
> >> by udev at boot time, and it seems snd_soc_tlv320aic3x is one of t=
hem.

> > I'm absolutely positive. =A0ASoC supports loading the modules in an=
y
> > order. =A0udev is supposed to load anything autoloadable at boot ti=
me,
> > including I2C devices, but that's orthogonal to the order in which
> > things actually get loaded - udev can randomly reorder things if it
> > feels like it.

> Yes, but udev loads snd_soc_tlv320aic3x, not snd-soc-rx51.

That is compltelely orthogonal to what you were saying above about the
ordering of module loading.

The reason the driver is not loaded automatically is that the OMAP
machine drivers have not been converted to platform devices.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
