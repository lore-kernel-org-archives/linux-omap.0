From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 09/11] mfd: twl-core: Collect global variables behind
 one private structure (global)
Date: Sat, 9 Feb 2013 06:50:49 +0100
Message-ID: <5115E3B9.6090100@ti.com>
References: <1358344439-23017-1-git-send-email-peter.ujfalusi@ti.com> <1358344439-23017-10-git-send-email-peter.ujfalusi@ti.com> <51154A7A.2010709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51154A7A.2010709@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

On 02/08/2013 07:56 PM, Jon Hunter wrote:
>>  /**
>>   * twl_i2c_write - Writes a n bit register in TWL4030/TWL5030/TWL60=
X0
>>   * @mod_no: module number
>> @@ -322,16 +323,17 @@ int twl_i2c_write(u8 mod_no, u8 *value, u8 reg=
, unsigned num_bytes)
>>  		pr_err("%s: invalid module number %d\n", DRIVER_NAME, mod_no);
>>  		return -EPERM;
>>  	}
>> -	if (unlikely(!inuse)) {
>> +	if (unlikely(!twl_priv->ready)) {
>=20
> This is causing the kernel to panic on all my omap2 boards when booti=
ng linux-next
> because twl_priv is not initialised yet.

Good catch.
I just wonder from where the twl_* call is coming on OMAP2. AFAIK the t=
wl code
is for OMAP3/4, for OMAP2 Menelaus is the one which is used.
I'm currently working on to remove all those twl_* calls from random pl=
aces in
the kernel so we will only access twl via the MFD stack.

>=20
>>  		pr_err("%s: not initialized\n", DRIVER_NAME);
>>  		return -EPERM;
>>  	}
>> =20
>> -	sid =3D twl_map[mod_no].sid;
>> -	twl =3D &twl_modules[sid];
>> +	sid =3D twl_priv->twl_map[mod_no].sid;
>> +	twl =3D &twl_priv->twl_modules[sid];
>> =20
>> -	ret =3D regmap_bulk_write(twl->regmap, twl_map[mod_no].base + reg,
>> -				value, num_bytes);
>> +	ret =3D regmap_bulk_write(twl->regmap,
>> +				twl_priv->twl_map[mod_no].base + reg, value,
>> +				num_bytes);
>> =20
>>  	if (ret)
>>  		pr_err("%s: Write failed (mod %d, reg 0x%02x count %d)\n",
>> @@ -360,16 +362,17 @@ int twl_i2c_read(u8 mod_no, u8 *value, u8 reg,=
 unsigned num_bytes)
>>  		pr_err("%s: invalid module number %d\n", DRIVER_NAME, mod_no);
>>  		return -EPERM;
>>  	}
>> -	if (unlikely(!inuse)) {
>> +	if (unlikely(!twl_priv->ready)) {
>=20
> Same problem here.=20
>=20
> Here is a fix ...
>=20
> From 141fcbbdee6bdc14d5a444ff20fad6b3440215dc Mon Sep 17 00:00:00 200=
1
> From: Jon Hunter <jon-hunter@ti.com>
> Date: Fri, 8 Feb 2013 12:42:20 -0600
> Subject: [PATCH] ARM: OMAP2+: Fix kernel panic on boot
>=20
> Commit 8a6aaa3 (mfd: twl-core: Collect global variables behind one
> private structure (global)) removed the variable "inuse" that is used
> to determine if the device has been initialised and now use the
> twl_priv structure instead. This is causing the kernel to panic on al=
l
> OMAP2+ devices, because we try to access the twl_priv->ready member
> before checking if twl_priv is initialised. Fix this and move this te=
st
> to the beginning of the twl_i2c_read/write function because
> twl_get_last_module() also uses the twl_priv structure.
>=20
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
>  drivers/mfd/twl-core.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index 557f9ee..89ab4d9 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -316,12 +316,12 @@ int twl_i2c_write(u8 mod_no, u8 *value, u8 reg,=
 unsigned num_bytes)
>  	int sid;
>  	struct twl_client *twl;
> =20
> -	if (unlikely(mod_no >=3D twl_get_last_module())) {
> -		pr_err("%s: invalid module number %d\n", DRIVER_NAME, mod_no);
> +	if (unlikely(!twl_priv || !twl_priv->ready)) {
> +		pr_err("%s: not initialized\n", DRIVER_NAME);
>  		return -EPERM;
>  	}
> -	if (unlikely(!twl_priv->ready)) {
> -		pr_err("%s: not initialized\n", DRIVER_NAME);
> +	if (unlikely(mod_no >=3D twl_get_last_module())) {
> +		pr_err("%s: invalid module number %d\n", DRIVER_NAME, mod_no);
>  		return -EPERM;
>  	}
> =20
> @@ -355,12 +355,12 @@ int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, =
unsigned num_bytes)
>  	int sid;
>  	struct twl_client *twl;
> =20
> -	if (unlikely(mod_no >=3D twl_get_last_module())) {
> -		pr_err("%s: invalid module number %d\n", DRIVER_NAME, mod_no);
> +	if (unlikely(!twl_priv || !twl_priv->ready)) {
> +		pr_err("%s: not initialized\n", DRIVER_NAME);
>  		return -EPERM;
>  	}
> -	if (unlikely(!twl_priv->ready)) {
> -		pr_err("%s: not initialized\n", DRIVER_NAME);
> +	if (unlikely(mod_no >=3D twl_get_last_module())) {
> +		pr_err("%s: invalid module number %d\n", DRIVER_NAME, mod_no);
>  		return -EPERM;
>  	}
> =20
>=20


--=20
P=E9ter
