From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH v5 3/3] drivers:power:twl4030-charger: add deferred probing for phy and iio
Date: Fri, 9 Jun 2017 08:05:15 +0200
Message-ID: <01A3D2F5-9E09-4E93-A363-93130DCEB7DF@goldelico.com>
References: <cover.1495363097.git.hns@goldelico.com> <6ed105f6c9c21c24184913a7be9e665453549d79.1495363097.git.hns@goldelico.com> <20170607204444.zumcreuqdnv7euv2@earth>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_93D39F66-F3B5-4E52-8843-97214023E820"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170607204444.zumcreuqdnv7euv2@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--Apple-Mail=_93D39F66-F3B5-4E52-8843-97214023E820
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi,

> Am 07.06.2017 um 22:44 schrieb Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
>=20
> Hi,
>=20
> On Sun, May 21, 2017 at 12:38:18PM +0200, H. Nikolaus Schaller wrote:
>> This fixes an issue if both this twl4030_charger driver and
>> phy-twl4030-usb are compiled as modules and loaded in random order.
>> It has been observed on GTA04 and OpenPandora devices that in worst
>> case the boot process hangs and in best case the AC detection fails
>> with a warning.
>>=20
>> Therefore we add deferred probing checks for the usb_phy and the
>> iio channel for AC detection.
>>=20
>> For implementing this we must reorder code because we can't safely
>> return -EPROBE_DEFER after allocating any devm managed interrupt
>> (it might already/still be enabled without working interrupt =
handler).
>>=20
>> So the check for required resources that may abort probing by
>> returning -EPROBE_DEFER, must come first.
>=20
> This sounds fishy. EPROBE_DEFER should not be different from
> other error codes in this regard and devm_ requested resources
> should be free'd on any error. Why is irq handler not working?

1. there is no other error code involved, before we try to convert the =
driver to handle EPROBE_DEFER.
So it is not that EPROBE_DEFER is special but that we add an error =
return path for it.

2. I don't know why it is not working - I just know that the handler =
seems to be triggered before
all resources are available (if probe() is aborted with EPROBE_DEFER =
error paths) which ends up in kernel panics.

Therefore just to be safe, I have reordered things a little (without =
changing the function):

1. check for resources (with some EPROBE_DEFER)
2. allocate non-devm (with optional EPROBE_DEFER)
3. allocate devm

So this should be safe in any case.

Please also compare a discussion

https://lkml.org/lkml/2013/2/22/65

