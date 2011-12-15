From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Re: Re: Re: [PATCH 06/10] ASoC: omap-abe-twl6040: Convert to platform deriver
Date: Thu, 15 Dec 2011 15:01:05 +0200
Message-ID: <1342606.MORk9WEnkg@barack>
References: <1323856022-24053-1-git-send-email-peter.ujfalusi@ti.com> <20111214112710.GI3072@opensource.wolfsonmicro.com> <5238231.U46jV2XvpL@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:39491 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751089Ab1LONBK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Dec 2011 08:01:10 -0500
Received: by mail-lpp01m010-f51.google.com with SMTP id o2so1205363lag.24
        for <linux-omap@vger.kernel.org>; Thu, 15 Dec 2011 05:01:09 -0800 (PST)
In-Reply-To: <5238231.U46jV2XvpL@barack>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On Thursday 15 December 2011 10:17:38 P=E9ter Ujfalusi wrote:
> Hi Mark,
>=20
> On Wednesday 14 December 2011 19:27:11 Mark Brown wrote:
> > This seems like we need a better system for doing this, we can't go
> > changing the machine name every time there's a kernel space change =
that
> > affects a UCM file, that's going to get crazy.

We can handle the different features on the card with the same name wit=
h UCM=20
fine, so I will not change the name of the card.
Will be fixed for v2.

--
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
