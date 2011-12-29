From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH 0/4] OMAPDSS/ASoC: Repair broken HDMI audio in K3.2-rcX
Date: Thu, 29 Dec 2011 15:26:48 +0530
Message-ID: <CAP5A+B8ZPMBROeu6wkT8G5v_e1jhYTNrCATP0mi71wcsC2DZHg@mail.gmail.com>
References: <1324018993-31466-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:56936 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751980Ab1L2J5K convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Dec 2011 04:57:10 -0500
Received: by mail-iy0-f176.google.com with SMTP id p10so31715304iap.35
        for <linux-omap@vger.kernel.org>; Thu, 29 Dec 2011 01:57:09 -0800 (PST)
In-Reply-To: <1324018993-31466-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com

Hi Ricardo,

On Fri, Dec 16, 2011 at 12:33 PM, Ricardo Neri <ricardo.neri@ti.com> wr=
ote:
> It has been detected that HDMI audio is broken in K3.2-rcX due to
> the most recent updates in the DSS. This set of patches aims to repai=
r such
> break. It also improves the implementation of the ASoC codec to bette=
r follow
> the DSS design by clearly separating functions that need acess to IP-
> specific data.
>

We could not also try to move the ASoC HDMI audio codec driver from
DSS to sound, but this is good for now.
Acked-by: Mythri P K <mythripk@ti.com>

Thanks and regards,
Mythri.

> This set of patches is based on
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git =
v3.2-rc5
>
> and is available at
> git://gitorious.org/omap-audio/linux-audio.git ricardon/topic/fix-hdm=
i-audio-3.2
>
> Validation was performed on HDMI TV. Penguins were present on the dis=
play
> and audio playback was performed with aplay at 32, 44.1 and 48kHz wit=
h S16_LE
> and S24_LE sample formats. Validation was performed on SDP4430 ES2.2.
>
> Ricardo Neri (4):
> =A0ASoC: OMAP: HDMI: Introduce driver data for audio codec
> =A0ASoC: OMAP: HDMI: Correct signature of ASoC functions
> =A0OMAPDSS: HDMI: Create function to enable HDMI audio
> =A0ASoC: OMAP: HDMI: Move HDMI codec trigger function to generic HDMI
> =A0 =A0driver
>
> =A0drivers/video/omap2/dss/dss_features.c =A0 =A0| =A0 =A04 ++
> =A0drivers/video/omap2/dss/hdmi.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 46 +++=
++++++++++++++++++++++++-
> =A0drivers/video/omap2/dss/ti_hdmi.h =A0 =A0 =A0 =A0 | =A0 10 +++++-
> =A0drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c | =A0 37 ++++-----------=
--------
> =A0drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h | =A0 =A03 --
> =A05 files changed, 64 insertions(+), 36 deletions(-)
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
