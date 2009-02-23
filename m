From: David Brownell <david-b@pacbell.net>
Subject: Re: Configuring a TWL GPIO pin as an interrupt
Date: Sun, 22 Feb 2009 23:26:39 -0800
Message-ID: <200902222326.39232.david-b@pacbell.net>
References: <2C7D3DF36ADFFC479B44490D912B616705D6329B7D@dlee07.ent.ti.com> <200902202112.23307.david-b@pacbell.net> <2C7D3DF36ADFFC479B44490D912B616705D61AF093@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp122.sbc.mail.sp1.yahoo.com ([69.147.64.95]:39215 "HELO
	smtp122.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751105AbZBWH0l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Feb 2009 02:26:41 -0500
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705D61AF093@dlee07.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, Mark Brown <broonie@sirena.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sunday 22 February 2009, Lopez Cruz, Misael wrote:
> In the particular case of ALSA SoC, could the machine/board driver
> be a better place to handle all GPIO/IRQ configuration? That driver
> also contains only board specific code.  

It'd be best of the ASoC stuff could sit with all the other
board-specfic init code, in arch/*/mach-*/board-*.c files,
but I understand those interfaces are not yet stable enough
to support that ... that's why they're in sound/soc/*/*.c
files instead.

In any case ... everything I said still stands.  If you're
doing this for ASoC, you'll need some way to pass data
to the ASoC board-specific code from normal board-specific
code, since some of the relevant config data is not static.

The current ASoC model seems to be biased towards static
configurations.  Notice how it's got to create its own
platform_device nodes ... it can't easily use the standard
mechanisms for associating platform_data or archdata with
those nodes, ditto clocks.

- dave
