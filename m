From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 2/4 v2] OMAP: Configure audio_mclk for
	twl4030-codec MFD
Date: Mon, 9 Nov 2009 09:46:46 +0200
Message-ID: <200911090946.46576.peter.ujfalusi@nokia.com>
References: <1257321500-27049-1-git-send-email-peter.ujfalusi@nokia.com>
	<1257321500-27049-2-git-send-email-peter.ujfalusi@nokia.com>
	<1257321500-27049-3-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1257321500-27049-3-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, "tony@atomide.com" <tony@atomide.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

Hello Tony,

On Wednesday 04 November 2009 09:58:18 Ujfalusi Peter (Nokia-D/Tampere) wro=
te:
> audio_mclk value is going to be handled by the
> twl4030-codec MFD driver, configure the correct
> value for boards, which is using the twl4030 audio.
> =

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---
>  arch/arm/mach-omap2/board-3430sdp.c      |    1 +
>  arch/arm/mach-omap2/board-omap3beagle.c  |    1 +
>  arch/arm/mach-omap2/board-omap3evm.c     |    1 +
>  arch/arm/mach-omap2/board-omap3pandora.c |    1 +
>  arch/arm/mach-omap2/board-overo.c        |    1 +
>  arch/arm/mach-omap2/board-zoom2.c        |    1 +
>  6 files changed, 6 insertions(+), 0 deletions(-)
> =

> diff --git a/arch/arm/mach-omap2/board-3430sdp.c
>  b/arch/arm/mach-omap2/board-3430sdp.c index 4f91f7a..9afd957 100644
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -415,6 +415,7 @@ static struct twl4030_codec_audio_data sdp3430_audio =
=3D
>  { };
> =

>  static struct twl4030_codec_data sdp3430_codec =3D {
> +	.audio_mclk =3D 26000000,
>  	.audio =3D &sdp3430_audio,
>  };
> =

> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c
>  b/arch/arm/mach-omap2/board-omap3beagle.c index 2161d85..8f0c106 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -259,6 +259,7 @@ static struct twl4030_codec_audio_data
>  beagle_audio_data =3D { };
> =

>  static struct twl4030_codec_data beagle_codec_data =3D {
> +	.audio_mclk =3D 26000000,
>  	.audio =3D &beagle_audio_data,
>  };
> =

> diff --git a/arch/arm/mach-omap2/board-omap3evm.c
>  b/arch/arm/mach-omap2/board-omap3evm.c index d9a6103..5bb30cb 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -199,6 +199,7 @@ static struct twl4030_codec_audio_data
>  omap3evm_audio_data =3D { };
> =

>  static struct twl4030_codec_data omap3evm_codec_data =3D {
> +	.audio_mclk =3D 26000000,
>  	.audio =3D &omap3evm_audio_data,
>  };
> =

> diff --git a/arch/arm/mach-omap2/board-omap3pandora.c
>  b/arch/arm/mach-omap2/board-omap3pandora.c index 5036b56..77790ee 100644
> --- a/arch/arm/mach-omap2/board-omap3pandora.c
> +++ b/arch/arm/mach-omap2/board-omap3pandora.c
> @@ -286,6 +286,7 @@ static struct twl4030_codec_audio_data
>  omap3pandora_audio_data =3D { };
> =

>  static struct twl4030_codec_data omap3pandora_codec_data =3D {
> +	.audio_mclk =3D 26000000,
>  	.audio =3D &omap3pandora_audio_data,
>  };
> =

> diff --git a/arch/arm/mach-omap2/board-overo.c
>  b/arch/arm/mach-omap2/board-overo.c index dc55008..e1fb504 100644
> --- a/arch/arm/mach-omap2/board-overo.c
> +++ b/arch/arm/mach-omap2/board-overo.c
> @@ -334,6 +334,7 @@ static struct twl4030_codec_audio_data overo_audio_da=
ta
>  =3D { };
> =

>  static struct twl4030_codec_data overo_codec_data =3D {
> +	.audio_mclk =3D 26000000,
>  	.audio =3D &overo_audio_data,
>  };
> =

> diff --git a/arch/arm/mach-omap2/board-zoom2.c
>  b/arch/arm/mach-omap2/board-zoom2.c index f1b4e7c..de3a38d 100644
> --- a/arch/arm/mach-omap2/board-zoom2.c
> +++ b/arch/arm/mach-omap2/board-zoom2.c
> @@ -234,6 +234,7 @@ static struct twl4030_codec_audio_data zoom2_audio_da=
ta
>  =3D { };
> =

>  static struct twl4030_codec_data zoom2_codec_data =3D {
> +	.audio_mclk =3D 26000000,
>  	.audio =3D &zoom2_audio_data,
>  };
> =

> --
> 1.6.5.2

Can you take a look at this patch?
The rest of the series has already got Ack from Samuel and Mark, and only y=
our =

verdict for the OMAP part is missing.

Thank you, =

P=E9ter
