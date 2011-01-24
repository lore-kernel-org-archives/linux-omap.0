From: "Nagendra" <nagendra@mistralsolutions.com>
Subject: RE: OMAP3 - PM - Question - Disabling CLKEN and HFCLKOUT signals           from TWL4030 scripts
Date: Mon, 24 Jan 2011 22:20:26 +0530
Message-ID: <00d701cbbbe6$d15bfd10$7413f730$@com>
References: <005301cbb947$6d682730$48387590$@com>    <23149.10.24.255.17.1295604867.squirrel@dbdmail.itg.ti.com>    <001501cbb993$b25c0fe0$17142fa0$@com> <44872.10.24.255.17.1295846556.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47693 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753756Ab1AXQuU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jan 2011 11:50:20 -0500
Received: by fxm20 with SMTP id 20so4220333fxm.19
        for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 08:50:19 -0800 (PST)
In-Reply-To: <44872.10.24.255.17.1295846556.squirrel@dbdmail.itg.ti.com>
Content-Language: en-us
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Lesly A M' <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, ratheesh@mistralsolutions.com

Hi Lesly,

> Hi Nagendra,
>
>> Hi All,
>>
>> We are working on Power management on OMAP3 (3530) and I am trying to
>> disable CLKEN and HFCLKOUT through TWL4030 power scripts. However we have
>> not been able to achieve this.
>>
>> Following are the changes and tests done so far.
>>
>> - VAUX1, CLKEN and HFCLKOUT were assigned to P1 group.
>> - Wrote Singular messages to turn on/off these signals in TWL4030
scripts.
>> - We observed that VAUX1 is able to switch ON/OFF properly as per the
> script
>> but HFCLKOUT and CLKEN are not behaving as expected.
>> - However if we try writing CLKEN_DEV_GRP to zero, CLKEN is going low.
>> - We have made sure that SYS_OFF_MODE and CLK_REQ signals go low during
> the
>> system OFF mode, LVL_WAKEUP bit enabled in Px_SW_EVENTS, and STS_CHG bit
> in
>> STS_HW_CONDITIONS is zero.
>>
>> Is there anything that I am missing? Kindly let me know.
>
> Did try probing the sys_clkreq from OMAP?
> <Nagendra> Yes nSLEEP1, nSLEEP2 and SYS_CLK_REQ signals go low during
system
> OFF mode.
>
> Are you sending SLEEP/OFF command in singular msg?
> <Nagendra> Yes.
>
> Also check the HFCLKOUT_REMAP register for SLEEP_STATE[3:0], if using
SLEEP
> cmd.
> <Nagendra>
> We are setting SLEEP_STATE field of CLKEN and HFCLKOUT  to OFF mode.
>
> PSP version : 3.0.1.6
>
> Following is the TWL4030 power scripts that we are trying to get CLKEN
> signal to OFF state. This is based on rx51-peripherals.c
>
> -----------------------------------------------
> static struct twl4030_ins sleep_on_seq[] __initdata = {
>         {MSG_SINGULAR(DEV_GRP_P1, RES_CLKEN, RES_STATE_OFF), 2},

you have to sent sleep cmd to RES_HFCLKOUT also.(* attach HFCLKOUT to P3)

> };
>
> static struct twl4030_script sleep_on_script __initdata = {
>         .script = sleep_on_seq,
>         .size   = ARRAY_SIZE(sleep_on_seq),
>         .flags  = TWL4030_SLEEP_SCRIPT,
> };
>
> static struct twl4030_ins wakeup_seq[] __initdata = {
>         {MSG_SINGULAR(DEV_GRP_P1, RES_CLKEN, RES_STATE_ACTIVE), 2},
> };
>
> static struct twl4030_script wakeup_script __initdata = {
>         .script = wakeup_seq,
>         .size   = ARRAY_SIZE(wakeup_seq),
>         .flags  = TWL4030_WAKEUP12_SCRIPT,
> };
>
> static struct twl4030_ins wakeup_p3_seq[] __initdata = {
>         {MSG_SINGULAR(DEV_GRP_P3, RES_CLKEN, RES_STATE_ACTIVE), 2},

you have to wakeup cmd to RES_HFCLKOUT also. (* attach HFCLKOUT to P3)

> };
>
> static struct twl4030_script wakeup_p3_script __initdata = {
>         .script = wakeup_p3_seq,
>         .size   = ARRAY_SIZE(wakeup_p3_seq),
>         .flags  = TWL4030_WAKEUP3_SCRIPT,
> };
>
> static struct twl4030_ins wrst_seq[] __initdata = {
> /*
>  * Reset twl4030.
>  * Reset VDD1 regulator.
>  * Reset VDD2 regulator.
>  * Reset VPLL1 regulator.
>  * Enable sysclk output.
>  * Reenable twl4030.
>  */
>         {MSG_SINGULAR(DEV_GRP_NULL, RES_RESET, RES_STATE_OFF), 2},
>         {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, 0, 1, RES_STATE_ACTIVE),
>                 0x13},
>         {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_PP, 0, 3, RES_STATE_OFF),
> 0x13},
>         {MSG_SINGULAR(DEV_GRP_NULL, RES_VDD1, RES_STATE_WRST), 0x13},
>         {MSG_SINGULAR(DEV_GRP_NULL, RES_VDD2, RES_STATE_WRST), 0x13},
>         {MSG_SINGULAR(DEV_GRP_NULL, RES_VPLL1, RES_STATE_WRST), 0x35},
>         {MSG_SINGULAR(DEV_GRP_P3, RES_HFCLKOUT, RES_STATE_ACTIVE), 2},
>         {MSG_SINGULAR(DEV_GRP_NULL, RES_RESET, RES_STATE_ACTIVE), 2},
> };
>
> static struct twl4030_script wrst_script __initdata = {
>         .script = wrst_seq,
>         .size   = ARRAY_SIZE(wrst_seq),
>         .flags  = TWL4030_WRST_SCRIPT,
> };
>
> static struct twl4030_script *twl4030_scripts[] __initdata = {
>         /* wakeup12 script should be loaded before sleep script, otherwise
a
>            board might hit retention before loading of wakeup script is
>            completed. This can cause boot failures depending on timing
> issues.
>         */
>         &wakeup_script,
>         &sleep_on_script,
>         &wakeup_p3_script,
>         &wrst_script,
> };
>
> static struct twl4030_resconfig twl4030_rconfig[] __initdata = {
>         { .resource = RES_CLKEN, .devgroup = DEV_GRP_P1,
>           .type = -1, .type2 = -1 , .remap_off = RES_STATE_OFF,
.remap_sleep
> = RES_STATE_OFF
>         },
>         { .resource = RES_HFCLKOUT, .devgroup = -1,
>           .type = -1, .type2 = -1, .remap_off = RES_STATE_OFF,
.remap_sleep
> = RES_STATE_OFF
>         },
>
>         { 0, 0},
> };
> ----------------------------------------------------------

>> Part number of TPS used in our board is TPS65950 BZXNR
>>

You are using which code base (mainline kernel) ?


<Nagendra> We tried putting HFCLKOUT tied to P3 and put it into OFF state,
but that did not work.

1. Is it necessary to put HFCLKOUT to OFF/SLEEP before switch OFF CLKEN?

2. We observe that none of RC resources can be put into sleep/off mode. Is
there any dependency for this to work?

3. We are using Linux version 2.6.32 from PSP 3.0.1.6 release



Regards,
Lesly A M



