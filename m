From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: It looks like snd-soc-rx51 only works as built-in, not as a
	module
Date: Mon, 2 Jan 2012 19:40:47 +0000
Message-ID: <20120102194046.GA14418@opensource.wolfsonmicro.com>
References: <20111210082741.GA32605@earth.universe> <CAMP44s3c68z-+3j9OR3pyBFVzH-LJ7WcMu-BnejhkfrxnF4rqA@mail.gmail.com> <20111229183712.GB32392@sirena.org.uk> <CAMP44s2Vo0iPa6aq6PGy8YSEnEQuNVi1345BtLV9U8zng61uFA@mail.gmail.com> <20111229212707.GA9737@opensource.wolfsonmicro.com> <CAMP44s2SU_M0Fpt43YDLLhPrgsGzkgpHRWHLcJO4f8N=0HHdvg@mail.gmail.com> <20111229215407.GB9737@opensource.wolfsonmicro.com> <CAMP44s0EzmhdZ4X91c5X7Rn9q44QcUDm2KNDO81ue16SBWM6_g@mail.gmail.com> <20111231005935.GA5835@opensource.wolfsonmicro.com> <CAMP44s1hUYAcMTDBBPAbV=m39oGrbKXUhv44bp71XkNg-dEBzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:47706 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752993Ab2ABTkt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jan 2012 14:40:49 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s1hUYAcMTDBBPAbV=m39oGrbKXUhv44bp71XkNg-dEBzA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Sebastian Reichel <sre@debian.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

On Mon, Jan 02, 2012 at 08:33:03PM +0200, Felipe Contreras wrote:
> On Sat, Dec 31, 2011 at 2:59 AM, Mark Brown

> > Which is relevant because...? =A0To repeat, the ordering of module =
loading
> > is totally ortogonal as any ordering of modules is supported. =A0Yo=
u
> > appear to be totally ignoring what I am writing here.

> One thing how things _should_ be, and another is how things actually
> _are_. Right now snd-soc-rx51 doesn't work if it's loaded before
> snd_soc_tlv320aic3x. Period.

Can you provide logs showing this (with debug logging enabled in
soc-core)?  If this is happening it's a very serious issue, though I am
rather surprised that nobody else has noticed such an issue since the
usual instantiation order would have the card appear before the CODEC
(due to the fact that the card is normally a platform device) and the
structure of the code makes it difficult to imagine a failure path.

> That means that *right now*, snd-soc-rx51 works fine with udev,
> because snd_soc_tlv320aic3x will be loaded at boot time. Now, if
> snd-soc-rx51 is converted and loaded automatically by udev as well,
> the issues might appear again.

Not if we look at and resolve the actual issue.  Once again, any
instantation ordering should be supported.  I really don't understand
why you keep on talking about fixing the module ordering,
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
