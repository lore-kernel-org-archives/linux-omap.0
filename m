From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH v2] omap: beagle: add support for wl1271 on the board file
Date: Thu, 23 Sep 2010 07:03:33 -0500
Message-ID: <AANLkTimce-=MP2DDNTpRh_oRFW15_gSkKZJ6fQzwc4yJ@mail.gmail.com>
References: <1285230003-5065-1-git-send-email-luciano.coelho@nokia.com>
	<AANLkTinLjQbvbTj3LTnw+54S-ojWzojqgyd=-3F783We@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58346 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394Ab0IWMDf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 08:03:35 -0400
In-Reply-To: <AANLkTinLjQbvbTj3LTnw+54S-ojWzojqgyd=-3F783We@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luciano Coelho <luciano.coelho@nokia.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-wireless@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>

On Thu, Sep 23, 2010 at 5:30 AM, Grazvydas Ignotas <notasas@gmail.com> =
wrote:
> On Thu, Sep 23, 2010 at 11:20 AM, Luciano Coelho
> <luciano.coelho@nokia.com> wrote:
>> Add board configuration for the wl1271 daughter board. =A0This patch=
 is based
>> on Ohad Ben-Cohen's patches for Zoom boards.
>
> Hm can that daughter board be detected? With your patch all beagle
> users will get GPIO139 toggled, and if someone has that wired to
> chainsaw switch somebody might get hurt.

Expansion boards really need to follow:

http://elinux.org/BeagleBoardPinMux#Expansion_boards

Is there any eeprom on i2c bus #2 for identification on this board?

Otherwise this is going to break a bunch of existing adapters.

Regards,

>
>> Cc: Ohad Ben-Cohen <ohad@wizery.com>
>> Signed-off-by: Luciano Coelho <luciano.coelho@nokia.com>
>> ---
>> There was a useless variable defined in omap3_beagle_init() that was=
 causing a
>> warning. =A0I have removed it in v2.
>>
>> =A0arch/arm/mach-omap2/board-omap3beagle.c | =A0 69 ++++++++++++++++=
+++++++++++++++
>> =A0drivers/net/wireless/wl12xx/wl1271.h =A0 =A0| =A0 =A02 +-
>> =A02 files changed, 70 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach=
-omap2/board-omap3beagle.c
>> index 87969c7..755df29 100644
>> --- a/arch/arm/mach-omap2/board-omap3beagle.c
>> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
>
> <snip>
>
>> +static struct regulator_consumer_supply beagle_vmmc2_supply =3D {
>> + =A0 =A0 =A0 .supply =A0 =A0 =A0 =A0 =3D "vmmc",
>> + =A0 =A0 =A0 .dev_name =A0 =A0 =A0 =3D "mmci-omap-hs.1",
>> +};
>> +
>> +
>
> single newline is enough.
>
>> =A0static struct regulator_consumer_supply beagle_vsim_supply =3D {
>> =A0 =A0 =A0 =A0.supply =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "vmmc_aux=
",
>> =A0};
>>
>> +
>
> here too.
>
>> +static struct regulator_init_data beagle_vmmc2 =3D {
>> + =A0 =A0 =A0 .constraints =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =3D REGULATOR_CHANGE_S=
TATUS,
>> + =A0 =A0 =A0 },
>> + =A0 =A0 =A0 .num_consumer_supplies =3D 1,
>> + =A0 =A0 =A0 .consumer_supplies =3D &beagle_vmmc2_supply,
>> +};
>> +
>> +static struct fixed_voltage_config beagle_vwlan =3D {
>> + =A0 =A0 =A0 .supply_name =3D "vwl1271",
>> + =A0 =A0 =A0 .microvolts =3D 1800000, =A0/* 1.8V */
>> + =A0 =A0 =A0 .gpio =3D OMAP_BEAGLE_WLAN_EN_GPIO,
>> + =A0 =A0 =A0 .startup_delay =3D 70000, /* 70ms */
>> + =A0 =A0 =A0 .enable_high =3D 1,
>> + =A0 =A0 =A0 .enabled_at_boot =3D 0,
>> + =A0 =A0 =A0 .init_data =3D &beagle_vmmc2,
>> +};
>
> We tabify all structures in board files, take a look at other structu=
res.
>
> <snip>
>
>> diff --git a/drivers/net/wireless/wl12xx/wl1271.h b/drivers/net/wire=
less/wl12xx/wl1271.h
>> index 4134f44..8bb028e 100644
>> --- a/drivers/net/wireless/wl12xx/wl1271.h
>> +++ b/drivers/net/wireless/wl12xx/wl1271.h
>> @@ -60,7 +60,7 @@ enum {
>> =A0 =A0 =A0 =A0DEBUG_ALL =A0 =A0 =A0 =3D ~0,
>> =A0};
>>
>> -#define DEBUG_LEVEL (DEBUG_NONE)
>> +#define DEBUG_LEVEL (DEBUG_MAC80211 | DEBUG_CMD | DEBUG_ACX | DEBUG=
_BOOT)
>
> I guess you didn't want that?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Robert Nelson
http://www.rcn-ee.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
