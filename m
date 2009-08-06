From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC] [PATCH] ASoC: OMAP: full duplex mode fix
Date: Thu, 6 Aug 2009 02:27:08 +0200
Message-ID: <200908060227.09357.jkrzyszt@tis.icnet.pl>
References: <200908030332.06727.jkrzyszt@tis.icnet.pl> <20090805114254.02e3d0e2.jhnikula@gmail.com> <4A798897.5000904@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:44830 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751814AbZHFA1y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Aug 2009 20:27:54 -0400
In-Reply-To: <4A798897.5000904@tis.icnet.pl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Wednesday 05 August 2009 15:26:47 Janusz Krzysztofik wrote:
> Jarkko Nikula wrote:
> > On Wed, 5 Aug 2009 10:21:49 +0300
> > I hacked a patch below. Can you test does it help?
>
> Will do tonight (CET).

Sorry, but I was not able to perform any tests in a consistent way. Something 
strange was happening to my hardware, no matter with or without your patch, 
omap_mcbsp_dump_reg() readings was somewhat random. Will retry tomorrow.

> Now seeing how easy it was (for you ;), I think I could try to follow
> that way an modify omap_mcbsp_config() in the same spirit, if you find
> it of any use.

Maybe not omap_mcbsp_config() itself, but rather asoc omap functions that 
prepare data for it, not sure yet. The idea would be to enable independent 
(asymmetric) configuration of streams.

Janusz
