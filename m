From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 3/8] MFD: twl4030-audio: Rename platform data
Date: Wed, 1 Jun 2011 15:54:52 +0300
Message-ID: <201106011554.53090.peter.ujfalusi@ti.com>
References: <1306927051-8937-1-git-send-email-peter.ujfalusi@ti.com> <1306927051-8937-4-git-send-email-peter.ujfalusi@ti.com> <20110601120754.GC11352@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20110601120754.GC11352@atomide.com>
Sender: linux-input-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Girdwood, Liam" <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 01 June 2011 15:07:54 Tony Lindgren wrote:
>=20
> Can you please take a look at creating arch/arm/mach-omap2/i2c-twl.c =
or
> something in common-board-devices.c to get rid of the cut and paste
> duplication in every board-*.c file?

Yes, it would make sense, since most of the board has similar configura=
tion,=20
and we have lots of duplicated code around.
=20
> Maybe you could have a generic twl_init function that allows overridi=
ng
> things like keypad with board specific configuration?

We might need also support for overriding other configurations=20
(audio/codec/vibra for sure needs that).

I'll take a look, but I think it is not going to be part of v2 of this =
series.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
