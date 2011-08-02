From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/3] mfd: twl6040: Add initial support
Date: Tue, 2 Aug 2011 14:32:48 +0300
Message-ID: <1643706.AtbiBJoBSQ@barack>
References: <1312284526-1656-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1312284526-1656-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "Sebastien@alsa-project.org" <Sebastien@alsa-project.org>, "Cousson,
	Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Misael@alsa-project.org" <Misael@alsa-project.org>, "Guiriec,
	Sebastien" <s-guiriec@ti.com>, "Lopez Cruz, Misael" <misael.lopez@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>
List-Id: linux-omap@vger.kernel.org

Oops...

On Tuesday 02 August 2011 13:28:41 Ujfalusi, Peter wrote:
> From: Misael Lopez Cruz <misael.lopez@ti.com>
> =

> TWL6040 IC provides analog high-end audio codec functions for
> handset applications. It contains several audio analog inputs
> and outputs as well as vibrator support. It's connected to the
> host processor via PDM interface for audio data communication.
> The audio modules are controlled by internal registers that
> can be accessed by I2C and PDM interface.
> =

> TWL6040 MFD will be registered as a child of TWL-CORE, and will
> have two children of its own: twl6040-codec and twl6040-vibra.
> =

> This driver is based on TWL4030 and WM8350 MFD drivers.

I have sent the patches from wrong directory :(
Please disregard this series, this has been already merged...

Sorry!

--
P=E9ter
