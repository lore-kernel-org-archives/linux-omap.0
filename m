From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH 3/8] McBSP: OMAP3: Add Sidetone feature
Date: Fri, 9 Oct 2009 11:44:59 +0100
Message-ID: <20091009104458.GB5082@sirena.org.uk>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
 <1255003137-1034-4-git-send-email-eduardo.valentin@nokia.com>
 <20091008131702.GC29176@rakim.wolfsonmicro.main>
 <1255064967.30157.178.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:54363 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760535AbZJIKpk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Oct 2009 06:45:40 -0400
Content-Disposition: inline
In-Reply-To: <1255064967.30157.178.camel@eenurkka-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Cc: alsa-devel@alsa-project.org, ext Tony Lindgren <tony@atomide.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>

On Fri, Oct 09, 2009 at 08:09:27AM +0300, Eero Nurkkala wrote:
> On Thu, 2009-10-08 at 15:17 +0200, ext Mark Brown wrote:

> > This stuff, particularly the enable, probably wants to be pushed out via
> > an ALSA API rather than via random sysfs stuff.  It'd be better to
> > publish a control API here and then use that from within ALSA.

> Hmm. What would be the way to transfer 128 x s16 words; is there an ALSA
> control for something like that already ? IIRC correctly, the max
> bytesize per control is (or used to be) something like 256 bytes or so.
> So that gets right at it. (that's the sidetone 128 tap FIR in question)

For things like the FIR you probably don't want to expose the entire
table directly to user space.  Depending on the typical usage it may be
that platform data is the appropriate mechanism, with some simpler thing
presented to applications allowing switching between a limited set of
settings.  sysfs may end up being the best option for the FIR setup.

My main concern here is that the control goes into the ALSA domain so
that the audio drivers know what's going on with these sidetone paths,
particular in terms of the routing.
