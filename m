From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ARM: OMAP: Add helper module for board specific
	I2C bus registration
Date: Tue, 6 Nov 2007 04:51:45 -0800
Message-ID: <20071106125144.GG19275@atomide.com>
References: <1194011191-29395-1-git-send-email-jarkko.nikula@nokia.com>
	<200711020922.04241.david-b@pacbell.net>
	<20071105101917.063febb2.jarkko.nikula@nokia.com>
	<200711060026.57280.david-b@pacbell.net>
	<20071106125351.5098fe10.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20071106125351.5098fe10.jarkko.nikula@nokia.com>
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

* Jarkko Nikula <jarkko.nikula@nokia.com> [071106 02:53]:
> On Tue, 6 Nov 2007 00:26:57 -0800
> "ext David Brownell" <david-b@pacbell.net> wrote:
> 
> > > +/*
> > > + * REVISIT: How many boards really require muxing here? It should
> > > be done
> > > + * by the bootloader 
> > 
> > Erm, not as a rule.  The last policy I recall being discussed
> > was that Linux should not trust the boot loader to have set
> > up pin muxing.  If a product is being developed with a boot
> > loader which does that, fine -- resolve that by configuring
> > the pinmux support out of Linux.  That would be an OPTION.
> > 
> > But in all cases, the Linux code shold include pinmux support.
> > That way drivers etc can be properly debugged without needing
> > to depend on bootloader bugfixes of any type.
> > 
> Ok, now I got the point :-)
> 
> So here is the latest version:
> 
> static void omap_i2c_mux_pins(int bus_id)
> {
> 	/* TODO: Muxing for OMAP3 */
> 	switch (bus_id) {
> 	case 1:
> 		if (cpu_class_is_omap1()) {
> 			omap_cfg_reg(I2C_SCL);
> 			omap_cfg_reg(I2C_SDA);
> 		} else if (cpu_class_is_omap2()) {
> 			omap_cfg_reg(M19_24XX_I2C1_SCL);
> 			omap_cfg_reg(L15_24XX_I2C1_SDA);
> 		}
> 		break;
> 	case 2:
> 		if (cpu_is_omap24xx()) {
> 			omap_cfg_reg(J15_24XX_I2C2_SCL);
> 			omap_cfg_reg(H19_24XX_I2C2_SDA);
> 		}
> 		break;
> 	}
> }
> 
> I think no need to cover CONFIG_OMAP_MUX here since omap_cfg_reg has
> null implementation if it's not enabled?

Yeah it's null if not enabled.

Tony
