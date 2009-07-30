From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 11/20] OMAP: McBSP: Add link DMA mode selection
Date: Thu, 30 Jul 2009 14:47:25 +0100
Message-ID: <20090730134725.GA29631@rakim.wolfsonmicro.main>
References: <1248958183-15015-5-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-6-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-7-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-8-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-9-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-10-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-11-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-12-git-send-email-eduardo.valentin@nokia.com>
 <20090730130442.GD9975@sirena.org.uk>
 <20090730132808.GA22978@esdhcp037198.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:56253 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750912AbZG3Nr0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Jul 2009 09:47:26 -0400
Content-Disposition: inline
In-Reply-To: <20090730132808.GA22978@esdhcp037198.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>

On Thu, Jul 30, 2009 at 04:28:08PM +0300, Eduardo Valentin wrote:
> On Thu, Jul 30, 2009 at 03:04:42PM +0200, ext Mark Brown wrote:

> > Is this really something that people would want to tweak at runtime
> > (except for test purposes)?

> Yes, test purposes, bug also, the same link could be sometime used for low-power
> playback while sometime for low-latency processing where as accurate as
> possible DMA pointer position info is needed.

Latency you *should* be able to infer from the application behaviour.
