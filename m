From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [alsa-devel] [PATCH v4 - resend 00/13] OMAP4: ASoC: Support for
 PandaBoard family
Date: Wed, 25 Jan 2012 16:20:31 +0530
Message-ID: <CAJe_Zhfn3urdXfRgAKvdW2_ECYGbNO0b2BuZnCZxrGcL4_sVSg@mail.gmail.com>
References: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:41806 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151Ab2AYKud (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jan 2012 05:50:33 -0500
Received: by werb13 with SMTP id b13so3671412wer.19
        for <linux-omap@vger.kernel.org>; Wed, 25 Jan 2012 02:50:32 -0800 (PST)
In-Reply-To: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org

On 24 January 2012 17:22, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> Hello,
>
> the following series will add ASoC support for PandaBoards.
> PandaBoards have different audio routings compared to SDP4430/Blaze boards, but
> the differences not that big to justify a new ASoC machine driver.
>
> The v3 series did not made it to 3.3 kernel.
> This set contains all the patches needed to enable the audio support on the
> PandaBoard family.
> The machine driver has been converted to a generic OMAP4 driver which can
> support wide range of machines using OMAP4 with twl6040 codec.
>
> I have remove the hardcoded MCLK clock frequency use in the machine driver
> (there can be devices with different MCLK configuration). This changed
> patch 04, 05, and 12. Since this does not affect the functionality I kept the
> acks for these patches. Patch 11 did not existed in the v3 series.
>
Hi Peter,
   I tried the patchset on my 4430 Panda. Playback works ok, but not Capture.
All is get is a hiss.
  Is capture supposed to work ? If yes, any amixer settings that need
to be done?

Thanks,
-Jassi
