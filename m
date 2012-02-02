From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC 7/7] MFD: TWL6040: Add regulator support for
	VIO, V2V1 supplies
Date: Thu, 02 Feb 2012 15:59:20 +0200
Message-ID: <4F2A96B8.2030004@ti.com>
References: <1328185019-29575-1-git-send-email-peter.ujfalusi@ti.com>
	<1328185019-29575-8-git-send-email-peter.ujfalusi@ti.com>
	<20120202125250.GJ7428@opensource.wolfsonmicro.com>
	<4F2A8D11.9010705@ti.com>
	<20120202133207.GN7428@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20120202133207.GN7428@opensource.wolfsonmicro.com>
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

On 02/02/2012 03:32 PM, Mark Brown wrote:
> That's not a problem for using the bulk get - the array is part of the
> API so you can use regulator_bulk_get() and still look at individual
> supplies within the array later on when enabling and disabling them.

For some reason I have associated the use of regulator_bulk_get with the
use of regulator_bulk_enable/disable. It did not even crossed my mind
that I can still use regulator_enable on the individual regulators.
Will convert the regulator_get/put to bulk operations. It will make the
code a bit cleaner.
Thanks

>>>> +	ret =3D regulator_enable(twl6040->vio);
>>>> +	if (ret !=3D 0) {
>>>> +		dev_err(&client->dev, "Failed to enable VIO: %d\n", ret);
>>>> +		goto power_err;
>>>> +	}
>>>> +	ret =3D regulator_enable(twl6040->v2v1);
>>>> +	if (ret !=3D 0) {
>>>> +		dev_err(&client->dev, "Failed to enable V2V1: %d\n", ret);
>>>> +		regulator_disable(twl6040->vio);
> =

>> I disable the vio here, if the v2v1 enable fails.
> =

> Oh, that's quite confusing when mixed in with the goto/unwind - it'd be
> clearer to have the extra lable to jump to.

I guess this is a matter of taste.
However I have found some inconsistent naming with the exit labels,
which I'm going to fix for the next series.

-- =

P=E9ter
