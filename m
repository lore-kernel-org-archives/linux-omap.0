From: Sricharan R <r.sricharan@ti.com>
Subject: RE: [PATCH v2 4/5] omap4: board-omap4panda: Initialise the serial pads
Date: Wed, 2 Feb 2011 09:52:40 +0530
Message-ID: <9c6b9efa8fff83d16ce44d086bddc817@mail.gmail.com>
References: <1296483782-21950-1-git-send-email-r.sricharan@ti.com> <874o8nnssv.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:38673 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753671Ab1BBE37 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 23:29:59 -0500
Received: by mail-bw0-f41.google.com with SMTP id 16so174798bwz.28
        for <linux-omap@vger.kernel.org>; Tue, 01 Feb 2011 20:29:57 -0800 (PST)
In-Reply-To: <874o8nnssv.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, tony@atomide.com, paul@pswan.com, Anand Gadiyar <gadiyar@ti.com>, Benoit Cousson <b-cousson@ti.com>

>-----Original Message-----
>From: Kevin Hilman [mailto:khilman@ti.com]
>Sent: Wednesday, February 02, 2011 6:42 AM
>To: sricharan
>Cc: linux-omap@vger.kernel.org; santosh.shilimkar@ti.com;
tony@atomide.com;
>paul@pswan.com; gadiyar@ti.com; b-cousson@ti.com
>Subject: Re: [PATCH v2 4/5] omap4: board-omap4panda: Initialise the
serial
>pads
>
>sricharan <r.sricharan@ti.com> writes:
>
>> Removed the remux flags for serial2 cts which was
>> kept for testing. Passed the serial data to serial
>> init.
>
>This is a description of what changed since v1, not a description of the
>patch.  This kind of version history should go after the '---' for the
>benefit of reviewers.  Please add a description of this patch here.


Ok. I will correct this and send.
 I will take this for my future patches also.
>
>> Tested this on omap4panda.
>>
>> Signed-off-by: sricharan <r.sricharan@ti.com>
>> ---
>>  arch/arm/mach-omap2/board-omap4panda.c |   72
>+++++++++++++++++++++++++++++++-
>>  1 files changed, 70 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-
>omap2/board-omap4panda.c
>> index b43e3ff..1c65420 100644
>> --- a/arch/arm/mach-omap2/board-omap4panda.c
>> +++ b/arch/arm/mach-omap2/board-omap4panda.c
>> @@ -370,13 +370,81 @@ static int __init omap4_panda_i2c_init(void)
>>  	omap_register_i2c_bus(4, 400, NULL, 0);
>>  	return 0;
>>  }
>> -
>>  #ifdef CONFIG_OMAP_MUX
>>  static struct omap_board_mux board_mux[] __initdata = {
>>  	{ .reg_offset = OMAP_MUX_TERMINATOR },
>>  };
>> +
>> +static struct omap_device_pad serial2_pads[] __initdata = {
>> +	{ .name   = "uart2_cts.uart2_cts",
>> +	  .enable = OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
>> +	},
>> +	{ .name   = "uart2_rts.uart2_rts",
>> +	  .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
>> +	},
>> +	{ .name   = "uart2_rx.uart2_rx",
>> +	  .enable = OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
>> +	},
>> +	{ .name   = "uart2_tx.uart2_tx",
>> +	  .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
>> +	},
>> +};
>> +
>> +static struct omap_device_pad serial3_pads[] __initdata = {
>> +	{ .name   = "uart3_cts_rctx.uart3_cts_rctx",
>> +	  .enable = OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
>> +	},
>> +	{ .name   = "uart3_rts_sd.uart3_rts_sd",
>> +	  .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
>> +	},
>> +	{ .name   = "uart3_rx_irrx.uart3_rx_irrx",
>> +	  .enable = OMAP_PIN_INPUT | OMAP_MUX_MODE0,
>> +	},
>> +	{ .name   = "uart3_tx_irtx.uart3_tx_irtx",
>> +	  .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
>> +	},
>> +};
>> +
>> +static struct omap_device_pad serial4_pads[] __initdata = {
>> +	{ .name   = "uart4_rx.uart4_rx",
>> +	.enable = OMAP_PIN_INPUT | OMAP_MUX_MODE0,
>> +	},
>> +	{ .name   = "uart4_tx.uart4_tx",
>> +	  .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
>> +	},
>> +};
>> +
>> +static struct omap_board_data serial2_data = {
>> +	.id             = 1,
>> +	.pads           = serial2_pads,
>> +	.pads_cnt       = ARRAY_SIZE(serial2_pads),
>> +};
>> +
>> +static struct omap_board_data serial3_data = {
>> +	.id             = 2,
>> +	.pads           = serial3_pads,
>> +	.pads_cnt       = ARRAY_SIZE(serial3_pads),
>> +};
>> +
>> +static struct omap_board_data serial4_data = {
>> +	.id             = 3,
>> +	.pads           = serial4_pads,
>> +	.pads_cnt       = ARRAY_SIZE(serial4_pads),
>> +};
>> +
>> +static inline void board_serial_init(void)
>> +{
>> +	omap_serial_init_port(&serial2_data);
>> +	omap_serial_init_port(&serial3_data);
>> +	omap_serial_init_port(&serial4_data);
>> +}
>>  #else
>>  #define board_mux	NULL
>> +
>> +static inline void board_serial_init(void)
>> +{
>> +	omap_serial_init();
>> +}
>>  #endif
>
>As Anand pointed out in your earlier version,  this patch also contains
>a functional change, namely not initializing UART1.
>
>In addition to Anand's, it introduces a potentially confusing and
>unexpected difference with and without CONFIG_MUX.  When CONFIG_MUX is
>enabled, you get UART2,3 & 4 initialized, and with !CONFIG_MUX you all
>UARTs.
>
>In my opinion, this patch should continue to initialize all UARTs.  If
>you want to leave out the init of UART1, introduce it as a separate
>patch please.
>

Ok. Actually as I said earlier UART1 though initialized
    Is not getting muxed out. I can see that all the UART1
    pads are used for alternate functionalities. But as you said
    the initialization should be same for both CONFIG_MUX and
    !CONFIG_MUX . So I will remove the initialization of UART1
    and will send this as a separate patch.

>Kevin
>
>>  static void __init omap4_panda_init(void)
>> @@ -389,7 +457,7 @@ static void __init omap4_panda_init(void)
>>
>>  	omap4_panda_i2c_init();
>>  	platform_add_devices(panda_devices, ARRAY_SIZE(panda_devices));
>> -	omap_serial_init();
>> +	board_serial_init();
>>  	omap4_twl6030_hsmmc_init(mmc);
>>  	/* OMAP4 Panda uses internal transceiver so register nop
transceiver
>*/
>>  	usb_nop_xceiv_register();
