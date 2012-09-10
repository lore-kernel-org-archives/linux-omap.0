From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/2] pinctrl: pinctrl-single: Add pinctrl-single,bits
 type of mux
Date: Mon, 10 Sep 2012 14:55:30 +0300
Message-ID: <504DD532.4040400@ti.com>
References: <1346835718-21325-1-git-send-email-peter.ujfalusi@ti.com> <1346835718-21325-3-git-send-email-peter.ujfalusi@ti.com> <20120906191019.GZ1303@atomide.com> <504A0F21.8080305@ti.com> <20120907165553.GV1303@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:41839 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751876Ab2IJLy4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Sep 2012 07:54:56 -0400
Received: by obbuo13 with SMTP id uo13so2736082obb.19
        for <linux-omap@vger.kernel.org>; Mon, 10 Sep 2012 04:54:55 -0700 (PDT)
In-Reply-To: <20120907165553.GV1303@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On 09/07/2012 07:55 PM, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [120907 08:13]:
>> On 09/06/2012 10:10 PM, Tony Lindgren wrote:
>>>
>>> Is it now safe to assume that we always have width of three if
>>> pinctrl-single,bits is specified? The reason I'm asking is..
>>>
>>>> @@ -657,18 +664,29 @@ static int pcs_parse_one_pinctrl_entry(struc=
t pcs_device *pcs,
>>>>  {
>>>>  	struct pcs_func_vals *vals;
>>>>  	const __be32 *mux;
>>>> -	int size, rows, *pins, index =3D 0, found =3D 0, res =3D -ENOMEM=
;
>>>> +	int size, params, rows, *pins, index =3D 0, found =3D 0, res =3D=
 -ENOMEM;
>>>>  	struct pcs_function *function;
>>>> =20
>>>> -	mux =3D of_get_property(np, PCS_MUX_NAME, &size);
>>>> -	if ((!mux) || (size < sizeof(*mux) * 2)) {
>>>> -		dev_err(pcs->dev, "bad data for mux %s\n",
>>>> -			np->name);
>>>> +	mux =3D of_get_property(np, PCS_MUX_PINS_NAME, &size);
>>>> +	if (mux) {
>>>> +		params =3D 2;
>>>> +	} else {
>>>> +		mux =3D of_get_property(np, PCS_MUX_BITS_NAME, &size);
>>>> +		if (!mux) {
>>>> +			dev_err(pcs->dev, "no valid property for %s\n",
>>>> +				np->name);
>>>> +			return -EINVAL;
>>>> +		}
>>>> +		params =3D 3;
>>>> +	}
>>>
>>> ..because here we could assume the default value for params is 2
>>> if pinctrl-single,pins is specified, and otherwise params is 3
>>> if pinctrl-single,bits is specified for the controller. That would
>>> avoid querying a potentially non-exiting property for each entry.
>>>
>>>> @@ -686,6 +704,10 @@ static int pcs_parse_one_pinctrl_entry(struct=
 pcs_device *pcs,
>>>>  		val =3D be32_to_cpup(mux + index++);
>>>>  		vals[found].reg =3D pcs->base + offset;
>>>>  		vals[found].val =3D val;
>>>> +		if (params =3D=3D 3) {
>>>> +			val =3D be32_to_cpup(mux + index++);
>>>> +			vals[found].mask =3D val;
>>>> +		}
>>>> =20
>>>>  		pin =3D pcs_get_pin_by_offset(pcs, offset);
>>>>  		if (pin < 0) {
>>>
>>> Here params too would be then set during probe already.
>>
>> I'm afraid you lost me here...
>> We only know if the user specified the mux configuration with
>> pinctrl-single,pins or  pinctrl-single,bits in this function.
>=20
> Sorry right, yeah we don't know that at probe time currently.
>=20
> I'd like to have something that specifies the controller type so
> we don't need to mix two types of controllers and test for
> non-existing properties when parsing the pins.
>=20
> How about we require something specified for the pinctrl driver
> in the "one-bit-per-mux" case like pinctrl-single,bit-per-mux?
>=20
> And then in the pinctrl-single probe we set params =3D 3 if
> pinctrl-single,bit-per-mux is specified. And if no
> pinctrl-single,bit-per-mux is specified then set params =3D 2.
>=20
> That way pcs_parse_one_pinctrl_entry() can just test for params.
>=20
> Sorry I don't have a better name in mind than bit-per-mux..

I'm not sure if this would make things more prone to error or make the =
DTS or
the code more clean in any ways.

Both pinctrl-single,pins and pinctrl-single,bits works on top of the sa=
me
pinctrl-single area.
In most cases we are going to use pinctrl-single,pins for the mux
configuration and only in few places we need to fall back to pinctrl-si=
ngle,bits.

With this patch we will have maximum of two query to find out which typ=
e is
used, while if we add the 'bit-per-mux' property we will always have ne=
ed to
have two of_get_property() call to figure out what is used.
IMHO in this way we could also have copy-paste errors coming at us when=
 adding
the mux configurations for the pins and at the end we also need to do s=
ame
safety/sanity checks if the user really provided the correct type with
correlation to the 'bit-per-mux'.

This would just complicate the code.
The existence of pinctrl-single,pins or pinctrl-single,bits property al=
one
gives enough information for the number of parameters.

> =20
>> One thing I could do to make the code a bit better to look at is:
>> int params =3D 2;
>>
>> mux =3D of_get_property(np, PCS_MUX_PINS_NAME, &size);
>> if (!mux) {
>> 	mux =3D of_get_property(np, PCS_MUX_BITS_NAME, &size);
>> 	if (!mux) {
>> 		dev_err(pcs->dev, "no valid property for %s\n",
>> 		np->name);
>> 		return -EINVAL;
>> 	}
>> 	params =3D 3;
>> }
>>
>> This might make the code a bit more compact but at the same time one=
 might
>> need to spend few more seconds to understand it.
>=20
> Yes well there's no need to do of_get_property second guessing
> if we already know params from the pinctrl-single.c probe time.
>=20
> I think we're safe to assume that we don't need to mix parsing
> two different types of configuration for the same controller
> as they can always be set up as separate controllers.
>=20
> Regards,
>=20
> Tony
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
