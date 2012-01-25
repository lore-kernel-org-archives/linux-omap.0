From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [alsa-devel] [PATCH v4 - resend 00/13] OMAP4: ASoC: Support for
 PandaBoard family
Date: Wed, 25 Jan 2012 13:11:48 +0200
Message-ID: <4F1FE374.1010202@ti.com>
References: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com> <CAJe_Zhfn3urdXfRgAKvdW2_ECYGbNO0b2BuZnCZxrGcL4_sVSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:49522 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751180Ab2AYLLw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Jan 2012 06:11:52 -0500
Received: by mail-lpp01m010-f50.google.com with SMTP id m13so2405921lah.23
        for <linux-omap@vger.kernel.org>; Wed, 25 Jan 2012 03:11:51 -0800 (PST)
In-Reply-To: <CAJe_Zhfn3urdXfRgAKvdW2_ECYGbNO0b2BuZnCZxrGcL4_sVSg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org

On 01/25/2012 12:50 PM, Jassi Brar wrote:
> Hi Peter,
>    I tried the patchset on my 4430 Panda. Playback works ok, but not =
Capture.
> All is get is a hiss.
>   Is capture supposed to work ? If yes, any amixer settings that need
> to be done?

Thanks for testing the series.

I do not have Panda on my own, but the capture depends on Panda version=
:
PandaBoard (4430): You record from HSMIC
PandaBoardES (4460): You record from AFML (line in).

Can you try:
amixer sset 'Analog Left' 'Headset Mic'
amixer sset 'Analog Right' 'Headset Mic'
Or
amixer sset 'Analog Left' 'Aux/FM Left'
amixer sset 'Analog Right' 'Aux/FM Right'

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
