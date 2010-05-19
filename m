From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 0/4] McBSP smart idle and DMA op mode updates for ASoC
Date: Wed, 19 May 2010 17:50:05 +0300
Message-ID: <20100519175005.0e702bdd.jhnikula@gmail.com>
References: <1274213594-26554-1-git-send-email-lrg@slimlogic.co.uk>
	<20100519104209.GI4265@besouro.research.nokia.com>
	<1274267231.3240.117.camel@odin>
	<201005191527.35439.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:48967 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967Ab0ESOuF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 10:50:05 -0400
Received: by ey-out-2122.google.com with SMTP id d26so10031eyd.19
        for <linux-omap@vger.kernel.org>; Wed, 19 May 2010 07:50:04 -0700 (PDT)
In-Reply-To: <201005191527.35439.peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: ext Liam Girdwood <lrg@slimlogic.co.uk>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>

On Wed, 19 May 2010 15:27:35 +0300
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> > The sysfs set interface implies userspace having knowledge of driver
> > capabilities and configuration in order to safely toggle between the two
> > DMA modes. Imo, the mcbsp client driver should be the only entity
> > configuring it's DMA modes (in a safe manner) depending on the use case.
> 
> Furthermore, if there is a need for 'Use Cases', than the machine driver can 
> provide user control to switch between them.
> The thing is that in most cases these are trivial, and mostly the same settings, 
> but if you throw a codec like the tlv320dac33 into the mix, which has it's own 
> FIFO, than things gets complicated.
> The user (the real one, not the developer) has several settings scattered all 
> around the place, and those has to be configured in harmony.
> The only place is to do this, is in the machine driver, whihc than can build up 
> 'scenarios', and configure the things in synchronized manner.
> 
Yes and I think only very few developers know what to do with those op
mode and threshold sysfs controls so most probably they are unused.
Then machine drivers setting them automatically/with some control could
give us more testing base.

But as those sysfs controls are there we must preserve them for a
release cycle or two in case if someone is using them. At least Linus
or Andrew may complain about removal of them.


-- 
Jarkko
