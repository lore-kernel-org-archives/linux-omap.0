From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/3] ARM: OMAP: Add helper module for board specific I2C
	bus registration
Date: Tue, 6 Nov 2007 00:26:57 -0800
Message-ID: <200711060026.57280.david-b@pacbell.net>
References: <1194011191-29395-1-git-send-email-jarkko.nikula@nokia.com>
	<200711020922.04241.david-b@pacbell.net>
	<20071105101917.063febb2.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071105101917.063febb2.jarkko.nikula@nokia.com>
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
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Monday 05 November 2007, Jarkko Nikula wrote:
> Do Tony or someone know which boards might require above muxing changes
> so that we can get rid of that omap_i2c_mux_pins from here?

Keep it simple.  If you're going to use a given i2c bus,
always have that setup routine mux it.  If board-specific
code does it too, that can't hurt ... and that board code
can be removed someday.


Your latest code goes:

> +/*
> + * REVISIT: How many boards really require muxing here? It should be d=
one
> + * by the bootloader=20

Erm, not as a rule.  The last policy I recall being discussed
was that Linux should not trust the boot loader to have set
up pin muxing.  If a product is being developed with a boot
loader which does that, fine -- resolve that by configuring
the pinmux support out of Linux.  That would be an OPTION.

But in all cases, the Linux code shold include pinmux support.
That way drivers etc can be properly debugged without needing
to depend on bootloader bugfixes of any type.


> 		and if not, then the muxing should go into those=20
> + * board files. Since this is not known yet, do it here like how previ=
ous
> + * implementation was doing. However, eventually this function shall d=
isappear + */

Again, no.  This would be the hook through which Linux always
ensures muxing is done correctly.  The exception would be that
you could compile out all pinmux support, using standard
conditional compilation tools (CONFIG_OMAP_MUX=3Dn).


> +static void omap_i2c_mux_pins(int bus_id)
> +{
> +=A0=A0=A0=A0=A0=A0=A0switch (bus_id) {
> +=A0=A0=A0=A0=A0=A0=A0case 1:
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (cpu_class_is_omap1())=
 {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0o=
map_cfg_reg(I2C_SCL);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0o=
map_cfg_reg(I2C_SDA);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}

There should be an omap2 case here too, like

		if (cpu_is_omap24xx()) {
			omap_cfg_reg(M19_24XX_I2C1_SCL);
			omap_cfg_reg(L15_24XX_I2C1_SDA);
		}

I didn't check if that's the reset default, but again
the rule should be that Linux does *NOT* require a
fully-configuring and fully debugged boot loader to run.

If you've got such a boot loader, great -- you can disable
CONFIG_OMAP_MUX and the kernel will be somewhat smaller.
Meanwhile, not having such a boot loader should never be
a blocking factor in system development.

- Dave


> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0break;
> +=A0=A0=A0=A0=A0=A0=A0case 2:
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (cpu_is_omap24xx()) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0o=
map_cfg_reg(J15_24XX_I2C2_SCL);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0o=
map_cfg_reg(H19_24XX_I2C2_SDA);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0break;
> +=A0=A0=A0=A0=A0=A0=A0}
> +}
