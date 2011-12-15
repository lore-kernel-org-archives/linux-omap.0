From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Re: Re: [PATCH 06/10] ASoC: omap-abe-twl6040: Convert to platform deriver
Date: Thu, 15 Dec 2011 10:17:38 +0200
Message-ID: <5238231.U46jV2XvpL@barack>
References: <1323856022-24053-1-git-send-email-peter.ujfalusi@ti.com> <9071441.mIl0uoLWiD@barack> <20111214112710.GI3072@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:55737 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756067Ab1LOIRm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Dec 2011 03:17:42 -0500
Received: by mail-lpp01m010-f47.google.com with SMTP id i14so1189317lam.34
        for <linux-omap@vger.kernel.org>; Thu, 15 Dec 2011 00:17:41 -0800 (PST)
In-Reply-To: <20111214112710.GI3072@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

Hi Mark,

On Wednesday 14 December 2011 19:27:11 Mark Brown wrote:
> This seems like we need a better system for doing this, we can't go
> changing the machine name every time there's a kernel space change th=
at
> affects a UCM file, that's going to get crazy.

As of know we do not have UCM for the driver in upstream. In fact it is=
 not=20
recommended at the moment to use the upstream driver since we do not ha=
ve the=20
ABE/dynamic PCM upstream.
There are UCM files shipped with distributions (like Linaro, ubuntu), b=
ut=20
those UCM files will not work with the upstream kernel (due to the miss=
ing=20
parts).
It can be also confusing to have the same card name for fundamentally=20
different sound cards.
We do support the kernel shipped with distributions (with patched up AS=
oC),=20
but we also need to support clean upstream version. Having to deal with=
=20
mismatching UCM files does not really help here.

I have not planned to change the card names in the future.

Having said that I can revert back to use the names used by Linaro for =
example=20
(even if the cards are different):
SPD4430/Panda/PandaES

If I write the UCM file it will be for the vanilla upstream sound, so w=
e will=20
have UCM files upstream, which does not work on the Distributions - I t=
hink=20
this is even more confusing than having different card names initially =
untill=20
we get everything upstream.

--
P=E9ter

PS:
Liam: what is your take on this?

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
