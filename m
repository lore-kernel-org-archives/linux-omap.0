From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCHv2] tlv320dac33: Add device tree bindings
Date: Thu, 1 Feb 2018 09:39:11 +0200
Message-ID: <20b9ff40-a869-a165-07a2-2a103830efb3@ti.com>
References: <20180129230539.GA18280@amd> <20180131190112.GA31608@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180131190112.GA31608@amd>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Machek <pavel@ucw.cz>, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com, bhumirks@gmail.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, pali.rohar@gmail.com, sre@kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, =?UTF-8?Q?Filip_Matijevi=c4=87?= <filip.matijevic.pz@gmail.com>
List-Id: linux-omap@vger.kernel.org



On 2018-01-31 21:01, Pavel Machek wrote:
> =

> This adds device tree bindings for tlv320dac33.c.

Can you CC me for dac33 patches in the future, please?

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> =

> diff --git a/Documentation/devicetree/bindings/sound/tlv320dac33.txt b/Do=
cumentation/devicetree/bindings/sound/tlv320dac33.txt
> new file mode 100644
> index 0000000..7fdda95
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/tlv320dac33.txt
> @@ -0,0 +1,32 @@
> +Texas Instruments - tlv320dac33 Codec module
> +
> +The tlv320dac33 serial control bus communicates through I2C protocols.
> +
> +Required properties:
> +
> +- compatible - "ti,tlv320dac33"
> +- reg - I2C slave address
> +
> +Optional properties:
> +
> +- reset-gpios - gpio pin to power the device, active low
> +
> +- interrupts       - The interrupt output from the device.
> +- interrupt-parent - The parent interrupt controller.
> +
> +- ti,keep-bclk 	- Keep the BCLK running in FIFO modes
> +- ti,burst-bclkdiv - BCLK divider value in burst mode
> +
> +Example:
> +
> +tlv320dac33: audio-codec@19 {
> +	compatible =3D "ti,tlv320dac33";
> +	reg =3D <0x19>;
> +
> +	interrupt-parent =3D <&gpio2>;
> +	interrupts =3D <21 1>; /* gpio_53, IRQF_TRIGGER_RISING */
> +	reset-gpios =3D <&gpio2 28 0>; /* gpio_60 */
> +
> +	ti,keep-bclk;
> +	ti,burst-bclkdiv =3D <3>;
> +};
> =

> =


- P=E9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
