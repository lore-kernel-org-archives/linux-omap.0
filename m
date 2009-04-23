From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/1] Activate VDD1, VDD2 and VPLL1 at startup
Date: Thu, 23 Apr 2009 11:17:11 +0100
Message-ID: <20090423101711.GN30105@sirena.org.uk>
References: <1240414529-16258-1-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:59551 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753450AbZDWKRN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Apr 2009 06:17:13 -0400
Content-Disposition: inline
In-Reply-To: <1240414529-16258-1-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org, dbrownell@users.sourceforge.net

On Wed, Apr 22, 2009 at 06:35:29PM +0300, Peter 'p2' De Schrijver wrote:

> This patch activates VDD1, VDD2 and VPLL1 when booting. This is necessary
> because these resources are in warm reset state after a reboot. This means
> their voltage levels cannot be modified so DVFS and smartreflex don't work.

> Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

Since TWL4030 is in mainline now you really ought to submit this and
the other patches you posted immediately before this one to mainline.
It'd be best to CC David Brownell (added here) on TWL4030 regulator
changes too, he's the expert on the regulator features of the chip.
