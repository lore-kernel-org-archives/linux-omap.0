From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/2] Add support for GPIO LEDs on pandora
Date: Thu, 8 Jan 2009 12:04:09 -0800
Message-ID: <200901081204.10441.david-b@pacbell.net>
References: <1227780163-5879-1-git-send-email-notasas@gmail.com> <20090108152818.GE25876@sirena.org.uk> <6ed0b2680901080829p740cf017y2f5dd0d59f025743@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:42573 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755878AbZAHUEM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2009 15:04:12 -0500
In-Reply-To: <6ed0b2680901080829p740cf017y2f5dd0d59f025743@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Mark Brown <broonie@sirena.org.uk>, Koen Kooi <k.kooi@student.utwente.nl>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Richard Purdie <rpurdie@rpsys.net>

On Thursday 08 January 2009, Grazvydas Ignotas wrote:
> Well this was only temporary solution until we have proper code to
> control BL using TWL4030's PWM capability.

I have code to support the PWM0/PWM1 signals that needs testing,
so that's not far away.  The LEDA/LEDB PWMs can control brightness
of those two signals, as part of that same patch.

- Dave

