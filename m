From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v4 - resend 10/13] ASoC: omap-abe-twl6040: Configure card
 according to platform data
Date: Wed, 25 Jan 2012 14:48:08 +0200
Message-ID: <4F1FFA08.1030505@ti.com>
References: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com> <1327405950-6676-11-git-send-email-peter.ujfalusi@ti.com> <20120124130008.GC31839@opensource.wolfsonmicro.com> <4F1FBBE5.5080804@ti.com> <20120125113341.GB3687@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:37973 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752077Ab2AYMsO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Jan 2012 07:48:14 -0500
Received: by lahl5 with SMTP id l5so1194851lah.31
        for <linux-omap@vger.kernel.org>; Wed, 25 Jan 2012 04:48:11 -0800 (PST)
In-Reply-To: <20120125113341.GB3687@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 01/25/2012 01:33 PM, Mark Brown wrote:
> It'd do the right thing if you changed the code to only register the
> board widgets and routes as required - from your reply to Jassi it lo=
oks
> like you ought to do conditional reigstration anyway as the input pat=
hs
> move around between board variations.

I'm planning to do similar thing as an increment on top of this series.
Most likely the DT support will have conditional registration or - like
Tegra does - we will receive the map from DT. Not sure yet which way it
is going to be. The Tegra implementation is already there, so I might
just follow it.
At the end I want to have some consistency between the resulting sound
cards (w/ DT, w/o DT).

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
