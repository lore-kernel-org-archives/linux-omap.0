From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 11/20] OMAP: McBSP: Add link DMA mode selection
Date: Thu, 30 Jul 2009 14:04:42 +0100
Message-ID: <20090730130442.GD9975@sirena.org.uk>
References: <1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com> <1248958183-15015-4-git-send-email-eduardo.valentin@nokia.com> <1248958183-15015-5-git-send-email-eduardo.valentin@nokia.com> <1248958183-15015-6-git-send-email-eduardo.valentin@nokia.com> <1248958183-15015-7-git-send-email-eduardo.valentin@nokia.com> <1248958183-15015-8-git-send-email-eduardo.valentin@nokia.com> <1248958183-15015-9-git-send-email-eduardo.valentin@nokia.com> <1248958183-15015-10-git-send-email-eduardo.valentin@nokia.com> <1248958183-15015-11-git-send-email-eduardo.valentin@nokia.com> <1248958183-15015-12-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:53068 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbZG3NEm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jul 2009 09:04:42 -0400
Content-Disposition: inline
In-Reply-To: <1248958183-15015-12-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org, Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>

On Thu, Jul 30, 2009 at 03:49:34PM +0300, Eduardo Valentin wrote:

> It adds a new sysfs file, where the user can configure the mcbsp mode to use.
> If the mcbsp channel is in use, it does not allow the change.
> Than in omap_pcm_open we can call the omap_mcbsp_get_opmode to get the mode,
> store it, than use it to implement the different modes.

Is this really something that people would want to tweak at runtime
(except for test purposes)?
