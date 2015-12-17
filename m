From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 2/3] pwm: Add PWM driver for OMAP using dual-mode timers
Date: Thu, 17 Dec 2015 15:00:35 +0100
Message-ID: <5672C003.3010105@baylibre.com>
References: <5637458D.60106@baylibre.com> <20151216162747.GL28947@ulmo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="skRRp6HvOUA7oj8nRgPhWMh4N6UqKD7dg"
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <20151216162747.GL28947@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Grant Erickson <marathon96@gmail.com>, NeilBrown <neilb@suse.de>, Joachim Eastwood <manabian@gmail.com>
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--skRRp6HvOUA7oj8nRgPhWMh4N6UqKD7dg
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Thierry,
On 12/16/2015 05:27 PM, Thierry Reding wrote:
> I've applied this with some coding style bikeshedding applied. Also I
> think there's a timer leak in the probe function:
Indeed, the coding style had some root for ameliorations ! Thanks !
I also missed this timer leak, thanks for the fix.
>
>> diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmt=
imer.c
> [...]
>> +static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
>> +{
> [...]
>> +	dm_timer =3D pdata->request_by_node(timer);
>> +	if (!dm_timer)
>> +		return -EPROBE_DEFER;
>
> dm_timer holds the requested timer now.
>
>> +
>> +	omap =3D devm_kzalloc(&pdev->dev, sizeof(*omap), GFP_KERNEL);
>> +	if (!omap)
>> +		return -ENOMEM;
>
> But it's not released when this allocation fails...
>
>> +
>> +	omap->pdata =3D pdata;
>> +	omap->dm_timer =3D dm_timer;
>> +	omap->dm_timer_pdev =3D of_find_device_by_node(timer);
>> +	if (!omap->dm_timer_pdev) {
>> +		dev_err(&pdev->dev, "Unable to find timer pdev\n");
>> +		return -EINVAL;
>> +	}
>
> ... nor when this lookup fails. I've taken the liberty of adding two
> calls to omap->pdata->free(dm_timer) to these error paths.
Perfect !

> Please take a look at what's in the pwm/for-next branch to see if it
> still works correctly.
I had a look against my original patch and it should be ok, I will still =
hook it up back
on the real HW in case we forgot something.

> Thanks,
> Thierry
>

Thanks !
Neil



--skRRp6HvOUA7oj8nRgPhWMh4N6UqKD7dg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWcsAHAAoJEHfc29rIyEnRCngQAK8Oh43D3mYiq94hEhOZsKVY
ZWvgrQGt2Lj+/OHy4Z08ljOQokNyFnjm5BPws3CBIql7D/1rj+VXDoQN37u5kNzg
2yf5BTD77Dxr5zJhouIsfn7RKEELA2uUwCXS7qWLa0oRRJH80/CKMsNq0tRTER/e
DkVNYaDZDFwUoWdqwYhtF5mhtPeogHQcs5Dy6e1VlnrETSTJZyP4u4/oGxiMY0Qn
c+3X2h39IOb6FLlEDQzTdX/W6HpMmf0ADh9VEBHFn6yd5AXi9ex/47Udx0As5YWf
SfZ/nxCGzQfijPq99rz175MguwypblTxNt6kJ9VDZOj0ludl3dVY4Z2hcNhtWHpe
tLbRlZMdHpOrP+RLxxXjxBXSglknLCDzkaUaYPLwFHPPDymLwlxAOUwtcP3Y6Vsw
WwybshrOnHG8QKMtCKbnK/VH41+7LP4qf4mVNaC096dbFQ4JPCKbTPOSd13o9Mph
0DeVLb2CJGthXiFKkY9OotT9TWRl5gjvaTZxqMJKS0PSpliwruhnnSFBeGh5Xqhl
yZSRCsYGKOdjzCYzlHF/jw75qzuTMJJMUMkPwvhyOb5RQaAZZOyqEmyx3qrKMszS
Jrlo4ITBn7kw6DPxT8Ny2YHhtxqrmG2s3EHc3647SHLmvxj7eaDmFwZCRAoqJcHn
S5l794WuWuDSiy7Z+P1y
=RShq
-----END PGP SIGNATURE-----

--skRRp6HvOUA7oj8nRgPhWMh4N6UqKD7dg--
