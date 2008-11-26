From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP general SOC driver.
Date: Wed, 26 Nov 2008 12:33:12 -0800
Message-ID: <200811261233.13259.david-b@pacbell.net>
References: <1227696478-8354-1-git-send-email-stanley.miao@windriver.com> <200811261034.42356.david-b@pacbell.net> <20081126200750.GK6234@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp122.sbc.mail.sp1.yahoo.com ([69.147.64.95]:21178 "HELO
	smtp122.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751585AbYKZUdP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Nov 2008 15:33:15 -0500
In-Reply-To: <20081126200750.GK6234@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, "Stanley.Miao" <stanley.miao@windriver.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On Wednesday 26 November 2008, Mark Brown wrote:
> Can someone post an overview of what the hardware configurations of
> these boards are, please? =A0It's starting to sound like they're not =
very
> similar at all.

I only have schematics for Beagle ... which makes VERY minimal
use of the twl4030 audio capabilities:

 - stereo "headset" output, without its mic
 - stereo aux-in

Other twl4030 family boards *could* have:

 - microphone input for that headset
 - stereo "hands-off" speakers
 - mono earpiece output
 - two other microphone input channels

And maybe more; that's just me summarizing unconnected pins,
not the datasheet.  There are also cost-reduced parts with
less audio capability.

I make no claim about audio expertise -- the nearest I come
to it is observing a few years back that there was a huge
framework hole, which ASoC seems to fill -- but I wonder if
it shouldn't suffice just to provide a mask of capabilities
that are wired up on a given board.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
