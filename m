From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [alsa-devel] [PATCH 1/3] ASoC: Add GPIO support for jack
	reporting interface
Date: Mon, 2 Mar 2009 22:55:29 +0000
Message-ID: <20090302225527.GA6390@sirena.org.uk>
References: <2C7D3DF36ADFFC479B44490D912B616705EC8B1C03@dlee07.ent.ti.com> <20090226115243.GC4229@sirena.org.uk> <2C7D3DF36ADFFC479B44490D912B616705ECC76DF8@dlee07.ent.ti.com> <20090227130502.GA4415@sirena.org.uk> <2C7D3DF36ADFFC479B44490D912B616705ECC77374@dlee07.ent.ti.com> <20090302113845.GA19744@sirena.org.uk> <2C7D3DF36ADFFC479B44490D912B616705ECC77862@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:1654 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803AbZCBWzi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 17:55:38 -0500
Content-Disposition: inline
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705ECC77862@dlee07.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Mar 02, 2009 at 03:16:22PM -0600, Lopez Cruz, Misael wrote:

> > That sounds like adding a callback for power updates on the jack itself
> > to me (which isn't a bad idea), rather than changing the report function
> > of the jack detection method.  The need for machine-specific extra
> > actions probably isn't specific to jacks that are detected via GPIOs.

> In that situation, power updates should come only when the jack reporting
> bits are either all active (jack enabled) or none (jack disabled), is that
> correct?

No, the jack detect bits can change independently - you won't always
physically be able to get everything that can be detected to report at
once (eg, something that can distinguish between headphones and line
output) or things may not always be present together (eg, a jack could
detect headphones but no microphone even if it's possible that both may
be present simultaneously).

> If so, then machine drivers can create callbacks receiving the soc_codec
> the jack belongs to and the current state of the jack. All the power updates
> (dapm_enable_pin/damp_disable_pin) will happen in the callback in machine
> driver but the dapm sync will happen in soc jack framework (i.e. when
> reporting current status of the jack).

No.  The framework takes care of doing the power updates already, there
is no need to add that functionality since the machine drivers can just
use a simple data table.  A callback could be used to do things that
can't be coped with already or more complex updates that aren't simply
directly mirroring the status in DAPM pins.
