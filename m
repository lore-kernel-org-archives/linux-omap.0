From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/2] pinctrl: pinctrl-single: Add pinctrl-single,bits
 type of mux
Date: Fri, 07 Sep 2012 18:13:37 +0300
Message-ID: <504A0F21.8080305@ti.com>
References: <1346835718-21325-1-git-send-email-peter.ujfalusi@ti.com> <1346835718-21325-3-git-send-email-peter.ujfalusi@ti.com> <20120906191019.GZ1303@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120906191019.GZ1303@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 09/06/2012 10:10 PM, Tony Lindgren wrote:
> Hi Peter,
>=20
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [120905 02:02]:
>> With pinctrl-single,bits it is possible to update just part of the r=
egister
>> within the pinctrl-single,function-mask area.
>> This is useful when one register configures mmore than one pin's mux=
=2E
>=20
> You have a typo here:                         ^^^^^

Oh, I'll fix this up.

>> --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
>> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
>> @@ -31,6 +31,15 @@ device pinctrl register, and 0x118 contains the d=
esired value of the
>>  pinctrl register. See the device example and static board pins exam=
ple
>>  below for more information.
>> =20
>> +In case when one register changes more than one pin's mux the
>> +pinctrl-single,bits can be used which takes three parameters:
>> +
>> +	pinctrl-single,bits =3D <0xdc 0x18, 0xff>;
>> +
>> +Where 0xdc is the offset from the pinctrl register base address for=
 the
>> +device pinctrl register, 0x18 is the desired value, and 0xff is the=
 sub mask to
>> +be used when applying this change to the register.
>> +
>=20
> Is it now safe to assume that we always have width of three if
> pinctrl-single,bits is specified? The reason I'm asking is..
>=20
>> @@ -657,18 +664,29 @@ static int pcs_parse_one_pinctrl_entry(struct =
pcs_device *pcs,
>>  {
>>  	struct pcs_func_vals *vals;
>>  	const __be32 *mux;
>> -	int size, rows, *pins, index =3D 0, found =3D 0, res =3D -ENOMEM;
>> +	int size, params, rows, *pins, index =3D 0, found =3D 0, res =3D -=
ENOMEM;
>>  	struct pcs_function *function;
>> =20
>> -	mux =3D of_get_property(np, PCS_MUX_NAME, &size);
>> -	if ((!mux) || (size < sizeof(*mux) * 2)) {
>> -		dev_err(pcs->dev, "bad data for mux %s\n",
>> -			np->name);
>> +	mux =3D of_get_property(np, PCS_MUX_PINS_NAME, &size);
>> +	if (mux) {
>> +		params =3D 2;
>> +	} else {
>> +		mux =3D of_get_property(np, PCS_MUX_BITS_NAME, &size);
>> +		if (!mux) {
>> +			dev_err(pcs->dev, "no valid property for %s\n",
>> +				np->name);
>> +			return -EINVAL;
>> +		}
>> +		params =3D 3;
>> +	}
>=20
> ..because here we could assume the default value for params is 2
> if pinctrl-single,pins is specified, and otherwise params is 3
> if pinctrl-single,bits is specified for the controller. That would
> avoid querying a potentially non-exiting property for each entry.
>=20
>> @@ -686,6 +704,10 @@ static int pcs_parse_one_pinctrl_entry(struct p=
cs_device *pcs,
>>  		val =3D be32_to_cpup(mux + index++);
>>  		vals[found].reg =3D pcs->base + offset;
>>  		vals[found].val =3D val;
>> +		if (params =3D=3D 3) {
>> +			val =3D be32_to_cpup(mux + index++);
>> +			vals[found].mask =3D val;
>> +		}
>> =20
>>  		pin =3D pcs_get_pin_by_offset(pcs, offset);
>>  		if (pin < 0) {
>=20
> Here params too would be then set during probe already.

I'm afraid you lost me here...
We only know if the user specified the mux configuration with
pinctrl-single,pins or  pinctrl-single,bits in this function.

One thing I could do to make the code a bit better to look at is:
int params =3D 2;

mux =3D of_get_property(np, PCS_MUX_PINS_NAME, &size);
if (!mux) {
	mux =3D of_get_property(np, PCS_MUX_BITS_NAME, &size);
	if (!mux) {
		dev_err(pcs->dev, "no valid property for %s\n",
		np->name);
		return -EINVAL;
	}
	params =3D 3;
}

This might make the code a bit more compact but at the same time one mi=
ght
need to spend few more seconds to understand it.

Regards,
P=E9ter
