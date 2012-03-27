From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCH 05/12] Add dummy smsc911x regulators to cm-t35.
Date: Tue, 27 Mar 2012 11:32:13 -0700
Message-ID: <CA+Bv8XYiv+gr4yB+k7sWSSjdYSsYdnRJuTO3A5zZhh4bkoziXw@mail.gmail.com>
References: <1332494504-10251-1-git-send-email-Russ.Dill@ti.com>
	<1332494504-10251-6-git-send-email-Russ.Dill@ti.com>
	<4F71E290.2050403@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35754 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755266Ab2C0ScO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Mar 2012 14:32:14 -0400
Received: by pbcun15 with SMTP id un15so540583pbc.19
        for <linux-omap@vger.kernel.org>; Tue, 27 Mar 2012 11:32:13 -0700 (PDT)
In-Reply-To: <4F71E290.2050403@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Matt Porter <mporter@ti.com>, robert.marklund@stericsson.com, linus.walleij@linaro.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

No objection.

On Tue, Mar 27, 2012 at 8:53 AM, Igor Grinberg <grinberg@compulab.co.il=
> wrote:
> Hi Russ,
>
> This patch works, but can we, please use the attached patch instead?
>
> Thanks
>
> On 03/23/12 11:21, Russ Dill wrote:
>> Signed-off-by: Russ Dill <russ.dill@ti.com>
>> ---
>> =C2=A0arch/arm/mach-omap2/board-cm-t35.c | =C2=A0 =C2=A09 +++++++++
>> =C2=A01 files changed, 9 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap=
2/board-cm-t35.c
>> index 41b0a2f..289ded3 100644
>> --- a/arch/arm/mach-omap2/board-cm-t35.c
>> +++ b/arch/arm/mach-omap2/board-cm-t35.c
>> @@ -26,6 +26,7 @@
>>
>> =C2=A0#include <linux/i2c/at24.h>
>> =C2=A0#include <linux/i2c/twl.h>
>> +#include <linux/regulator/fixed.h>
>> =C2=A0#include <linux/regulator/machine.h>
>> =C2=A0#include <linux/mmc/host.h>
>>
>> @@ -630,10 +631,18 @@ static inline void cm_t3730_init_mux(void) {}
>> =C2=A0static struct omap_board_config_kernel cm_t35_config[] __initd=
ata =3D {
>> =C2=A0};
>>
>> +static struct regulator_consumer_supply dummy_supplies[] =3D {
>> + =C2=A0 =C2=A0 REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
>> + =C2=A0 =C2=A0 REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
>> + =C2=A0 =C2=A0 REGULATOR_SUPPLY("vddvario", "smsc911x.1"),
>> + =C2=A0 =C2=A0 REGULATOR_SUPPLY("vdd33a", "smsc911x.1"),
>> +};
>> +
>> =C2=A0static void __init cm_t3x_common_init(void)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 omap_board_config =3D cm_t35_config;
>> =C2=A0 =C2=A0 =C2=A0 omap_board_config_size =3D ARRAY_SIZE(cm_t35_co=
nfig);
>> + =C2=A0 =C2=A0 regulator_register_fixed(0, dummy_supplies, ARRAY_SI=
ZE(dummy_supplies));
>> =C2=A0 =C2=A0 =C2=A0 omap3_mux_init(board_mux, OMAP_PACKAGE_CUS);
>> =C2=A0 =C2=A0 =C2=A0 omap_serial_init();
>> =C2=A0 =C2=A0 =C2=A0 omap_sdrc_init(mt46h32m32lf6_sdrc_params,
>
> --
> Regards,
> Igor.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
