From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] Add support for GPIO LEDs on pandora
Date: Fri, 9 Jan 2009 13:53:04 +0200
Message-ID: <20090109115302.GI2536@atomide.com>
References: <1227780163-5879-1-git-send-email-notasas@gmail.com> <20090108152818.GE25876@sirena.org.uk> <6ed0b2680901080829p740cf017y2f5dd0d59f025743@mail.gmail.com> <200901081204.10441.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60788 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751AbZAILxM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jan 2009 06:53:12 -0500
Content-Disposition: inline
In-Reply-To: <200901081204.10441.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Mark Brown <broonie@sirena.org.uk>, Koen Kooi <k.kooi@student.utwente.nl>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Richard Purdie <rpurdie@rpsys.net>

* David Brownell <david-b@pacbell.net> [090108 22:04]:
> On Thursday 08 January 2009, Grazvydas Ignotas wrote:
> > Well this was only temporary solution until we have proper code to
> > control BL using TWL4030's PWM capability.
> 
> I have code to support the PWM0/PWM1 signals that needs testing,
> so that's not far away.  The LEDA/LEDB PWMs can control brightness
> of those two signals, as part of that same patch.

OK, let's wait a bit then so these patches can be done directly
against the mainline tree. So not pushing Grazvydas' patch to
l-o at this point.

Regards,

Tony
