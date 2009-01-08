From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] Add support for GPIO LEDs on pandora
Date: Thu, 8 Jan 2009 15:28:19 +0000
Message-ID: <20090108152818.GE25876@sirena.org.uk>
References: <1227780163-5879-1-git-send-email-notasas@gmail.com> <20090108143232.GO27566@atomide.com> <03538FC0-A9B7-4770-B799-6730E9F09899@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:2127 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760629AbZAHP2Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2009 10:28:24 -0500
Content-Disposition: inline
In-Reply-To: <03538FC0-A9B7-4770-B799-6730E9F09899@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: Tony Lindgren <tony@atomide.com>, Grazvydas Ignotas <notasas@gmail.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Richard Purdie <rpurdie@rpsys.net>

On Thu, Jan 08, 2009 at 03:56:07PM +0100, Koen Kooi wrote:

> That's a wrong usage of the 'backlight' trigger, which shouldn't get  
> into mainline since it sets a bad example. The backlight trigger is  

Too late, it's already there.

> meant to sync leds with the backlight (e.g. dim keypad leds), not to  
> make leds a backlight.

Indeed, though it does get the job done (modulo setting the brightness
via the backlight interface).  I'm not sure if it's better to make the
existing trigger to do what we want or to come up with some other way of
using LEDs as a backlight.
