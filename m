From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/7] [RFC] OMAP: MCBSP: hwmod database for
	2xxx devices
Date: Wed, 6 Oct 2010 10:17:13 +0300
Message-ID: <201010061017.13908.peter.ujfalusi@nokia.com>
References: <1286296662-7639-1-git-send-email-kishon@ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CF13384@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030CF13384@dbde02.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext Varadarajan, Charulatha" <charu@ti.com>
Cc: "Girdwood, Liam" <x0135381@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Kamat, Nishant" <nskamat@ti.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "ABRAHAM,
	KISHON VIJAY" <kishon@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
List-Id: linux-omap@vger.kernel.org

Hello,

On Wednesday 06 October 2010 10:01:28 ext Varadarajan, Charulatha wrote:
> This patch series is targeted to implement mcbsp driver in
> hwmod way and to make use of pm_runtime APIs.
> =

> This patch series is tested on OMAP3 & 4 and yet to be tested
> on OMAP2.
> =

> There are few clarifications required so that the next patch series
> can be implemented after aligning.
> =

> 1. Audio layer is making use of mcbsp and it's dma base addresses and
> is closely coupled with omap-mcbsp.
> This can be handled either by
> a. providing an API with which Audio layer can get these addresses.
> (or)
> b. move the plat-omap/mcbsp.c and mach-omap2/mcbsp.c to sound/soc/omap/
> [1]
> =

> Option (a) would only be a workaround to handle the situation. As
> audio is the only user for mcbsp, option (b) is better. If option(b)
> is agreed upon, the same can be addressed on top of the mcbsp hwmod
> series.

it is true that at the moment only audio is using the McBSP ports, but McBS=
P is =

really flexible, it can run for example in SPI mode, and it can be configur=
ed to =

use other serial protocols.
I would go with option c.
Since ASoC is moving to multi-component (the conversion is already in linux-
next), this means that the sound/soc/omap/omap-mcbsp, omap-pcm drivers are =

platform drivers.
So if the plat-omap/mcbsp would register the platform device for McBSP clie=
nts =

(we have only ASoC client at the moment), and use platform data to pass the =

needed information to the McBSP client driver, than we do not need new API.
We still need to modify the ASoC drivers to make use of this platform data,=
 but =

at least we are going to keep the door open for others to use the McBSP por=
ts =

for other than audio.

> 2. Sidetone feature is available only in OMAP3 (McBSP2&3) which has
> different base address and sys configs compared to it's mcbsp port.
> Hence the mcbsp is considered as a single device with two hwmods
> for McBSP2&3 devices in OMAP3.

Sounds fair enough.
 =

> 3. Autoidle needs to be disabled for sidetone before enabling the sidetone
> feature. There was a design proposed by Kishon [2] to add an API in hwmod
> to modify the autoidle bit but was not agreed upon. How do we handle this
> situation where the device has to disable or enable the autoidle bit at
> runtime?

Yeah, this is really annoying problem. The McBSP ST should block autoidle f=
rom =

McBSP side, but it does not.
If you can not get through the proposed API, we should consider to switch t=
he =

corresponding McBSP port to NoIdle, when the ST is in use (and restore the =
idle =

mode, when the ST has been disabled).
When McBSP is in NoIdle the interface clock is not going to be gated, so ST =

block will be running without a problem (ST needs the iface clock for opera=
tion)

What do you think?
> =

> [1] https://patchwork.kernel.org/patch/225582/
> [2] https://patchwork.kernel.org/patch/134371/
> =

> We would resend the same patch series by including alsa mailing list
> (alsa-devel@alsa-project.org)
> =

> <<snip>>

-- =

P=E9ter
