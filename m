From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] Can a phone hook switch follow alsa jack model?
Date: Mon, 29 Jun 2009 15:32:15 +0100
Message-ID: <20090629143215.GA23835@rakim.wolfsonmicro.main>
References: <4A40D896.8010208@tis.icnet.pl>
 <20090623222255.GA5617@sirena.org.uk>
 <4A4229EB.2090606@tis.icnet.pl>
 <20090625110508.GF17812@sirena.org.uk>
 <4A437226.4090202@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:41422 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753170AbZF2OcQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Jun 2009 10:32:16 -0400
Content-Disposition: inline
In-Reply-To: <4A437226.4090202@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Jonathan McDowell <noodles@earth.li>, alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org

On Thu, Jun 25, 2009 at 02:48:38PM +0200, Janusz Krzysztofik wrote:

> During my previous, gpio-keys based attempt, I submitted a patch
> that added new SW_HANDSET_PICK_UP event definition to
> include/linux/input.h. Even if not accepted because of no

Something like hook switch would be a more common name - the switch is
closed when the phone is on hook.

> comments, especially on the name I have choosen. However, there were
> another name proposed by ams-delta board maintainer, Jonathan
> McDowell - SW_PHONE_HOOK. Even if my wording may better match those
> already existing ..._INSERT names, I am not sure which one should I
> use.

The _INSERT isn't at all appropriate since there's nothing being
inserted here - the _INSERT names refer to the fact that something is
being plugged in to a jack.

> Please also note that SND_JACK_HEADSET, that I temporarily use for
> now, is an alias for SND_JACK_HEADPHONE | SND_JACK_MICROPHONE. Those
> two can be seen as matching what a handset actually is. On headset
> jack insert/remove, two distinct reports/events are generated, one

OTOH a phone going on hook tends to mean something rather different in
UI terms to having something plugged into a jack - it's part of the
normal flow of making a phone call.
