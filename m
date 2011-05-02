From: <kalle.jokiniemi@nokia.com>
Subject: RE: [PATCH 1/1] OMAP3: rx-51: Add full regulator definitions
Date: Mon, 2 May 2011 04:42:14 +0000
Message-ID: <9D0D31AA57AAF5499AFDC63D6472631B09CDFB@008-AM1MPN1-036.mgdnok.nokia.com>
References: <1304081264-4915-1-git-send-email-kalle.jokiniemi@nokia.com>
	<1304081264-4915-2-git-send-email-kalle.jokiniemi@nokia.com>
 <20110429170409.5ad8833b.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:51153 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287Ab1EBEm0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 May 2011 00:42:26 -0400
In-Reply-To: <20110429170409.5ad8833b.jhnikula@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jhnikula@gmail.com
Cc: tony@atomide.com, Sakari.Ailus@nokia.com, linux-omap@vger.kernel.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com

Hi,

 > -----Original Message-----
 > From: ext Jarkko Nikula [mailto:jhnikula@gmail.com]
 > Sent: 29. huhtikuuta 2011 17:04
 > To: Jokiniemi Kalle (Nokia-SD/Tampere)
 > Cc: tony@atomide.com; Ailus Sakari (Nokia-SD/Helsinki); linux-
 > omap@vger.kernel.org; lrg@slimlogic.co.uk;
 > broonie@opensource.wolfsonmicro.com
 > Subject: Re: [PATCH 1/1] OMAP3: rx-51: Add full regulator definitions
 > 
 > On Fri, 29 Apr 2011 15:47:44 +0300
 > Kalle Jokiniemi <kalle.jokiniemi@nokia.com> wrote:
 > 
 > > +static struct regulator_init_data rx51_vintana1 = {
 > > +	.constraints = {
 > > +		.name			= "VINTANA1",
 > > +		.min_uV			= 1500000,
 > > +		.max_uV			= 1500000,
 > > +		.always_on		= true,
 > ...
 > > +static struct regulator_init_data rx51_vintdig = {
 > > +	.constraints = {
 > > +		.name			= "VINTDIG",
 > > +		.min_uV			= 1500000,
 > > +		.max_uV			= 1500000,
 > > +		.always_on		= true,
 > 
 > Are these two used at all? According to public schematics they are
 > connected to just one capasitor. Could be some needed filtering/charge
 > pump capacitors for TWL though.
 > 
 > I was thinking are all of these regulators really always_on? How about
 > letting those without any known user to be switched off?

In a working environment, these regulators were on. If you let all regulators
get disabled, you'll just be asking for trouble.

Here's the initial discussion how this patch came about: 
http://www.mail-archive.com/linux-media@vger.kernel.org/msg30775.html 


 > 
 > > @@ -838,6 +911,8 @@ static int __init rx51_i2c_init(void)
 > >  	omap_register_i2c_bus(2, 100, rx51_peripherals_i2c_board_info_2,
 > >  			      ARRAY_SIZE(rx51_peripherals_i2c_board_info_2));
 > >  	omap_register_i2c_bus(3, 400, NULL, 0);
 > > +	regulator_has_full_constraints();
 > > +
 > >  	return 0;
 > >  }
 > >
 > Move this somewhere else than in i2c initialization function :-)

I figured it would be right after the regulators have been initialized...
But yes, I'll find a better place for this.

- Kalle

 > 
 > --
 > Jarkko
