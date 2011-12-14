From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Re: [PATCH 06/10] ASoC: omap-abe-twl6040: Convert to platform
 deriver
Date: Wed, 14 Dec 2011 19:27:11 +0800
Message-ID: <20111214112710.GI3072@opensource.wolfsonmicro.com>
References: <1323856022-24053-1-git-send-email-peter.ujfalusi@ti.com>
 <1323856022-24053-7-git-send-email-peter.ujfalusi@ti.com>
 <20111214100059.GE3072@opensource.wolfsonmicro.com>
 <9071441.mIl0uoLWiD@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:48205 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754462Ab1LNL1R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Dec 2011 06:27:17 -0500
Content-Disposition: inline
In-Reply-To: <9071441.mIl0uoLWiD@barack>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On Wed, Dec 14, 2011 at 12:15:58PM +0200, P=E9ter Ujfalusi wrote:
> On Wednesday 14 December 2011 18:01:00 Mark Brown wrote:

> > Why?  The board appaers to be generally known as SDP4430...

> At the moment we do not have users using the audio on top of the upst=
ream=20
> kernel. All distributions are using patched kernel with ABE support.
> In there the audio card is know as SDP4430, and we have the UCM profi=
le for=20
> the ABE version of the OMAP4 boards there which will not work on the =
upstream=20
> kernel since we do not have yet the ABE in mainline kernel.
> My plan is to add the UCM files for the upstream version of the drive=
r which=20
> will be updated as soon we got new features (like the ABE support). I=
t is=20
> easier for distros also to move, when time comes to the new kernel.

This seems like we need a better system for doing this, we can't go
changing the machine name every time there's a kernel space change that
affects a UCM file, that's going to get crazy.  Not quite sure what the
best approach is here - version specific directories perhaps, or some
method of keying off the presence of certain controls.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
