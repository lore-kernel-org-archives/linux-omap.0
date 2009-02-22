From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Configuring a TWL GPIO pin as an interrupt
Date: Sun, 22 Feb 2009 20:35:08 +0000
Message-ID: <20090222203507.GA28597@sirena.org.uk>
References: <2C7D3DF36ADFFC479B44490D912B616705D6329B7D@dlee07.ent.ti.com> <20090221023924.GD6224@gandalf> <58B26312-2687-4BF8-AE17-D4D0D5FAA136@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:2950 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462AbZBVUf2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Feb 2009 15:35:28 -0500
Content-Disposition: inline
In-Reply-To: <58B26312-2687-4BF8-AE17-D4D0D5FAA136@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: me@felipebalbi.com, "Lopez Cruz, Misael" <x0052729@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sat, Feb 21, 2009 at 11:33:43AM +0100, Koen Kooi wrote:

> Don't forget to use the proper API for it: http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=include/sound/jack.h;hb=master

Yes, please, but note that there's an ASoC wrapper for that in sound/soc
in -next which should be used instead of the raw jack reporting API.  It
separates the definition of the jack from the detection mechanisms since
the wiring is always going to be board specific - eg, headphone and
microphone may be exposed on one physical jack or as separate jacks.
