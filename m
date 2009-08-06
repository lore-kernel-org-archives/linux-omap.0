From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC] [PATCH] ASoC: OMAP: full duplex mode fix
Date: Thu, 6 Aug 2009 11:16:51 +0200
Message-ID: <200908061116.53726.jkrzyszt@tis.icnet.pl>
References: <200908030332.06727.jkrzyszt@tis.icnet.pl> <20090805102149.bfcafa35.jhnikula@gmail.com> <20090805114254.02e3d0e2.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:39775 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751232AbZHFJUA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Aug 2009 05:20:00 -0400
In-Reply-To: <20090805114254.02e3d0e2.jhnikula@gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>, e3-hacking@earth.li
Cc: Arun K S <arunks@mistralsolutions.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Wednesday 05 August 2009 10:42:54 Jarkko Nikula wrote:
> On Wed, 5 Aug 2009 10:21:49 +0300
> Jarkko Nikula <jhnikula@gmail.com> wrote:
> > > If my analysis is correct, the best solution I can see would be
> > > starting McBSP transfer for one direction only, not both, so the
> > > opposite direction can be started when needed. That requires deeper and
> > > wider OMAP knowledge and a change in omap_mcbsp_start() API though. I
> > > am not in a position to deal with this myself, I'm afraid.
> >
> > I favor this change. Actually I remember I was thinking shortly to
> > change API of omap_mcbsp_start and _stop more than year back or so but
> > didn't find it necessary back then.
> >
> > I think change will be trivial. Basically two new arguments indicating
> > are the TX/RX active and let the first/last caller to deal with
> > sample-rate generator and frame sync activation/de-activation.
>
> I hacked a patch below. Can you test does it help?

Yes, it does. Works as expected in all possible combinations I have tried: 
start recording while playing, start playing while recording, start recording 
and playing simultaneously.
Thanks.

Tested-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
