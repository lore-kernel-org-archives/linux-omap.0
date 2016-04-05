From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 2/6] usb: dwc3: omap: don't access DMA bits directly
Date: Tue, 05 Apr 2016 13:29:13 +0300
Message-ID: <87egak4adi.fsf@intel.com>
References: <1459585739-21204-1-git-send-email-felipe.balbi@linux.intel.com> <1459585739-21204-3-git-send-email-felipe.balbi@linux.intel.com> <570271BF.9040902@ti.com> <87y48s4n7y.fsf@intel.com> <570385AB.8060507@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <570385AB.8060507-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbif-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>, Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>, Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Ivan T . Ivanov" <ivan.ivanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> writes:
> On 04/05/2016 08:51 AM, Felipe Balbi wrote:
>> Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> writes:
>>> On 04/02/2016 11:28 AM, Felipe Balbi wrote:
>>>> Instead of having a static global just for
>>>> initializing dma_mask directly, let's use
>>>> dma_coerce_mask_and_coherent() for that.
>>>>
>>>> Signed-off-by: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>>>> ---
>>>>    drivers/usb/dwc3/dwc3-omap.c | 4 +---
>>>>    1 file changed, 1 insertion(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap=
.c
>>>> index 22e9606d8e08..c219118bfda0 100644
>>>> --- a/drivers/usb/dwc3/dwc3-omap.c
>>>> +++ b/drivers/usb/dwc3/dwc3-omap.c
>>>> @@ -331,8 +331,6 @@ static void dwc3_omap_disable_irqs(struct dwc3_oma=
p *omap)
>>>>    	dwc3_omap_write_irqmisc_clr(omap, reg);
>>>>    }
>>>>=20=20=20=20
>>>> -static u64 dwc3_omap_dma_mask =3D DMA_BIT_MASK(32);
>>>> -
>>>>    static int dwc3_omap_id_notifier(struct notifier_block *nb,
>>>>    	unsigned long event, void *ptr)
>>>>    {
>>>> @@ -490,7 +488,7 @@ static int dwc3_omap_probe(struct platform_device =
*pdev)
>>>>    	omap->irq	=3D irq;
>>>>    	omap->base	=3D base;
>>>>    	omap->vbus_reg	=3D vbus_reg;
>>>> -	dev->dma_mask	=3D &dwc3_omap_dma_mask;
>>>> +	dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
>>>
>>> I think, It'll be better to just remove DMA configuration code
>>> from this driver and other drivers which support DT-boot mode only.
>>=20
>> I don't have HW, can you test that on AM57x and/or AM437x ?
>>=20
>
> Yes. I can. With below change I see no issues with USB in Host mode
> on my AM57x board:

what about peripheral side ? Host mode worked fine on K2 devices, only
peripheral suffered from the bad DMA API usage.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXA5N6AAoJEIaOsuA1yqREZtMP/0QxD5kvUbkxruHA6VmnXJhi
QEgR7n6O+3kLbjGRBXeFzhr532YCoTI+eSii9qtEmkzr94InQMYIFMYK5678S2xl
UgNnqXCzatjRFfhXVpxeYGepOum7mlMay+jfI7JH+kQPnhHbG4Tk+iGtOVp5ct6E
sXUm2dS1eVvZuStyjV7Dm2xP0Htao2rwKQ5qsLCNui7rVYouPie7ea/higTBNvMC
EV4ees5WSxTUZTL0IufsiieJ+uuauBgLT5vw9o3q5+KWzw1qL7dWP/eVwKxDLPjD
yvusARJ0Oy/TTb/ddwf2UjINThfwakRx38SfekKLG520cAACfuj1VfiD1HhDt6EU
Szsx3WP0mhOx7vnHaLybg8wEK8auhNC2J3hh4QAZEIivbKA3C8BvrVuxZYUugyAn
4/WIj4c2qbVSDVtWrZUeDdCm7FDv6wwSd5jkMIemKQ06wEpl7Ds0G25ck4oxkbY0
myNh2+FBfH5A/QgZURIE5+SoamhfQn6PXHZJg60Lnzo3+5fHjoT4neGQ/7xESi5B
wdOrQdrX7iGJSWhe6x1YNRnA46vchODrNrRAsVB89SLWLZ7uFhYkTY8trgC3EHCJ
FuR4Yao2az+caPzTd1NNRg9mXDTKONzspzzJZ+WjeYFTFcAekX6A/a/mvpu7tB5y
Y1NQ/Uz34glhsazQiP6J
=NGRH
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
