From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCHv3] tlv320dac33: Add device tree bindings
Date: Mon, 5 Mar 2018 14:52:06 +0200
Message-ID: <3edfbd7c-c8f8-f031-30d2-90b441e63688@ti.com>
References: <20180129230539.GA18280@amd> <20180131190112.GA31608@amd>
 <20b9ff40-a869-a165-07a2-2a103830efb3@ti.com> <20180205082445.GA18274@amd>
 <20180206121122.GG5681@sirena.org.uk> <20180206134906.GA7842@amd>
 <20180206152722.GH5681@sirena.org.uk> <20180224205704.GB5132@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180224205704.GB5132@amd>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Machek <pavel@ucw.cz>, Mark Brown <broonie@kernel.org>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, tony@atomide.com, abcloriens@gmail.com, tiwai@suse.com, martijn@brixit.nl, =?UTF-8?Q?Filip_Matijevi=c4=87?= <filip.matijevic.pz@gmail.com>, patrikbachan@gmail.com, ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, serge@hallyn.com, devicetree@vger.kernel.org, pali.rohar@gmail.com, robh+dt@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, aaro.koskinen@iki.fi, linux-kernel@vger.kernel.org, clayton@craftyguy.net, sakari.ailus@linux.intel.com, sre@kernel.org, bhumirks@gmail.com
List-Id: linux-omap@vger.kernel.org

Hi,

On 2018-02-24 22:57, Pavel Machek wrote:
> On Tue 2018-02-06 15:27:22, Mark Brown wrote:
>> On Tue, Feb 06, 2018 at 02:49:06PM +0100, Pavel Machek wrote:
>>> On Tue 2018-02-06 12:11:22, Mark Brown wrote:
>>
>>>> Please submit patches using subject lines reflecting the style for the
>>>> subsystem.  This makes it easier for people to identify relevant
>>>> patches.  Look at what existing commits in the area you're changing are
>>>> doing and make sure your subject lines visually resemble what they're
>>>> doing.
>>
>>> AFAICT this goes to Documentation, not sound.
>>
>> Even if that were the case you're not following the commonly accepted
>> practice there either.
>>
>>> If you have any comments on V1 of this patch, that would be nice, I'd
>>> like to get that merged once we are finished with the bindings.
>>
>> It is the middle of the merge window, please be a bit more patient.
> =

> For the record, patch currently looks like this. If you have some
> comments on the code, I'd like to hear them.
> =

> Best regards,
> diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac3=
3.c
> index 8c71d2f..7302789 100644
> --- a/sound/soc/codecs/tlv320dac33.c
> +++ b/sound/soc/codecs/tlv320dac33.c

...

> @@ -1511,10 +1509,26 @@ static int dac33_i2c_probe(struct i2c_client *cli=
ent,
>  =

>  	i2c_set_clientdata(client, dac33);
>  =

> -	dac33->power_gpio =3D pdata->power_gpio;
> -	dac33->burst_bclkdiv =3D pdata->burst_bclkdiv;
> -	dac33->keep_bclk =3D pdata->keep_bclk;
> -	dac33->mode1_latency =3D pdata->mode1_latency;
> +	if (pdata) {
> +		dac33->power_gpio =3D pdata->power_gpio;
> +		dac33->burst_bclkdiv =3D pdata->burst_bclkdiv;
> +		dac33->keep_bclk =3D pdata->keep_bclk;
> +		dac33->mode1_latency =3D pdata->mode1_latency;
> +	} else if (np) {
> +		ret =3D of_get_named_gpio(np, "power-gpios", 0);
> +		if (ret >=3D 0)
> +			dac33->power_gpio =3D ret;
> +		else
> +			dac33->power_gpio =3D -1;

the code checks for (dac33->power_gpio >=3D 0) in live path, I guess you
can just skip the power_gpio =3D -1 in case we don't have GPIO
Handling of EPROBE_DEFER might be something we might want for the GPIO.

> +
> +		if (of_property_read_bool(np, "ti,keep-bclk"))
> +			dac33->keep_bclk =3D true;
> +
> +		of_property_read_u32(np, "ti,burst-bclkdiv", &dac33->burst_bclkdiv);
> +	} else {
> +		dev_err(&client->dev, "Platform data not set\n");
> +		return -ENODEV;
> +	}
>  	if (!dac33->mode1_latency)
>  		dac33->mode1_latency =3D 10000; /* 10ms */
>  	dac33->irq =3D client->irq;
> @@ -1580,9 +1594,16 @@ static const struct i2c_device_id tlv320dac33_i2c_=
id[] =3D {
>  };
>  MODULE_DEVICE_TABLE(i2c, tlv320dac33_i2c_id);
>  =

> +static const struct of_device_id tlv320dac33_of_match[] =3D {
> +	{ .compatible =3D "ti,tlv320dac33", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, tlv320dac33_of_match);
> +
>  static struct i2c_driver tlv320dac33_i2c_driver =3D {
>  	.driver =3D {
>  		.name =3D "tlv320dac33-codec",
> +		.of_match_table =3D of_match_ptr(tlv320dac33_of_match),
>  	},
>  	.probe		=3D dac33_i2c_probe,
>  	.remove		=3D dac33_i2c_remove,
> =

> =


- P=E9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
