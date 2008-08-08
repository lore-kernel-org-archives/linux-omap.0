From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP2EVM: Adding hsmmc support
Date: Fri, 8 Aug 2008 15:33:41 -0700
Message-ID: <200808081533.42172.david-b@pacbell.net>
References: <dfeb90390808060419j61356353jeeec1b7c95cfd3f2@mail.gmail.com> <20080808074927.GK24923@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:44949 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753995AbYHHWdo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Aug 2008 18:33:44 -0400
In-Reply-To: <20080808074927.GK24923@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Arun KS <arunks@mistralsolutions.com>
Cc: linux-omap@vger.kernel.org

As I commented in

	http://marc.info/?l=linux-omap&m=121792042504348&w=2

I can't quite see why anything is using "omap_mmc_config" for
anything related to hsmmc ... it contains two structs that
don't match what the hsmmc driver understands.

- Dave

> > @@ -83,9 +84,17 @@ static struct omap_uart_config
> > omap2_evm_uart_config __initdata = {
> >  	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
> >  };
> > 
> > +static struct omap_mmc_config omap2_evm_mmc_config __initdata = {
> > +	.mmc [0] = {
> > +		.enabled        = 1,
> > +		.wire4          = 1,
> > +	},
> > +};
> > +
> >  static struct omap_board_config_kernel omap2_evm_config[] __initdata = {
> >  	{ OMAP_TAG_UART,	&omap2_evm_uart_config },
> >  	{ OMAP_TAG_LCD,		&omap2_evm_lcd_config },
> > +	{ OMAP_TAG_MMC,		&omap2_evm_mmc_config },
> >  };
> > 
> >  static int __init omap2_evm_i2c_init(void)
