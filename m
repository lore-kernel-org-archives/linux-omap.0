From: "Pais, Allen" <allen.pais@ti.com>
Subject: RE: [RFC][Patch V1] OMAP3: Mux Changes.
Date: Fri, 16 Oct 2009 10:23:42 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E940253DAFFA9@dbde02.ent.ti.com>
References: <7A436F7769CA33409C6B44B358BFFF0C012A98C727@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42501 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750965AbZJPEtw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 00:49:52 -0400
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C012A98C727@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>

 


Hi Allen,
a) A simple comment to all my comments: why cant we have these in bootloader and just simply leave the mux file alone?
[Allen] Yes Nishanth, this would be a much cleaner approach. Even Santosh had suggested
The same, if we can conclude on a approach here, I can go ahead and do the Mux 
Change it accordingly.
b) Are you doing this for a specific platform or are they generic 3630 pin mux changes?
[Allen] No, not as of now.

- Allen

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap- 
> owner@vger.kernel.org] On Behalf Of Menon, Nishanth
> Sent: Thursday, October 15, 2009 7:24 AM
> To: Pais, Allen; Aguirre Rodriguez, Sergio Alberto; linux-omap
> Cc: Chikkature Rajashekar, Madhusudhan; Pandita, Vikram; Gadiyar, 
> Anand; Cousson, Benoit; Felipe Balbi; Kevin Hilman; Premi, Sanjeev; 
> Shilimkar, Santosh; Tony Lindgren
> Subject: RE: [RFC][Patch V1] OMAP3: Mux Changes.
> 
> Please send your patch using git send email. And generate your patch 
> using git format patch
> 
> > -----Original Message-----
> > From: Pais, Allen
> > Sent: Thursday, October 15, 2009 4:38 AM
> >
> > Please ignore my previous mail.
> >
> > Muxes for OMAP 3630.
> >
> > Signed-off-by: Allen Pais <allen.pais@ti.com> diff --git
> a/arch/arm/mach-
> > omap2/mux.c b/arch/arm/mach-omap2/mux.c index b5fac32..93abb74 
> > 100644
> 
> 
> > --- a/arch/arm/mach-omap2/mux.c
> > +++ b/arch/arm/mach-omap2/mux.c
> > @@ -551,6 +551,42 @@ MUX_CFG_34XX("AF13_3430_MMC3_DAT3", 0x5e2, 
> > MUX_CFG_34XX("AF26_34XX_SYS_NIRQ", 0x1E0,
> >  		OMAP3_WAKEUP_EN | OMAP34XX_PIN_INPUT_PULLUP |
> >  		OMAP34XX_MUX_MODE0)
> > +
> > +/*Muxes for 3630 */
> > +MUX_CFG_34XX("H26_3630_DSS_DATA18", 0x100,
> > +		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN) 
> > +MUX_CFG_34XX("H25_3630_DSS_DATA19", 0x102,
> > +		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN) 
> > +MUX_CFG_34XX("E28_3630_DSS_DATA20", 0x104,
> > +		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN) 
> > +MUX_CFG_34XX("J26_3630_DSS_DATA21", 0x106,
> > +		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN) 
> > +MUX_CFG_34XX("AC27_3630_DSS_DATA22", 0x108,
> > +		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN) 
> > +MUX_CFG_34XX("AC28_3630_DSS_DATA23", 0x10A,
> > +		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
> Why cant I do this in Board file?
I Really typed that??? Dumb me.. apologies on the noise.. I had meant bootloader..
> > +
> > +MUX_CFG_34XX("AF9_3630_ETKD8", 0x5EC,
> > +		OMAP34XX_MUX_MODE1 | OMAP34XX_PIN_INPUT_PULLDOWN) 
> > +MUX_CFG_34XX("AG9_3630_ETKD9", 0x5EE,
> > +		OMAP34XX_MUX_MODE1 | OMAP34XX_PIN_INPUT_PULLDOWN) 
> > +MUX_CFG_34XX("AG7_3630_ETKD12", 0x5F0,
> > +		OMAP34XX_MUX_MODE1 | OMAP34XX_PIN_INPUT_PULLDOWN)
> Why am I doing this?
> > +
> > +MUX_CFG_34XX("AA25_3630_UART2_TX", 0x178,
> > +		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN) 
> > +MUX_CFG_34XX("AD25_3630_UART2_RX", 0x17A,
> > +		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN) 
> > +MUX_CFG_34XX("AB25_3630_UART2_RTS", 0x176,
> > +		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN) 
> > +MUX_CFG_34XX("AB26_3630_UART2_CTS", 0x174,
> > +		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
> Please explain..
> > +
> > +MUX_CFG_34XX("H20_UART3_RX_IRRX", 0x19E,
> > +		OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLDOWN) 
> > +MUX_CFG_34XX("H21_UART3_TX_IRTX", 0x1A0,
> > +		OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLDOWN)
> > +
> >  };
> ??
> >
> >  #define OMAP34XX_PINS_SZ	ARRAY_SIZE(omap34xx_pins)
> > diff --git a/arch/arm/plat-omap/include/mach/mux.h b/arch/arm/plat- 
> > omap/include/mach/mux.h index 0f49d2d..8d8cbe1 100644
> > --- a/arch/arm/plat-omap/include/mach/mux.h
> > +++ b/arch/arm/plat-omap/include/mach/mux.h
> > @@ -890,6 +890,32 @@ enum omap34xx_index {
> >
> >  	/* SYS_NIRQ T2 INT1 */
> >  	AF26_34XX_SYS_NIRQ,
> > +
> > +	/*Muxes for 3630*/
> > +	K28_3630_CAM_D6,
> > +	L28_3630_CAM_D7,
> > +	K27_3630_CAM_D8,
> > +	L27_3630_CAM_D9,
> > +
> > +	H26_3630_DSS_DATA18,
> > +	H25_3630_DSS_DATA19,
> > +	E28_3630_DSS_DATA20,
> > +	J26_3630_DSS_DATA21,
> > +	AC27_3630_DSS_DATA22,
> > +	AC28_3630_DSS_DATA23,
> > +
> > +	AF9_3630_ETKD8,
> > +	AG9_3630_ETKD9,
> > +	AG7_3630_ETK12,
> > +
> > +	AA25_3630_UART2_TX,
> > +	AD25_3630_UART2_RX,
> > +	AB25_3630_UART2_RTS,
> > +	AB26_3630_UART2_CTS,
> > +
> > +	H20_UART3_RX_IRRX,
> > +	H21_UART3_TX_IRTX,
> > +
> >  };
> >
> >  struct omap_mux_cfg {
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html


Regards,
Nishanth Menon

