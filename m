From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [RFC] [PATCH 1/3] ASoC: Add support for Conexant
 CX20442-11 voice modem codec
Date: Tue, 28 Jul 2009 17:11:32 +0100
Message-ID: <20090728161131.GA22349@rakim.wolfsonmicro.main>
References: <200907220522.29221.jkrzyszt@tis.icnet.pl>
 <200907281659.36000.jkrzyszt@tis.icnet.pl>
 <20090728150727.GA10870@rakim.wolfsonmicro.main>
 <200907281807.31070.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:39712 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754771AbZG1QLd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Jul 2009 12:11:33 -0400
Content-Disposition: inline
In-Reply-To: <200907281807.31070.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: alsa-devel@alsa-project.org, Jonathan McDowell <noodles@earth.li>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, e3-hacking@earth.li, Arun KS <arunks@mistralsolutions.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Tue, Jul 28, 2009 at 06:07:29PM +0200, Janusz Krzysztofik wrote:

> What I would like to retain from the current codec driver are those two modes 
> of operation: without and with the line discipline activated. Initially, the 
> codec would be registered as a platform device, as it is now. Activation of 
> the line discipline would deregister the codec device from the platform bus 
> and reregister it again, now as the line discipline provided device. Is this 
> possible with current ASoC framework?

No, not currently.  But why would you do that, anyway?

Like I say, I'd suggest always keeping the controls registered and just
masking and unmasking from user space - the control indexes get used so
removing them will just confuse things.
