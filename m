From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 2/6] usb: dwc3: omap: don't access DMA bits directly
Date: Tue, 05 Apr 2016 08:51:45 +0300
Message-ID: <87y48s4n7y.fsf@intel.com>
References: <1459585739-21204-1-git-send-email-felipe.balbi@linux.intel.com> <1459585739-21204-3-git-send-email-felipe.balbi@linux.intel.com> <570271BF.9040902@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <570271BF.9040902-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbif-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>, Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>, Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Ivan T . Ivanov" <ivan.ivanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> writes:
> On 04/02/2016 11:28 AM, Felipe Balbi wrote:
>> Instead of having a static global just for
>> initializing dma_mask directly, let's use
>> dma_coerce_mask_and_coherent() for that.
>>=20
>> Signed-off-by: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> ---
>>   drivers/usb/dwc3/dwc3-omap.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>=20
>> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
>> index 22e9606d8e08..c219118bfda0 100644
>> --- a/drivers/usb/dwc3/dwc3-omap.c
>> +++ b/drivers/usb/dwc3/dwc3-omap.c
>> @@ -331,8 +331,6 @@ static void dwc3_omap_disable_irqs(struct dwc3_omap =
*omap)
>>   	dwc3_omap_write_irqmisc_clr(omap, reg);
>>   }
>>=20=20=20
>> -static u64 dwc3_omap_dma_mask =3D DMA_BIT_MASK(32);
>> -
>>   static int dwc3_omap_id_notifier(struct notifier_block *nb,
>>   	unsigned long event, void *ptr)
>>   {
>> @@ -490,7 +488,7 @@ static int dwc3_omap_probe(struct platform_device *p=
dev)
>>   	omap->irq	=3D irq;
>>   	omap->base	=3D base;
>>   	omap->vbus_reg	=3D vbus_reg;
>> -	dev->dma_mask	=3D &dwc3_omap_dma_mask;
>> +	dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
>
> I think, It'll be better to just remove DMA configuration code
> from this driver and other drivers which support DT-boot mode only.

I don't have HW, can you test that on AM57x and/or AM437x ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXA1JyAAoJEIaOsuA1yqREI0EQAIkjWvGtO4707tFV8eanjg3e
tI8cu9Z4Fck/qM0aqNy7m8i9e/8TJ6mhqidtf1Z5gtncbEXtuoDGn2+pY5108npg
XA3ZDN7wv0kEObwtLDeTUbWg24KZdxQ0vGmaFa80UPvY59RCocT8+v85nA37LCnH
43k/EyLTTO6jf1XNGUvJLjhi0N88i1qF7eJymTYLyb+06qN56m1XEpYcX9shcEj9
4phrkuJA+7Qsz8ywzOU/NjCr1Clt19Jx/hEGLSAWnpqDntQ8uTgyLVcGCohM138B
ZL/0MJzzITV3PV5/as65s1FUQ1gVzpiRaL8EKPB7runUisU5/p5phDYavwOnZk1W
AURSFK2AB2OlZ7d9ikdcLSdzbM/vpNfcYZo5R3k5qeYnyoycdIGJvWhQdKE3MBtU
pja7fb78wagsGepebG4aOzvQknwTYplfOY5JwE3bD3EzD7IsGIZdgrJ7t6QIf8ze
DTxzpcdY2c1lVFKVYBhxwMUKsUX88OfgJTI/kubd9g3VCS3B6w9Ckd11lGPtKY8q
4Rtdw3vbf0HcXLaEBrf26/eW1MJ5sW5ZkcpAf25qmfEDzpb07CzLLJCUoR8ORkb6
PVXJV/E430V1dFeLgYFWCDlDvl7E2L9DNpfeVMYVL98lxnrM9kikWzmuq+dHzF+u
ePttLIQuitfddcXCy7cg
=yxfY
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
