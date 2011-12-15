From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Re: [PATCH 04/10] include: platform_data: Platform data header for OMAP4 ASoC audio
Date: Thu, 15 Dec 2011 15:02:44 +0200
Message-ID: <3652535.KtFJC1aH5Z@barack>
References: <1323856022-24053-1-git-send-email-peter.ujfalusi@ti.com> <1323856022-24053-5-git-send-email-peter.ujfalusi@ti.com> <20111214095745.GD3072@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:41859 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751089Ab1LONCt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Dec 2011 08:02:49 -0500
Received: by lags15 with SMTP id s15so1304330lag.18
        for <linux-omap@vger.kernel.org>; Thu, 15 Dec 2011 05:02:46 -0800 (PST)
In-Reply-To: <20111214095745.GD3072@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On Wednesday 14 December 2011 17:57:47 Mark Brown wrote:
> On Wed, Dec 14, 2011 at 11:46:57AM +0200, Peter Ujfalusi wrote:
> > +enum board_type {
> > +	OMAP_ABE_TWL6040_SDP4430,
> > +	OMAP_ABE_TWL6040_PANDA,
> > +	OMAP_ABE_TWL6040_PANDA_ES,
> > +};
>=20
> It seems like it might better in the long run to make this feature ba=
sed
> rather than enumerating the individual boards - that means that if
> boards mix and match the features or add features on the side of
> additional designs (eg, external amplifiers that need power control)
> it's easier to scale the options.

Yes this is planed for the Dtree support, but the aim here is to get wo=
rking=20
audio on PandaBoard as well with upstream kernel.

--
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
