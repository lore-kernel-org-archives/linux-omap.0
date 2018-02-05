From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCHv2] tlv320dac33: Add device tree bindings
Date: Mon, 5 Feb 2018 00:08:40 -0600
Message-ID: <20180205060840.7yeld5sc67win2vd@rob-hp-laptop>
References: <20180129230539.GA18280@amd>
 <20180131190112.GA31608@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20180131190112.GA31608@amd>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Machek <pavel@ucw.cz>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, tony@atomide.com, abcloriens@gmail.com, tiwai@suse.com, martijn@brixit.nl, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, patrikbachan@gmail.com, ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, serge@hallyn.com, devicetree@vger.kernel.org, pali.rohar@gmail.com, broonie@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, aaro.koskinen@iki.fi, linux-kernel@vger.kernel.org, clayton@craftyguy.net, sakari.ailus@linux.intel.com, sre@kernel.org, bhumirks@gmail.com
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 31, 2018 at 08:01:12PM +0100, Pavel Machek wrote:
> 
> This adds device tree bindings for tlv320dac33.c.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> diff --git a/Documentation/devicetree/bindings/sound/tlv320dac33.txt b/Documentation/devicetree/bindings/sound/tlv320dac33.txt
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

space before tab ^

> +- ti,burst-bclkdiv - BCLK divider value in burst mode

What are valid values? What's the default?

> +
> +Example:
> +
> +tlv320dac33: audio-codec@19 {
> +	compatible = "ti,tlv320dac33";
> +	reg = <0x19>;
> +
> +	interrupt-parent = <&gpio2>;
> +	interrupts = <21 1>; /* gpio_53, IRQF_TRIGGER_RISING */
> +	reset-gpios = <&gpio2 28 0>; /* gpio_60 */
> +
> +	ti,keep-bclk;
> +	ti,burst-bclkdiv = <3>;
> +};
> 
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
