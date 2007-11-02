From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/3] ARM: OMAP: Add helper module for board specific I2C
	bus registration
Date: Fri, 2 Nov 2007 09:22:04 -0700
Message-ID: <200711020922.04241.david-b@pacbell.net>
References: <1194011191-29395-1-git-send-email-jarkko.nikula@nokia.com>
	<1194011191-29395-2-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1194011191-29395-2-git-send-email-jarkko.nikula@nokia.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Friday 02 November 2007, jarkko.nikula@nokia.com wrote:
> +#define NUM_RESOURCES	(sizeof(i2c_resources) / sizeof(*i2c_resources))

This is ARRAY_SIZE yes?


> +
> +/*
> + * FIXME: This is mostly helper function for those boards that don't do
> + * I2C pin muxing by themself

So what's to FIX?  I'd think that it should be able to handle
all the pinmux options.  Are there cases where boards NEED to
mux the pins themselves?  (Like, a choice of ballout for either
of the I2C signals on a given bus.)

This ought to be fully board-independant code...


> + */
> +static void omap_i2c_mux_pins(int bus_id)
> +{
> +	switch (bus_id) {
> +	case 1:
> +		if (cpu_class_is_omap1()) {
> +			omap_cfg_reg(I2C_SCL);
> +			omap_cfg_reg(I2C_SDA);
> +		} else if (machine_is_omap_h4()) {

What about other OMAP2 boards wanting to use bus 1?

> +			omap_cfg_reg(M19_24XX_I2C1_SCL);
> +			omap_cfg_reg(L15_24XX_I2C1_SDA);
> +		}
> +		break;
> +	case 2:
> +		if (cpu_is_omap24xx() && !machine_is_omap_h4()) {
> +			omap_cfg_reg(J15_24XX_I2C2_SCL);
> +			omap_cfg_reg(H19_24XX_I2C2_SDA);

Again, this shouldn't have board-specific code.  If a given
board is going to use bus #2, the only way it shouldn't be
set up here is if there's a nonstandard ballout option (on
the order of, either J15 or X2 for 24XX_I2C2_SCL).


> +		}
> +		break;
> +	}
> +}
> +
> +void omap_register_i2c_bus(int bus_id, u32 clkrate)
> +{

Consider passing the i2c_board_info in here too, so that
boards can just say "configure this bus at N kHz, with
these devices".  Not that having two I2C init calls in
each board's init logic unreasonable, but if you're going
to clean up the I2C init logic then this would be another
thing to clean up.  And it'd help get rid of potential
errors, by grouping all the related items together.

- Dave
