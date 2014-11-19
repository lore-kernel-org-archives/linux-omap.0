From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v2 1/5] video: omapdss: Add opa362 driver
Date: Wed, 19 Nov 2014 16:10:26 +0100
Message-ID: <BF6765C1-8D5C-4ABA-8796-195058C82E17@goldelico.com>
References: <1415830247-31633-1-git-send-email-marek@goldelico.com> <1415830247-31633-2-git-send-email-marek@goldelico.com> <54649B43.1000801@ti.com> <9FD016B8-4EA2-4A0D-B790-6494AB449B31@goldelico.com> <5464DF26.2010707@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5464DF26.2010707@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Marek Belisko <marek@goldelico.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, grant.likely@linaro.org, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, gta04-owner@goldelico.com
List-Id: linux-omap@vger.kernel.org


Am 13.11.2014 um 17:41 schrieb Tomi Valkeinen <tomi.valkeinen@ti.com>:

> On 13/11/14 18:25, Dr. H. Nikolaus Schaller wrote:
>> Hi,
>>=20
>> Am 13.11.2014 um 12:51 schrieb Tomi Valkeinen <tomi.valkeinen@ti.com=
>:
>>=20
>>> On 13/11/14 00:10, Marek Belisko wrote:
>>>> opa362 is amplifier for video and can be connected to the tvout pa=
ds
>>>> of the OMAP3. It has one gpio control for enable/disable of the ou=
tput
>>>> (high impedance).
>>>>=20
>>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>>> ---
>>>> drivers/video/fbdev/omap2/displays-new/Kconfig     |   6 +
>>>> drivers/video/fbdev/omap2/displays-new/Makefile    |   1 +
>>>> .../fbdev/omap2/displays-new/amplifier-opa362.c    | 343 +++++++++=
++++++++++++
>>>=20
>>> I think it would be better to rename this to encoder-opa362.c. It's=
 not
>>=20
>> When developing this driver we did simply rename the encoder-tfp410 =
file,
>> but thent hough that it does not fit into the =84encoder=93 category=
, because we
>> would expect something digital or digital to analog =84encoding=93 w=
hich it does not.
>=20
> That is true, but we already have other "encoders" like
> encoder-tpd12s015.c, which also do not encode. "encoder" in this cont=
ext
> means something that takes a video input, and has a video output. In
> contrast to a panel or a connector.
>=20
>>>> +
>>>> +	in->ops.atv->set_timings(in, &ddata->timings);
>>>> +	/* fixme: should we receive the invert from our consumer, i.e. t=
he connector? */
>>>> +	in->ops.atv->invert_vid_out_polarity(in, true);
>>>=20
>>> Well this does seem to be broken. I don't know what the answer to t=
he
>>> question above is, but the code doesn't work properly.
>>>=20
>>> In the opa362_invert_vid_out_polarity function below, you get the i=
nvert
>>> boolean from the connector. This you pass to the OMAP venc. However=
,
>>> above you always override that value in venc with true.
>>>=20
>>> So, either the invert_vid_out_polarity value has to be always true =
or
>>> false, because _OPA362_ requires it to be true or false, OR you nee=
d use
>>> the value from the connector.
>>>=20
>>> Seeing the comment in opa362_invert_vid_out_polarity, my guess is t=
he
>>> latter, and the call above should be removed.
>>=20
>> Yes, you are right - this is not systematic.
>>=20
>> But the problem is that we can=92t ask the connector here what it wa=
nts
>> to see. It might (or might not) call our opa362_invert_vid_out_polar=
ity() later
>> which we can then forward to overwrite the inital state of this opa3=
62_enable().
>=20
> You don't need to ask. The connector calls invert_vid_out_polarity
> before enabling the output.

Unfortunately it doesn=92t. At least not always.

It does only for pdata systems but not for DT based systems:

	if (!ddata->dev->of_node) {
		in->ops.atv->set_type(in, ddata->connector_type);
		in->ops.atv->invert_vid_out_polarity(in,
			ddata->invert_polarity);
	}

Not calling is in our case different from calling with ddata->invert_po=
larity =3D=3D 0.

> You can just pass it forward inverted, as
> you already do in this driver. If it doesn't, it's either a bug or yo=
u
> can just rely on the value that is already programmed to venc.

Therefore it is not called with =93false=94 which would make our invert=
_vid_out_polarity
invert it and send =93true=94 towards the VENC. So VENC remains non-inv=
erted.

We will also add a patch for the connector-analog.c

>>> We are going to support only DT boot at some point. Thus I think th=
e
>>> whole platform data code should be left out.
>>=20
>> Is there already a decision? I think it should not be done before. A=
nd it
>> does not harm to still have it.
>=20
> It's just a matter of time. I don't accept any new boards using platf=
orm
> data for display, or new display drivers using platform data, because=
 I
> don't want to spend my time converting them later. And as this is a n=
ew
> driver, no existing board can be using the opa362 platform_data. So w=
e
> can support DT only.

Ok, that looks reasonable - as long as we can rely on that all mainline=
 DSS
drivers are already fully converted to DT :)

BR,
Nikolaus
