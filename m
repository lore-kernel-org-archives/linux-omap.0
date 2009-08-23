From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [RFC][PATCH 1/3 v2] ARM: OMAP: DMA: Add support
	for DMA channel self linking on OMAP1510
Date: Sun, 23 Aug 2009 19:05:43 +0100
Message-ID: <20090823180543.GA6167@opensource.wolfsonmicro.com>
References: <200908101050.02530.jkrzyszt@tis.icnet.pl> <200908231756.13016.jkrzyszt@tis.icnet.pl> <20090823170359.GA3488@sirena.org.uk> <200908231945.40187.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:36281 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933063AbZHWSFn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 23 Aug 2009 14:05:43 -0400
Content-Disposition: inline
In-Reply-To: <200908231945.40187.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jarkko Nikula <jhnikula@gmail.com>

On Sun, Aug 23, 2009 at 07:45:39PM +0200, Janusz Krzysztofik wrote:

> If I missed something and my original patch has really been applied, I'll be 
> happy to prepare a new version that reverts previos changes and makes those 
> proposed in patch v2, if those are acceptable.

If none of your patches have been applied then what are the other
patches that depend on this?  Nobody reported any issues in testing with
the other OMAP patches.

I don't really mind which tree these go via but I rather suspect that
ALSA will be better given all the other changes and I also suspect that
you'll need to regenerate your changes against a current tree due to
those changes.  Tony, are you OK with that?
