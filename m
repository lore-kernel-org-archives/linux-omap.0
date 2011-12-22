From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 0/9] OMAP4: ASoC: Support for PandaBoard family
Date: Thu, 22 Dec 2011 19:30:28 +0200
Message-ID: <4EF36934.5010709@ti.com>
References: <1324571902-16918-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:45028 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753157Ab1LVRa1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Dec 2011 12:30:27 -0500
Received: by lahj13 with SMTP id j13so2924147lah.25
        for <linux-omap@vger.kernel.org>; Thu, 22 Dec 2011 09:30:24 -0800 (PST)
In-Reply-To: <1324571902-16918-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 12/22/2011 06:38 PM, Peter Ujfalusi wrote:
> Hello,
>=20
> the following series will add ASoC support for PandaBoards.
> PandaBoards have different audio routings compared to SDP4430/Blaze b=
oards, but
> the differences not that big to justify a new ASoC machine driver.
>=20
> This series is based on the first three patch from the v1 sereis (tho=
se, which
> has been applied by Liam).
>=20
> Changes since v1:
> As suggested by Mark the platform data, machine driver has been conve=
rted to
> process feature flags instead of Board IDs.
> - The ASoC machine driver registers all DAPM widgets. Based on the re=
ceived
>   configuration it will disable the unused paths
> - PCM for dmic is only created, if the board has digital mic conencte=
d
> - Jack functionality will be only used on boards supporting it
> - Sound card name for SDP4430 has net been changed

Sorry for the resend, I did ment to send another series, but I ended up
in a wrong directory before I run git-send-email.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
