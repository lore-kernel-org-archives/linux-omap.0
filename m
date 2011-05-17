From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 0/5] OMAP4: DSS2: HDMI: Add support for audio
Date: Tue, 17 May 2011 13:00:17 -0500
Message-ID: <1305655217.1883.51.camel@dexx0075479.dextra-mty.naucm.ext.ti.com>
References: <1304578894-23967-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52158 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755924Ab1EQSBl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 May 2011 14:01:41 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4HI1fNE024456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 17 May 2011 13:01:41 -0500
In-Reply-To: <1304578894-23967-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "K, Mythri P" <mythripk@ti.com>

Hi,

I would like to solicit comments on this set of patches. Now that ASoC
part of the implementation has been Ack'ed by ASoC maintainers, these
patches are needed.

Thanks!

Ricardo

Le jeudi 05 mai 2011 =C3=A0 02:01 -0500, Neri, Ricardo a =C3=A9crit :
> This is to add support for HDMI audio on OMAP4 chips. This work has t=
wo
> parts: DSS implementation and ASoC implementation. This set of patche=
s
> presents the DSS implementation. The approach is to utilize the DSS
> HDMI driver to act as an ASoC codec. Then, functionality and data
> structures are added to the DSS HDMI driver to configure parameters
> relevant to audio such as sample rate and frequency and DMA.
> The ASoC implementation adds an HDMI audio card that will utilize thi=
s
> HDMI ASoC codec. The ASoC implementation is also under review in the
> alsa-devel list.
>=20
> This implementation is for Basic Audio as defined in CEA-861-D: 16 bi=
t/sample
> linear PCM 2-channel audio with sample rates of 32, 44.1 and 48kHz. A=
s
> described in the HDMI specification, support for Basic Audio is manda=
tory
> for HDMI sinks and does not require of EDID parsing.
>=20
> Additionally, this implementation supports 24-bit samples in 32-bit w=
ords.
> Further audio capabilities such as more sample rates and multichannel=
 audio
> will be added in the future when EDID parsing is available for HDMI d=
river.
>=20
> This implementation is based on on:
> * OMAP4: DSS2: Add dss_dss_clk opt clock for OMAP4, by Sumit Semwal
>  (http://gitorious.org/linux-omap-dss2/linux/commit/0da5637569bb9bf93=
e6930cd1c3b452eede50ba2)
> * Kernel 2.6.39-rc6
>  (git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.gi=
t v2.6.39-rc6)
>=20
> In order to validate functionality, it is necessary to utilize the AS=
oC
> HDMI CPU and machine drivers for HDMI on OMAP4. The complete implemen=
tation,
> DSS and ASoC parts, is available at:
>  git://gitorious.org/omap-audio/linux-audio.git ricardon/topic/hdmi-a=
udio-v1
>=20
> Verification: Penguins on HDMI display with audio playback with sampl=
e
> rates of 32, 44.1 and 48kHz and 16-bit and 24-bit (in 32-bit word) sa=
mple
> format. Audio playback verified using ALSA aplay. Validation was perf=
ormed on
> SDP4430 ES2.1 and Panda ES2.1 and ES2.0.
>=20
> Ricardo Neri (5):
>   OMAP4: DSS2: Create a DSS features structure for OMAP4430 ES1.0
>   OMAP4: DSS2: HDMI: Add DSS feature for CTS calculation
>   OMAP4: DSS2: HDMI: Add enums and structures for audio
>   OMAP4: DSS2: HDMI: Add functionality for audio configuration
>   OMAP4: DSS2: HDMI: Implement ASoC Codec driver for HDMI audio
>=20
>  drivers/video/omap2/dss/dss_features.c |   29 ++-
>  drivers/video/omap2/dss/dss_features.h |    1 +
>  drivers/video/omap2/dss/hdmi.c         |  432 ++++++++++++++++++++++=
++++++++++
>  drivers/video/omap2/dss/hdmi.h         |  220 ++++++++++++++++-
>  4 files changed, 678 insertions(+), 4 deletions(-)
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
