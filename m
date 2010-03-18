From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv6 2/2] ASoC: TWL6040: Add twl6040 codec driver
Date: Thu, 18 Mar 2010 17:17:38 +0000
Message-ID: <20100318171737.GE6142@rakim.wolfsonmicro.main>
References: <1889FA7136B567478A67D4B0F85B0CCE662AC372@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:43268 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751223Ab0CRRRj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Mar 2010 13:17:39 -0400
Content-Disposition: inline
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCE662AC372@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Olaya, Margarita" <magi.olaya@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>

On Wed, Mar 17, 2010 at 05:42:38PM -0500, Olaya, Margarita wrote:
> From: Misael Lopez Cruz <x0052729@ti.com>
> 
> Initial version of TWL6040 codec driver.

I'm having trouble applying this - using patch by hand says:

patching file sound/soc/codecs/Kconfig
Hunk #1 FAILED at 35.
Hunk #2 succeeded at 168 with fuzz 2.
1 out of 2 hunks FAILED -- saving rejects to file sound/soc/codecs/Kconfig.rej
patching file sound/soc/codecs/Makefile
Hunk #1 FAILED at 22.
patch: **** malformed patch at line 133: aic26.o

It looks like it should be some trivial rebasing things that need
sorting - I'd try to fix up by hand but the "malformed patch" warning is
making me worry something might be getting lost and I've no way of
testing the code.  Could you please generate the patch against:

 git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.35

just to be on the safe side.  Only this patch ran into trouble, the
first one was fine.
