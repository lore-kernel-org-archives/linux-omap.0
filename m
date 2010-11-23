From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 2.6.37-rc1] ASoC: OMAP: fix OMAP1 compilation problem
Date: Tue, 23 Nov 2010 09:38:43 +0200
Message-ID: <20101123093843.23e4d579.jhnikula@gmail.com>
References: <201011021550.34885.jkrzyszt@tis.icnet.pl>
	<alpine.DEB.2.00.1011221748410.20215@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:45272 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979Ab0KWHif (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Nov 2010 02:38:35 -0500
Received: by ewy5 with SMTP id 5so2261260ewy.19
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 23:38:33 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1011221748410.20215@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, e3-hacking@earth.li, tony@atomide.com, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

On Mon, 22 Nov 2010 17:50:54 -0700 (MST)
Paul Walmsley <paul@pwsan.com> wrote:

> 
> By the way, ASoC and OMAP audio-hackers, I deeply regret how much trouble 
> that SCM cleanup series has caused.  It does not meet my personal 
> standards for a patch-series...
> 
Hey, small compile breaks happens to everyone and word trouble doesn't
come to my mind when speaking about your set.

Your set actually did one major step forward with ASoC OMAP drivers -
now it's possible to have modular build with them so your work has lot
of benefits to developers and distro builders.


-- 
Jarkko
