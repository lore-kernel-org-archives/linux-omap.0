From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Configuring a TWL GPIO pin as an interrupt
Date: Mon, 23 Feb 2009 22:20:16 +0000
Message-ID: <20090223222016.GA6584@sirena.org.uk>
References: <2C7D3DF36ADFFC479B44490D912B616705D6329B7D@dlee07.ent.ti.com> <200902202112.23307.david-b@pacbell.net> <2C7D3DF36ADFFC479B44490D912B616705D61AF093@dlee07.ent.ti.com> <200902222326.39232.david-b@pacbell.net> <2C7D3DF36ADFFC479B44490D912B616705D632A0EE@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:2230 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842AbZBWWU0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 17:20:26 -0500
Content-Disposition: inline
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705D632A0EE@dlee07.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: David Brownell <david-b@pacbell.net>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Feb 23, 2009 at 04:11:04PM -0600, Lopez Cruz, Misael wrote:

[Please fix your mail client to wrap lines at ~80 characters, it makes
your mails much easier to work with.]

> I think that if I move the platform_device registration from machine
> driver to board file I can append jack detection information (gpio
> pin, irq) through "platform_data" of "dev" field in platform_device
> structure. And then in the "probe" part in ASoC machine driver I can
> receive it.

Yes, though unless you actually have a generic ASoC machine driver that
works over multiple boards it's as well just skipping the platform data.
Look at s3c24xx_uda134x for an example of doing this.

If these are CPU side GPIOs that you're talking about you'll also want
to write the standard utility for using gpiolib for jack detection that
I've not got round to doing yet :)
