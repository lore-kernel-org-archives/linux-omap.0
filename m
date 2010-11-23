From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [alsa-devel] [PATCH 2.6.37-rc1] ASoC: OMAP: fix OMAP1
 compilation problem
Date: Tue, 23 Nov 2010 10:32:39 +0000
Message-ID: <1290508359.3449.6.camel@odin>
References: <201011021550.34885.jkrzyszt@tis.icnet.pl>
	 <alpine.DEB.2.00.1011221745490.20215@utopia.booyaka.com>
	 <20101123092630.7267a7ab.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44372 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969Ab0KWKcp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Nov 2010 05:32:45 -0500
Received: by wyb28 with SMTP id 28so8119325wyb.19
        for <linux-omap@vger.kernel.org>; Tue, 23 Nov 2010 02:32:44 -0800 (PST)
In-Reply-To: <20101123092630.7267a7ab.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, alsa-devel@alsa-project.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, tony@atomide.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, e3-hacking@earth.li, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2010-11-23 at 09:26 +0200, Jarkko Nikula wrote:
> On Mon, 22 Nov 2010 17:48:24 -0700 (MST)
> Paul Walmsley <paul@pwsan.com> wrote:
> 
> > > Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> > 
> > Thanks for fixing this.  What do you think about the following patch 
> > instead?  It should avoid any compiler issues.
> > 
> Hmm.. looks like Janusz's patch is still in Liam's for-2.6.37
> branch only.

Sorry, this pull request was waiting on Takashi's return from vacation.
I'll be doing a pull request shortly.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk

