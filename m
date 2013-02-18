From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH V2] ARM: dts: omap3-devkit8000: Enable
	audio support
Date: Mon, 18 Feb 2013 12:20:24 +0100
Message-ID: <51220E78.5000409@ti.com>
References: <1361000036-18121-1-git-send-email-anilk4.v@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1361000036-18121-1-git-send-email-anilk4.v@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anil Kumar <anilk4.v@gmail.com>
Cc: alsa-devel@alsa-project.org, linux@arm.linux.org.uk, b-cousson@ti.com, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, thomas@tomweber.eu
List-Id: linux-omap@vger.kernel.org

On 02/16/2013 08:33 AM, Anil Kumar wrote:
> Add the needed sections to enable audio support on
> Devkit8000 when booted with DT blob.
> =

> Signed-off-by: Anil Kumar <anilk4.v@gmail.com>

Looks good:
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
> This patch is based on top of kernel 3.8-rc5 and
> the following patches.
> =

> Peter Ujfalusi:-
> ASoC: twl4030: Correct the support for Voice port
> ASoC: twl4030: Convert MICBIAS to SUPPLY widget
> ASoC: omap-twl4030: Add support for routing, voice port and jack detect
> =

> Anil Kumar:-
> ARM: dts: add minimal DT support for DevKit8000
> https://patchwork.kernel.org/patch/2122461/
> =

> -Tested for playback and capture on Devkit8000.
> =

>  Test process:-
> =

>  #amixer set 'PredriveR Mixer AudioR2' on
>  #amixer set 'PredriveL Mixer AudioL2' on
>  #amixer set PreDriv 100 unmute
>  #amixer set 'DAC2 Digital Fine' 100
>  #amixer cset numid=3D27 1
>  #arecord | aplay
> =

> For V2:
>  - Remove pin mux as done at device boot time by default.
> =

> :100644 100644 6338993... c70116f... M	arch/arm/boot/dts/omap3-devkit8000=
.dts
>  arch/arm/boot/dts/omap3-devkit8000.dts |   23 +++++++++++++++++++----
>  1 files changed, 19 insertions(+), 4 deletions(-)
> =

> diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts b/arch/arm/boot/dts/o=
map3-devkit8000.dts
> index 6338993..c70116f 100644
> --- a/arch/arm/boot/dts/omap3-devkit8000.dts
> +++ b/arch/arm/boot/dts/omap3-devkit8000.dts
> @@ -42,6 +42,19 @@
>                  };
>  =

>  	};
> +
> +	sound {
> +		compatible =3D "ti,omap-twl4030";
> +		ti,model =3D "devkit8000";
> +
> +		ti,mcbsp =3D <&mcbsp2>;
> +		ti,codec =3D <&twl_audio>;
> +		ti,audio-routing =3D
> +			"Ext Spk", "PREDRIVEL",
> +			"Ext Spk", "PREDRIVER",
> +			"MAINMIC", "Main Mic",
> +			"Main Mic", "Mic Bias 1";
> +	};
>  };
>  =

>  &i2c1 {
> @@ -51,6 +64,12 @@
>  		reg =3D <0x48>;
>  		interrupts =3D <7>;	/* SYS_NIRQ cascaded to intc */
>  		interrupt-parent =3D <&intc>;
> +
> +		twl_audio: audio {
> +			compatible =3D "ti,twl4030-audio";
> +			codec {
> +			};
> +		};
>  	};
>  };
>  =

> @@ -86,10 +105,6 @@
>  	status =3D "disabled";
>  };
>  =

> -&mcbsp2 {
> -	status =3D "disabled";
> -};
> -
>  &mcbsp3 {
>  	status =3D "disabled";
>  };
> =



-- =

P=E9ter
