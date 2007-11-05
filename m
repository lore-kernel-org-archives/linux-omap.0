From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 1/3] ARM: OMAP: Add helper module for board specific I2C
 bus registration
Date: Mon, 5 Nov 2007 10:19:17 +0200
Message-ID: <20071105101917.063febb2.jarkko.nikula@nokia.com>
References: <1194011191-29395-1-git-send-email-jarkko.nikula@nokia.com>
	<1194011191-29395-2-git-send-email-jarkko.nikula@nokia.com>
	<200711020922.04241.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200711020922.04241.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Thanks for review David. Comments below.

"ext David Brownell" <david-b@pacbell.net> wrote:

> > +
> > +/*
> > + * FIXME: This is mostly helper function for those boards that
> > don't do
> > + * I2C pin muxing by themself
> > + */
> > +static void omap_i2c_mux_pins(int bus_id)
> 
> So what's to FIX?  I'd think that it should be able to handle
> all the pinmux options.  Are there cases where boards NEED to
> mux the pins themselves?  (Like, a choice of ballout for either
> of the I2C signals on a given bus.)
> 
> This ought to be fully board-independant code...
> 
Exactly. This function was bit problematic since I don't know what
boards need muxing changes so I just collected here what
plat-omap/device.c and mach-omap2/device.c are doing currently.

Obviously better option is to move muxing into those board files which
require them. I don't think that every OMAP1 board require

	omap_cfg_reg(I2C_SCL);
	omap_cfg_reg(I2C_SDA);

nor every OMAP24xx for second I2C (except H4 and 2430sdp)

	omap_cfg_reg(J15_24XX_I2C2_SCL);
	omap_cfg_reg(H19_24XX_I2C2_SDA);

Do Tony or someone know which boards might require above muxing changes
so that we can get rid of that omap_i2c_mux_pins from here?

> > +void omap_register_i2c_bus(int bus_id, u32 clkrate)
> 
> Consider passing the i2c_board_info in here too, so that
> boards can just say "configure this bus at N kHz, with
> these devices".  Not that having two I2C init calls in
> each board's init logic unreasonable, but if you're going
> to clean up the I2C init logic then this would be another
> thing to clean up.  And it'd help get rid of potential
> errors, by grouping all the related items together.
> 
Good point. I'll think it is better to have all of these modifications
at once. Will add it.


    Jarkko
