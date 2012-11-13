From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] usb: otg: twl4030: Change TWL4030_MODULE_* ids to TWL_MODULE_*
Date: Tue, 13 Nov 2012 11:28:15 +0100
Message-ID: <50A220BF.7020901@ti.com>
References: <1352799818-22363-1-git-send-email-peter.ujfalusi@ti.com> <20121113094722.GB10395@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121113094722.GB10395@arwen.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On 11/13/2012 10:47 AM, Felipe Balbi wrote:
> On Tue, Nov 13, 2012 at 10:43:38AM +0100, Peter Ujfalusi wrote:
>> To facilitate upcoming cleanup in twl stack.
>> No functional changes.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>=20
> I guess this one must go together with the rest of your series...

I made the split between the patches and they are good to go in their s=
eparate
ways to avoid cross tree hassle.
All of the defines were in place originally but they were used in non
consistent ways.
All of these will help in the future to clean up the twl core without b=
reaking
the child drivers.

--=20
P=E9ter

> Acked-by: Felipe Balbi <balbi@ti.com>
>=20
>> ---
>>  drivers/usb/otg/twl4030-usb.c | 46 ++++++++++++++++++++------------=
-----------
>>  1 file changed, 21 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030=
-usb.c
>> index f0d2e75..11b2a12 100644
>> --- a/drivers/usb/otg/twl4030-usb.c
>> +++ b/drivers/usb/otg/twl4030-usb.c
>> @@ -123,10 +123,10 @@
>>  #define PHY_CLK_CTRL_STS		0xFF
>>  #define PHY_DPLL_CLK			(1 << 0)
>> =20
>> -/* In module TWL4030_MODULE_PM_MASTER */
>> +/* In module TWL_MODULE_PM_MASTER */
>>  #define STS_HW_CONDITIONS		0x0F
>> =20
>> -/* In module TWL4030_MODULE_PM_RECEIVER */
>> +/* In module TWL_MODULE_PM_RECEIVER */
>>  #define VUSB_DEDICATED1			0x7D
>>  #define VUSB_DEDICATED2			0x7E
>>  #define VUSB1V5_DEV_GRP			0x71
>> @@ -195,14 +195,14 @@ static int twl4030_i2c_write_u8_verify(struct =
twl4030_usb *twl,
>>  }
>> =20
>>  #define twl4030_usb_write_verify(twl, address, data)	\
>> -	twl4030_i2c_write_u8_verify(twl, TWL4030_MODULE_USB, (data), (addr=
ess))
>> +	twl4030_i2c_write_u8_verify(twl, TWL_MODULE_USB, (data), (address)=
)
>> =20
>>  static inline int twl4030_usb_write(struct twl4030_usb *twl,
>>  		u8 address, u8 data)
>>  {
>>  	int ret =3D 0;
>> =20
>> -	ret =3D twl_i2c_write_u8(TWL4030_MODULE_USB, data, address);
>> +	ret =3D twl_i2c_write_u8(TWL_MODULE_USB, data, address);
>>  	if (ret < 0)
>>  		dev_dbg(twl->dev,
>>  			"TWL4030:USB:Write[0x%x] Error %d\n", address, ret);
>> @@ -227,7 +227,7 @@ static inline int twl4030_readb(struct twl4030_u=
sb *twl, u8 module, u8 address)
>> =20
>>  static inline int twl4030_usb_read(struct twl4030_usb *twl, u8 addr=
ess)
>>  {
>> -	return twl4030_readb(twl, TWL4030_MODULE_USB, address);
>> +	return twl4030_readb(twl, TWL_MODULE_USB, address);
>>  }
>> =20
>>  /*-----------------------------------------------------------------=
--------*/
>> @@ -264,8 +264,7 @@ static enum omap_musb_vbus_id_status
>>  	 * signal is active, the OTG module is activated, and
>>  	 * its interrupt may be raised (may wake the system).
>>  	 */
>> -	status =3D twl4030_readb(twl, TWL4030_MODULE_PM_MASTER,
>> -			STS_HW_CONDITIONS);
>> +	status =3D twl4030_readb(twl, TWL_MODULE_PM_MASTER, STS_HW_CONDITI=
ONS);
>>  	if (status < 0)
>>  		dev_err(twl->dev, "USB link status err %d\n", status);
>>  	else if (status & (BIT(7) | BIT(2))) {
>> @@ -372,8 +371,7 @@ static void twl4030_phy_power(struct twl4030_usb=
 *twl, int on)
>>  		 * SLEEP. We work around this by clearing the bit after usv3v1
>>  		 * is re-activated. This ensures that VUSB3V1 is really active.
>>  		 */
>> -		twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0,
>> -							VUSB_DEDICATED2);
>> +		twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER, 0, VUSB_DEDICATED2);
>>  		regulator_enable(twl->usb1v5);
>>  		__twl4030_phy_power(twl, 1);
>>  		twl4030_usb_write(twl, PHY_CLK_CTRL,
>> @@ -419,50 +417,48 @@ static void twl4030_phy_resume(struct twl4030_=
usb *twl)
>>  static int twl4030_usb_ldo_init(struct twl4030_usb *twl)
>>  {
>>  	/* Enable writing to power configuration registers */
>> -	twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER,
>> -			TWL4030_PM_MASTER_KEY_CFG1,
>> -			TWL4030_PM_MASTER_PROTECT_KEY);
>> +	twl_i2c_write_u8(TWL_MODULE_PM_MASTER, TWL4030_PM_MASTER_KEY_CFG1,
>> +			 TWL4030_PM_MASTER_PROTECT_KEY);
>> =20
>> -	twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER,
>> -			TWL4030_PM_MASTER_KEY_CFG2,
>> -			TWL4030_PM_MASTER_PROTECT_KEY);
>> +	twl_i2c_write_u8(TWL_MODULE_PM_MASTER, TWL4030_PM_MASTER_KEY_CFG2,
>> +			 TWL4030_PM_MASTER_PROTECT_KEY);
>> =20
>>  	/* Keep VUSB3V1 LDO in sleep state until VBUS/ID change detected*/
>> -	/*twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB_DEDICATED2)=
;*/
>> +	/*twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER, 0, VUSB_DEDICATED2);*/
>> =20
>>  	/* input to VUSB3V1 LDO is from VBAT, not VBUS */
>> -	twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x14, VUSB_DEDICATED1=
);
>> +	twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER, 0x14, VUSB_DEDICATED1);
>> =20
>>  	/* Initialize 3.1V regulator */
>> -	twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB3V1_DEV_GRP);
>> +	twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER, 0, VUSB3V1_DEV_GRP);
>> =20
>>  	twl->usb3v1 =3D regulator_get(twl->dev, "usb3v1");
>>  	if (IS_ERR(twl->usb3v1))
>>  		return -ENODEV;
>> =20
>> -	twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB3V1_TYPE);
>> +	twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER, 0, VUSB3V1_TYPE);
>> =20
>>  	/* Initialize 1.5V regulator */
>> -	twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB1V5_DEV_GRP);
>> +	twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER, 0, VUSB1V5_DEV_GRP);
>> =20
>>  	twl->usb1v5 =3D regulator_get(twl->dev, "usb1v5");
>>  	if (IS_ERR(twl->usb1v5))
>>  		goto fail1;
>> =20
>> -	twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB1V5_TYPE);
>> +	twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER, 0, VUSB1V5_TYPE);
>> =20
>>  	/* Initialize 1.8V regulator */
>> -	twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB1V8_DEV_GRP);
>> +	twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER, 0, VUSB1V8_DEV_GRP);
>> =20
>>  	twl->usb1v8 =3D regulator_get(twl->dev, "usb1v8");
>>  	if (IS_ERR(twl->usb1v8))
>>  		goto fail2;
>> =20
>> -	twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB1V8_TYPE);
>> +	twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER, 0, VUSB1V8_TYPE);
>> =20
>>  	/* disable access to power configuration registers */
>> -	twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0,
>> -			TWL4030_PM_MASTER_PROTECT_KEY);
>> +	twl_i2c_write_u8(TWL_MODULE_PM_MASTER, 0,
>> +			 TWL4030_PM_MASTER_PROTECT_KEY);
>> =20
>>  	return 0;
>> =20
>> --=20
>> 1.8.0
>>
>=20
