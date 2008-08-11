From: "Arun KS" <arunks@mistralsolutions.com>
Subject: Re: [PATCH] OMAP2EVM: Adding hsmmc support
Date: Mon, 11 Aug 2008 10:52:41 +0530
Message-ID: <dfeb90390808102222x649214aaj8d406a4e763d4884@mail.gmail.com>
References: <dfeb90390808060419j61356353jeeec1b7c95cfd3f2@mail.gmail.com>
	 <20080808074927.GK24923@atomide.com>
	 <200808081533.42172.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.184]:12903 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbYHKFWn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Aug 2008 01:22:43 -0400
Received: by ti-out-0910.google.com with SMTP id b6so948647tic.23
        for <linux-omap@vger.kernel.org>; Sun, 10 Aug 2008 22:22:42 -0700 (PDT)
In-Reply-To: <200808081533.42172.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

Hi David Brownell,

Please see function omap_init_mmc() in file
arch/arm/plat-omap/devices.c
It is doing the device registration and pin muxing for mmc
depending upon the values initialized in structure omap_mmc_config.

Best Regards
Arun KS


On Sat, Aug 9, 2008 at 4:03 AM, David Brownell <david-b@pacbell.net> wrote:
> As I commented in
>
>        http://marc.info/?l=linux-omap&m=121792042504348&w=2
>
> I can't quite see why anything is using "omap_mmc_config" for
> anything related to hsmmc ... it contains two structs that
> don't match what the hsmmc driver understands.
>
> - Dave
>
>> > @@ -83,9 +84,17 @@ static struct omap_uart_config
>> > omap2_evm_uart_config __initdata = {
>> >     .enabled_uarts  = ((1 << 0) | (1 << 1) | (1 << 2)),
>> >  };
>> >
>> > +static struct omap_mmc_config omap2_evm_mmc_config __initdata = {
>> > +   .mmc [0] = {
>> > +           .enabled        = 1,
>> > +           .wire4          = 1,
>> > +   },
>> > +};
>> > +
>> >  static struct omap_board_config_kernel omap2_evm_config[] __initdata = {
>> >     { OMAP_TAG_UART,        &omap2_evm_uart_config },
>> >     { OMAP_TAG_LCD,         &omap2_evm_lcd_config },
>> > +   { OMAP_TAG_MMC,         &omap2_evm_mmc_config },
>> >  };
>> >
>> >  static int __init omap2_evm_i2c_init(void)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
