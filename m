From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 3/8] MFD: twl4030-audio: Rename platform data
Date: Thu, 2 Jun 2011 09:15:46 +0300
Message-ID: <201106020915.46491.peter.ujfalusi@ti.com>
References: <1306927051-8937-1-git-send-email-peter.ujfalusi@ti.com> <201106011617.14854.peter.ujfalusi@ti.com> <20110601133823.GI11352@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20110601133823.GI11352@atomide.com>
Sender: linux-input-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Girdwood, Liam" <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 01 June 2011 16:38:23 Tony Lindgren wrote:
> But you could easily remove all the board specific struct
> twl4030_codec_data and struct twl4030_codec_audio_data entries by add=
ing a
> default audio init option to omap_pmic_init for the common configurat=
ion.

Yeah, I can grep in the board files, and see what is the most common=20
configuration

> How about something like:
>=20
> void omap_pmic_init(int bus, u32 clkrate, const char *pmic_type, int
> pmic_irq, struct twl4030_platform_data *pmic_data, u32 flags);

common-board-devices.c has omap_pmic_init, but without the flags.

> Where flags would be TWL_BOARD_HAS_DEFAULT_CODEC etc, and if the entr=
y in
> pmic_data is NULL, just use the default configuration. I think you al=
ready
> have the clkrate there?

I'll take a look, should we have new file specifically for twl, or shou=
ld I=20
extend the common-board-devices.c with the twl related things? IMHO a n=
ew file=20
might be better, since the full twl config might be quite big.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
