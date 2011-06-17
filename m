From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v4 00/18] MFD/ASoC/Input: TWL4030/TWL60X0
	changes
Date: Fri, 17 Jun 2011 13:06:19 +0300
Message-ID: <5715729.tcDIHNc8b8@barack>
References: <1307706876-4768-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1307706876-4768-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Girdwood, Liam" <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hello Tony, Samuel, Mark, Liam.

Did you got time to check the patches for your areas?
I want to send the updated series with the change in the vibra driver =

(addressing comments from Dmitry, and Tejun), but I want to address your =

comments as well at the same time if any (or add you Ack).

Thank you,
P=E9ter


On Friday 10 June 2011 13:54:18 Ujfalusi, Peter wrote:
> Hello,
> =

> Changes since v3:
> - patches generated with git format-patch -M to handle renames better
> - Included depending updates for twl6040 soc codec driver:
>  - HS ramp configuration, new ABE dais, updated sample rate constraints
> - Configure the twl6040 codec on SDP4430 board
> =

> Updated intro message from the v3 series:
> The series will do five major things, and they are in one series, because
> they pretty much depending on each other, so it is easier to handle them
> together.
> =

> 1. Move the common pmic related configurations out from the board files.
> New twl-common.c/h file has been created for this purpose.
> OMAP3 board files received two patches (pdata, and regualtor changes), OM=
AP4
> board files has been changed with one patch.
> =

> 2. Rename the twl4030-codec MFD driver to twl4030-audio
> Since the ASoC multicomponent introduction (2.6.37) the twl4030-codec MFD
> dirver had been using twl4030-audio to register (twl4030-codec is the ASoC
> codec driver). The documentation refers to this part of twl as audio bloc=
k,
> so it is better to rename the driver as well to avoid confusion.
> =

> 3. Introduction of MFD driver for twl6040.
> The TWL6040 audio IC has codec and vibra functionality.
> Convert the existing ASoC codec driver to use the new MFD driver's
> interface.
> =

> 4. Vibrator driver for TWL6040 (Input/ForceFeedback driver)
> The driver itself, and support for the vibrators in SDP4430 board.
> =

> 5. Updates for twl6040 ASoC codec driver
> HS ramp configuration, new ABE dais, updated sample rate constraints,
> SDP4430 configuration.
> =

> Regards,
> Peter
