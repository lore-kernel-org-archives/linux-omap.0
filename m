From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Re: [PATCH 06/10] ASoC: omap-abe-twl6040: Convert to platform deriver
Date: Wed, 14 Dec 2011 12:15:58 +0200
Message-ID: <9071441.mIl0uoLWiD@barack>
References: <1323856022-24053-1-git-send-email-peter.ujfalusi@ti.com> <1323856022-24053-7-git-send-email-peter.ujfalusi@ti.com> <20111214100059.GE3072@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:40176 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753611Ab1LNKQG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Dec 2011 05:16:06 -0500
Received: by lami14 with SMTP id i14so239660lam.20
        for <linux-omap@vger.kernel.org>; Wed, 14 Dec 2011 02:16:02 -0800 (PST)
In-Reply-To: <20111214100059.GE3072@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On Wednesday 14 December 2011 18:01:00 Mark Brown wrote:
> On Wed, Dec 14, 2011 at 11:46:59AM +0200, Peter Ujfalusi wrote:
> > The card's name for OMAP4 SDP4430 has been changed:
> > SDP4430 -> OMAP4-SDP4430
>=20
> Why?  The board appaers to be generally known as SDP4430...

At the moment we do not have users using the audio on top of the upstre=
am=20
kernel. All distributions are using patched kernel with ABE support.
In there the audio card is know as SDP4430, and we have the UCM profile=
 for=20
the ABE version of the OMAP4 boards there which will not work on the up=
stream=20
kernel since we do not have yet the ABE in mainline kernel.
My plan is to add the UCM files for the upstream version of the driver =
which=20
will be updated as soon we got new features (like the ABE support). It =
is=20
easier for distros also to move, when time comes to the new kernel.

--
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
