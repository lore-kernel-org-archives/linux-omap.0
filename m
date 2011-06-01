From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 3/8] MFD: twl4030-audio: Rename platform
	data
Date: Wed, 1 Jun 2011 16:17:14 +0300
Message-ID: <201106011617.14854.peter.ujfalusi@ti.com>
References: <1306927051-8937-1-git-send-email-peter.ujfalusi@ti.com>
	<201106011554.53090.peter.ujfalusi@ti.com>
	<20110601130034.GE11352@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20110601130034.GE11352@atomide.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wednesday 01 June 2011 16:00:34 Tony Lindgren wrote:
> Yeah, most of it might be possible to describe with just a flags
> like TWL_HAS_VIBRA etc.

Or TWL_BOARD_HAS_VIBRA, TWL_BOARD_HAS_CODEC...

For the audio part it is a bit complicated than that:
different base frequencies, for twl6040 we have parameters for Vibra (twl40=
30 =

class only have the coexistence). The soc codec has a list of misc paramete=
rs =

for board specific configurations as well (not all board using them).
I was thinking to switch the MFD driver(s) to use flags to specify the need=
ed =

child, and change the child drivers to deal with the missing platform data =

themselves.
In that way, board files can pass the vibra/codec platform data to the new =

i2c_twl file for example, and provide flags to enable functionality.

> > I'll take a look, but I think it is not going to be part of v2 of this
> > series.
> =

> We should not do renaming before the clean-up though, it gets
> classified as "unnecesary churn".

The changes in board files are minimal. The biggest part is the code move, =
and =

that will remain the same now or later...

-- =

P=E9ter