>=20
>> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
>> ---
>> drivers/power/supply/twl4030_charger.c | 37 =
++++++++++++++++++++--------------
>> 1 file changed, 22 insertions(+), 15 deletions(-)
>>=20
>> diff --git a/drivers/power/supply/twl4030_charger.c =
b/drivers/power/supply/twl4030_charger.c
>> index 785a07bc4f39..945eabdbbc89 100644
>> --- a/drivers/power/supply/twl4030_charger.c
>> +++ b/drivers/power/supply/twl4030_charger.c
>> @@ -984,6 +984,28 @@ static int twl4030_bci_probe(struct =
platform_device *pdev)
>>=20
>> 	platform_set_drvdata(pdev, bci);
>>=20
>> +	if (bci->dev->of_node) {
>> +		struct device_node *phynode;
>> +
>> +		phynode =3D =
of_find_compatible_node(bci->dev->of_node->parent,
>> +						  NULL, =
"ti,twl4030-usb");
>> +		if (phynode) {
>> +			bci->transceiver =3D devm_usb_get_phy_by_node(
>> +				bci->dev, phynode, &bci->usb_nb);
>> +			if (IS_ERR(bci->transceiver) &&
>> +			    PTR_ERR(bci->transceiver) =3D=3D =
-EPROBE_DEFER)
>> +				return -EPROBE_DEFER;	/* PHY not ready =
*/
>> +		}
>> +	}
>> +
>> +	bci->channel_vac =3D iio_channel_get(&pdev->dev, "vac");
>> +	if (IS_ERR(bci->channel_vac)) {
>> +		if (PTR_ERR(bci->channel_vac) =3D=3D -EPROBE_DEFER)
>> +			return -EPROBE_DEFER;	/* iio not ready */
>> +		dev_warn(&pdev->dev, "could not request vac iio =
channel");
>> +		bci->channel_vac =3D NULL;
>> +	}
>> +
>=20
> You should not request non-devm managed iio_channel before
> devm-managed power-supply.

Well, it is not *me* doing that.

It is the unpatched driver which already does. See:

	=
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/power/supply/twl4030_charger.c?h=3Dv4.12-rc4#n1069

I have just moved this line to a different location to be able to add a =
proper EPROBE_DEFER return path.

> This could be fixed by switching to
> devm_iio_channel_get(), which also cleans up some code.

Yes, this could be an alternative solution.
We still need EPROBE_DEFER handling.

>=20
> I suspect, that this is also your IRQ problem, since iio_channel
> is currently free'd before irqs are free'd, but its used in irq
> code.

Hm. No.

In upstream code it is never freed on probe failure because there is =
only
an error return (goto fail) after allocating irqs in case the
twl_i2c_write_u8 fails. Which usually doesn't.

The EPROBE_DEFER returned by iio_channel_get not being ready simply =
prints
a warning and turns off AC detection (bci->channel_vac =3D NULL) =
forever.

>=20
>> 	bci->ac =3D devm_power_supply_register(&pdev->dev, =
&twl4030_bci_ac_desc,
>> 					     NULL);
>> 	if (IS_ERR(bci->ac)) {
>> @@ -1017,25 +1039,10 @@ static int twl4030_bci_probe(struct =
platform_device *pdev)
>> 		return ret;
>> 	}
>>=20
>> -	bci->channel_vac =3D iio_channel_get(&pdev->dev, "vac");
>> -	if (IS_ERR(bci->channel_vac)) {

My first attempt to fix EPROBE_DEFER was to add this

+		if (PTR_ERR(bci->channel_vac) =3D=3D -EPROBE_DEFER)
+			return -EPROBE_DEFER;	/* iio not ready */

>> -		bci->channel_vac =3D NULL;
>> -		dev_warn(&pdev->dev, "could not request vac iio =
channel");
>> -	}
>> -
>> 	INIT_WORK(&bci->work, twl4030_bci_usb_work);
>> 	INIT_DELAYED_WORK(&bci->current_worker, twl4030_current_worker);
>>=20
>> 	bci->usb_nb.notifier_call =3D twl4030_bci_usb_ncb;
>> -	if (bci->dev->of_node) {
>> -		struct device_node *phynode;
>> -
>> -		phynode =3D =
of_find_compatible_node(bci->dev->of_node->parent,
>> -						  NULL, =
"ti,twl4030-usb");
>> -		if (phynode)
>> -			bci->transceiver =3D devm_usb_get_phy_by_node(
>> -				bci->dev, phynode, &bci->usb_nb);

and this

+			if (IS_ERR(bci->transceiver) &&
+			    PTR_ERR(bci->transceiver) =3D=3D =
-EPROBE_DEFER) {
+				ret =3D -EPROBE_DEFER;	/* PHY not ready =
*/
+				goto fail;

This did run (and potentially return) after installing =
devm_request_threaded_irq leading
to observation of severe kernel panics by interrupts.

Moving the iio channel allocation before devm_request_threaded_irq made =
them go away.

>> -	}
>>=20
>> 	/* Enable interrupts now. */
>> 	reg =3D ~(u32)(TWL4030_ICHGLOW | TWL4030_ICHGEOC | =
TWL4030_TBATOR2 |
>=20
> -- Sebastian

How important is it to keep the current sequence of =
devm_request_threaded_irq() + (devm_)iio_channel_get() untouched?

The reason I ask is that it is more likely for (devm_)iio_channel_get() =
to fail than devm_request_threaded_irq().

Hence the iio channel should imho be always allocated first, so that we =
skip allocating+freeing unused irq handlers in case
of iio not being ready.

Therefore, I suggest to keep the proposed reordering even if we think =
devm-conversion of iio_channel_get() alone
would solve it equally well.

Next: should there be two separate patches? One for converting the =
non-devm iio_channel_get() and cleaning up error path.
And one for adding EPROBE_DEFER error path.

Or keep it in a single patch because they only make sense if done =
together (you can't add/remove deferred probing
without converting and/or moving iio_channel_get())?

So please advise how to proceed.

BR and thanks,
Nikolaus


--Apple-Mail=_93D39F66-F3B5-4E52-8843-97214023E820
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJZOjqcAAoJEIl79TGLgAm61PYP/R68/iPVLbcMvyPEPr0y5dxq
gwMR/1eP/tci/0U2W7I/kNiWo+vUX6/Q17BxwGrZO+dmPd4fqEdmi4Xep6lvnbP3
pyUe97IOODCZ9CjxmYI0z1BCu7w1PcXfSAOw3M/qyHhQOj2iId9k2yMFQTsWd1lq
L8SQSTLrrXnP9nNRCeJLe0fXOHwXmPjk69XhBxlt5IFFsujHi6rIgFG57iilKYIU
32zsVImo9bvRKoJGVvJU2UKxnJMmthMJ6D67Kl0/8cuSs8iJ/ZfJHGr6wBFoIogt
LrtXep5IWZPK0ccxVqytlMQ55Rg1IZw+vu4IcbTU/fAxdNwCcDOjVlVBGdsAiiq6
1aGF39f+h4T8GrEzk21R7X+QU3h/uUvZBbJFxDJcAJM3jwm0/IAwzIYz0fzPJq4v
gniAvZCIBp5SfHBJk1dR81jWbOWM3dO5mJGkrhC6a03HFAn+XdETnnX+ddPpRZk7
lOLyCvx7U9LT002YbsBd5pyd33jQcBsZK+Sor6VXHS9sjeMygha8eu+sOMV3zo76
PES/lomgQ/UfHnbkYRF9AgJC1Z7rfQU8Vtnl+HtTINbcGR6sEz9PSOEERgHDGxW9
b70fLtw5PeoVr8D8K3ZErRus3WutrOXearVzFAv2zK+STeKiauV36LelOnKxt4Ma
r3zyBXg4rRhA5+4289/S
=BIvV
-----END PGP SIGNATURE-----

--Apple-Mail=_93D39F66-F3B5-4E52-8843-97214023E820--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
