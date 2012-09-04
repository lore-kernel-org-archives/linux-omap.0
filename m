From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 3/4] ARM: AM33XX: board-generic: Add of_dev_auxdata to
 pass d_can raminit
Date: Tue, 04 Sep 2012 09:35:39 +0200
Message-ID: <5045AF4B.20305@pengutronix.de>
References: <1346673139-14540-1-git-send-email-anilkumar@ti.com> <1346673139-14540-4-git-send-email-anilkumar@ti.com> <50450EE2.3000107@pengutronix.de> <331ABD5ECB02734CA317220B2BBEABC13EA26346@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCA70644A624AFB91E01982ED"
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA26346@DBDE01.ent.ti.com>
Sender: linux-can-owner@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCA70644A624AFB91E01982ED
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/04/2012 08:26 AM, AnilKumar, Chimata wrote:
> On Tue, Sep 04, 2012 at 01:41:14, Marc Kleine-Budde wrote:
>> On 09/03/2012 01:52 PM, AnilKumar Ch wrote:
>>> Add of_dev_auxdata to pass d_can raminit callback APIs to initialize
>>> d_can RAM. D_CAN RAM initialization bits are present in CONTROL modul=
e
>>> address space, which can be accessed by platform specific code. So
>>> callback functions are added to serve this purpose, this can done by
>>> using of_dev_auxdata.
>>>
>>> Callback API is added to of_dev_auxdata with different instance numbe=
rs
>>> for two instances of D_CAN IP. These callback functions are used to
>>> enable/disable D_CAN RAM from CAN driver.
>>>
>>> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
>>
>> This will be a more complicated. This patch will go over the arm tree,=

>> but needs a header going via net.
>>
>=20
> Marc,
>=20
> I agree this is a bit complicated but this has to go along with
> this patch series otherwise build will break. If there are no
> changes required I will request Tony to ack it.

Yes, an Ack by Tony will help.

>=20
> Tony,
>=20
> If there are no changes required, could you please ack this patch
> so that this will go to linux-can tree.

Marc

>=20
> Thanks
> AnilKumar
>=20
>>
>>> ---
>>>  arch/arm/mach-omap2/board-generic.c |   40 +++++++++++++++++++++++++=
+++++++++-
>>>  arch/arm/mach-omap2/control.h       |    4 ++++
>>>  2 files changed, 43 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap=
2/board-generic.c
>>> index 6f93a20..b68e642 100644
>>> --- a/arch/arm/mach-omap2/board-generic.c
>>> +++ b/arch/arm/mach-omap2/board-generic.c
>>> @@ -15,6 +15,7 @@
>>>  #include <linux/of_irq.h>
>>>  #include <linux/of_platform.h>
>>>  #include <linux/irqdomain.h>
>>> +#include <linux/can/platform/c_can.h>
>>> =20
>>>  #include <mach/hardware.h>
>>>  #include <asm/hardware/gic.h>
>>> @@ -22,6 +23,8 @@
>>> =20
>>>  #include <plat/board.h>
>>>  #include "common.h"
>>> +#include "control.h"
>>> +#include "iomap.h"
>>>  #include "common-board-devices.h"
>>> =20
>>>  #if !(defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3))
>>> @@ -37,11 +40,46 @@ static struct of_device_id omap_dt_match_table[] =
__initdata =3D {
>>>  	{ }
>>>  };
>>> =20
>>> +void d_can_hw_raminit(unsigned int instance, bool enable)
>>> +{
>>> +	u32 val;
>>> +
>>> +	val =3D readl(AM33XX_CTRL_REGADDR(AM33XX_CONTROL_DCAN_RAMINIT));
>>> +	if (enable) {
>>> +		val &=3D ~AM33XX_DCAN_RAMINIT_START_MASK(instance);
>>> +		val |=3D AM33XX_DCAN_RAMINIT_START_MASK(instance);
>>> +		writel(val, AM33XX_CTRL_REGADDR(AM33XX_CONTROL_DCAN_RAMINIT));
>>> +	} else {
>>> +		val &=3D ~AM33XX_DCAN_RAMINIT_START_MASK(instance);
>>> +		writel(val, AM33XX_CTRL_REGADDR(AM33XX_CONTROL_DCAN_RAMINIT));
>>> +	}
>>> +}
>>> +
>>> +static struct c_can_platform_data d_can0_pdata =3D {
>>> +	.ram_init	=3D d_can_hw_raminit,
>>> +	.instance	=3D 0,
>>> +};
>>> +
>>> +static struct c_can_platform_data d_can1_pdata =3D {
>>> +	.ram_init	=3D d_can_hw_raminit,
>>> +	.instance	=3D 1,
>>> +};
>>> +
>>> +static const struct of_dev_auxdata am33xx_auxdata_lookup[] __initcon=
st =3D {
>>> +	OF_DEV_AUXDATA("bosch,d_can", 0x481cc000, NULL, &d_can0_pdata),
>>> +	OF_DEV_AUXDATA("bosch,d_can", 0x481d0000, NULL, &d_can1_pdata),
>>> +	{ },
>>> +};
>>> +
>>>  static void __init omap_generic_init(void)
>>>  {
>>>  	omap_sdrc_init(NULL, NULL);
>>> =20
>>> -	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
>>> +	if (of_machine_is_compatible("ti,am33xx"))
>>> +		of_platform_populate(NULL, omap_dt_match_table,
>>> +				am33xx_auxdata_lookup, NULL);
>>> +	else
>>> +		of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
>>>  }
>>> =20
>>>  #ifdef CONFIG_SOC_OMAP2420
>>> diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/cont=
rol.h
>>> index b8cdc85..afd189b 100644
>>> --- a/arch/arm/mach-omap2/control.h
>>> +++ b/arch/arm/mach-omap2/control.h
>>> @@ -356,6 +356,10 @@
>>>  #define AM33XX_CONTROL_STATUS_SYSBOOT1_SHIFT		22
>>>  #define AM33XX_CONTROL_STATUS_SYSBOOT1_MASK		(0x3 << 22)
>>> =20
>>> +/* AM33XX DCAN bitfields */
>>> +#define AM33XX_CONTROL_DCAN_RAMINIT		0x644
>>> +#define AM33XX_DCAN_RAMINIT_START_MASK(i)	(1 << (i))
>>> +
>>>  /* CONTROL OMAP STATUS register to identify OMAP3 features */
>>>  #define OMAP3_CONTROL_OMAP_STATUS	0x044c
>>> =20
>>>
>>
>>
>> --=20
>> Pengutronix e.K.                  | Marc Kleine-Budde           |
>> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
>> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
>> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>>
>>
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigCA70644A624AFB91E01982ED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBFr04ACgkQjTAFq1RaXHOqCwCfUuyHkGsKLBTEBYA63vho3/vl
9REAn2R0HTDVclxKLMy6QSrHAxUY0vHC
=4aWQ
-----END PGP SIGNATURE-----

--------------enigCA70644A624AFB91E01982ED--
