From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [RFC] OMAP DT i2c aliases
Date: Mon, 02 Jun 2014 19:44:05 +0300
Message-ID: <538CA9D5.1070506@gmail.com>
References: <538B3877.70304@gmail.com> <538C9B62.9090404@ti.com> <538CA04C.1070509@gmail.com> <538CA422.8000504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:51667 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754444AbaFBQoM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jun 2014 12:44:12 -0400
Received: by mail-we0-f179.google.com with SMTP id q59so5407588wes.38
        for <linux-omap@vger.kernel.org>; Mon, 02 Jun 2014 09:44:11 -0700 (PDT)
In-Reply-To: <538CA422.8000504@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>, sre@kernel.org



On  2.06.2014 19:19, Nishanth Menon wrote:
>
> I think that slipped my check list unfortunately. :( But then, if we
> think that it is just n900 that is impacted, then I wonder if we can
> override the alias? just wondering..
>

That https://lkml.org/lkml/2014/6/1/49 patch will allow such override, I 
tested it on N900 with Fremantle and it works fine. Ofc I had to add

aliases {
	i2c1 = &i2c1;
	i2c2 = &i2c2;
	i2c3 = &i2c3;
};

to omap3-n900.dts (while keeping omap3.dtsi intact) for it to work.

I checked in some Nemo N9/N950 adaptation kernel and it seems those will 
be broken too(and I bet it is the same in stock Nokia N9/50 kernels):

static void __init rm680_i2c_init(void)
{
	omap3_pmic_get_config(&rm680_twl_data, TWL_COMMON_PDATA_USB,
			      TWL_COMMON_REGULATOR_VDAC |
			      TWL_COMMON_REGULATOR_VPLL2);
	omap_pmic_init(1, 2900, "twl5031", INT_34XX_SYS_NIRQ, &rm680_twl_data);
	omap_register_i2c_bus(2, 400, rm696_peripherals_i2c_board_info_2,
			      ARRAY_SIZE(rm696_peripherals_i2c_board_info_2));
	omap_register_i2c_bus(3, 400, rm696_peripherals_i2c_board_info_3,
			      ARRAY_SIZE(rm696_peripherals_i2c_board_info_3));
}

Again 1,2 and 3 for bus indexes just like on N900.

Anyway, I am fine with the alias override. If the patch makes it to the 
upstream :)

Regards,
Ivo
