From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Configuring a TWL GPIO pin as an interrupt
Date: Mon, 23 Feb 2009 14:17:52 +0000
Message-ID: <20090223141751.GB2078@sirena.org.uk>
References: <2C7D3DF36ADFFC479B44490D912B616705D6329B7D@dlee07.ent.ti.com> <2C7D3DF36ADFFC479B44490D912B616705D61AF093@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:2777 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbZBWOR5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 09:17:57 -0500
Content-Disposition: inline
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705D61AF093@dlee07.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: David Brownell <david-b@pacbell.net>, "me@felipebalbi.com" <me@felipebalbi.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Feb 23, 2009 at 12:07:25AM -0600, Lopez Cruz, Misael wrote:

> In the particular case of ALSA SoC, could the machine/board driver be a better place to handle all GPIO/IRQ configuration? That driver also contains only board specific code.--
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Normally the arch/arm code would configure any multi-function pins (this
is normally required for lowest power consumption) and the actual IRQ
requesting and so on would be done by the machine and/or codec drivers
(depending on how exactly the hardware implements this).
