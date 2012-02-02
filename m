From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC 7/7] MFD: TWL6040: Add regulator support for
	VIO, V2V1 supplies
Date: Thu, 02 Feb 2012 15:18:09 +0200
Message-ID: <4F2A8D11.9010705@ti.com>
References: <1328185019-29575-1-git-send-email-peter.ujfalusi@ti.com>
	<1328185019-29575-8-git-send-email-peter.ujfalusi@ti.com>
	<20120202125250.GJ7428@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20120202125250.GJ7428@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dtor@mail.ru>, linux-kernel@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 02/02/2012 02:52 PM, Mark Brown wrote:
> On Thu, Feb 02, 2012 at 02:16:59PM +0200, Peter Ujfalusi wrote:
> =

>> +	twl6040->vio =3D regulator_get(&client->dev, "vio");
>> +	if (IS_ERR(twl6040->vio)) {
>> +		ret =3D PTR_ERR(twl6040->vio);
>> +		dev_err(&client->dev, "Failed to request VIO supply: %d\n",
>> +			ret);
>> +		goto regulator_get_err;
>> +	}
>> +	twl6040->v2v1 =3D regulator_get(&client->dev, "v2v1");
>> +	if (IS_ERR(twl6040->v2v1)) {
>> +		ret =3D PTR_ERR(twl6040->v2v1);
>> +		dev_err(&client->dev, "Failed to request V2V1 supply: %d\n",
>> +			ret);
>> +		regulator_put(twl6040->vio);
>> +		goto regulator_get_err;
>> +	}
> =

> Looks like you want regulator_bulk_get() here.  Or (better yet though
> it'd be a potential issue for merge via MFD and the benefits aren't that
> exciting since you still need to disable) devm_regulator_bulk_get().

I need separate control for the two power source since we can hit
different power levels depending on which is powered/not powered:
power down: vio, v2v1 is OFF
deep sleep: vio is ON, v2v1 is OFF
sleep/power on: vio, v2v1 is ON

And we have certain sequence to move between power states.

> =

>> +	ret =3D regulator_enable(twl6040->vio);
>> +	if (ret !=3D 0) {
>> +		dev_err(&client->dev, "Failed to enable VIO: %d\n", ret);
>> +		goto power_err;
>> +	}
>> +	ret =3D regulator_enable(twl6040->v2v1);
>> +	if (ret !=3D 0) {
>> +		dev_err(&client->dev, "Failed to enable V2V1: %d\n", ret);
>> +		regulator_disable(twl6040->vio);

I disable the vio here, if the v2v1 enable fails.

>> +		goto power_err;
>> +	}
> =

> Similarly regulator_bulk_enable() here, and it'll fix...
> =

>>  gpio1_err:
>> +	regulator_disable(twl6040->v2v1);
>> +	regulator_disable(twl6040->vio);
> =

> ...the fact that if you fail to enable the v2.1 regulator you don't
> disable vio.

It is handled within the if(){}
With the devm_regulator this will be much nicer for sure.

-- =

P=E9ter
