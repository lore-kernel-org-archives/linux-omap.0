From: Koen Kooi <koen@beagleboard.org>
Subject: Re: [beagleboard] Re: [PATCH v6] OMAP3: beagle: add support for beagleboard xM revision C
Date: Sat, 4 Jun 2011 16:26:50 +0200
Message-ID: <1D6FACEC-4931-4613-97D2-FFAA3E8CA802@beagleboard.org>
References: <8FFAA0BFC4E5374B8F85F65FE1F2BFA5C62252DB@dlee02.ent.ti.com> <13872098A06B02418CF379A158C0F14601606D6821@dnce02.ent.ti.com> <BANLkTinodyTjcD-Pd==M0MApBhj7xAZsrw@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33197 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756329Ab1FDO0y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Jun 2011 10:26:54 -0400
Received: by wwa36 with SMTP id 36so2510884wwa.1
        for <linux-omap@vger.kernel.org>; Sat, 04 Jun 2011 07:26:53 -0700 (PDT)
In-Reply-To: <BANLkTinodyTjcD-Pd==M0MApBhj7xAZsrw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: beagleboard@googlegroups.com
Cc: "Kooi, Koen" <k-kooi@ti.com>, "Fernandes, Joel A" <joelagnel@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "beagle@list.ti.com - Ultra-low cost OMAP3 board (May contain non-TIers)" <beagle@list.ti.com>, "Maupin, Chase" <chase.maupin@ti.com>


Op 4 jun 2011, om 16:11 heeft Jason Kridner het volgende geschreven:

> On Sat, Jun 4, 2011 at 4:01 AM, Kooi, Koen <k-kooi@ti.com> wrote:
>> 
>> 
>> Texas Instruments Limited, 800 Pavilion Drive, Northampton, NN4 7YL. Registered in England & Wales under company number 00574102
>> 
>> ________________________________________
>> 
>> From: Fernandes, Joel A
>> Sent: 03 June 2011 23:56
>> To: linux-omap@vger.kernel.org
>> Cc: beagle@list.ti.com - Ultra-low cost OMAP3 board (May contain non-TIers); beagleboard@googlegroups.com; Maupin, Chase
>> Subject: [beagle] [PATCH v6] OMAP3: beagle: add support for beagleboard xM revision C
>> 
>> The USB enable GPIO has been in beagleboard xM revision C
>> The USER button has been moved since beagleboard xM
>> Also, board specific initialization has been moved to beagle_config struct
>> and initialized in omap3_beagle_init_rev. Default values in struct are for xMC.
>> 
>> Signed-off-by: Joel A Fernandes <joelagnel@ti.com>
>> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
>> ---
>>  arch/arm/mach-omap2/board-omap3beagle.c |   70 ++++++++++++++++++++-----------
>>  1 files changed, 46 insertions(+), 24 deletions(-)
>> 
>> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c
>> b/arch/arm/mach-omap2/board-omap3beagle.c
>> index 7f21d24..261fb53 100644
>> --- a/arch/arm/mach-omap2/board-omap3beagle.c
>> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
>> 
>> @@ -276,9 +297,7 @@ static int beagle_twl_gpio_setup(struct device *dev,
>>         * high / others active low)
>>         * DVI reset GPIO is different between beagle revisions
>>         */
>> -       if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
>> -               usb_pwr_level = GPIOF_OUT_INIT_HIGH;
>> -               beagle_dvi_device.reset_gpio = 129;
>> +       if (cpu_is_omap3630()) {
>> 
>> PLease add a comment like "valid for all xM versions" to the above.
>> 
>> @@ -526,7 +545,7 @@ static void __init beagle_opp_init(void)
>>        }
>> 
>>        /* Custom OPP enabled for XM */
>> -       if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
>> +       if (cpu_is_omap3630()) {
>> 
>> same
>> 
>> @@ -566,6 +585,9 @@ static void __init omap3_beagle_init(void)
>>        omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
>>        omap3_beagle_init_rev();
>>        omap3_beagle_i2c_init();
>> +
>> +       gpio_buttons[0].gpio = beagle_config.usr_button_gpio;
>> +
>> 
>> And please move that into
>> 
>> static struct gpio_keys_button gpio_buttons[] = {
>>    {
>>        .code           = BTN_EXTRA,
>>        .gpio           = 7,  <- there
> 
> I don't follow.  The other assignment is dynamic, following the
> detection of the board revision and, hopefully, before the
> initialization of the GPIO button.  I don't see how it can be moved
> here.  Perhaps it might be better to set it to -EINVAL to indicate it
> will be assigned later?

That would work, I think we should be consistent in all the assignments and if possible only set/assign them once.

regards,

Koen