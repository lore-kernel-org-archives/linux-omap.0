From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [alsa-devel] [PATCH 1/3] ASoC: Add GPIO support for jack
	reporting interface
Date: Mon, 2 Mar 2009 11:38:47 +0000
Message-ID: <20090302113845.GA19744@sirena.org.uk>
References: <2C7D3DF36ADFFC479B44490D912B616705EC8B1C03@dlee07.ent.ti.com> <20090226115243.GC4229@sirena.org.uk> <2C7D3DF36ADFFC479B44490D912B616705ECC76DF8@dlee07.ent.ti.com> <20090227130502.GA4415@sirena.org.uk> <2C7D3DF36ADFFC479B44490D912B616705ECC77374@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:2396 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbZCBLit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 06:38:49 -0500
Content-Disposition: inline
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705ECC77374@dlee07.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sun, Mar 01, 2009 at 07:54:36PM -0600, Lopez Cruz, Misael wrote:

> detection/report. There can be a generic detection/report function
> for gpio, I was thinking in something like:

Yes, that's more or less much what I was looking for.

> > Some systems won't be able to use their speaker output while a
> > headphone is connected and so will want to make sure to update
> > both speaker and headphone when the headphone jack status
> > changes.

> Having a single/generic report function like shown above (as is) we
> can't handle that case.

Sure it can - remember that the DAPM updates are done separately to the 
detection and can be set to invert the status reported for the power.
The speaker won't be visible as a jack in a situation like this.

> Could we leave the actual implementation of this report function to
> the machine driver? Since the things being done in detection function
> are common (even if other status are wanted to be updated), then
> probably machine driver could define a specific function ("action")
> for doing extra tasks, it can be called from generic gpio detect
> function. Could it be a valid approach?

That sounds like adding a callback for power updates on the jack itself
to me (which isn't a bad idea), rather than changing the report function
of the jack detection method.  The need for machine-specific extra
actions probably isn't specific to jacks that are detected via GPIOs.
