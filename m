From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 2/6] usb: dwc3: omap: don't access DMA bits directly
Date: Tue, 05 Apr 2016 14:44:13 +0300
Message-ID: <8760vw46wi.fsf@intel.com>
References: <1459585739-21204-1-git-send-email-felipe.balbi@linux.intel.com> <1459585739-21204-3-git-send-email-felipe.balbi@linux.intel.com> <570271BF.9040902@ti.com> <87y48s4n7y.fsf@intel.com> <570385AB.8060507@ti.com> <87egak4adi.fsf@intel.com> <5703A4AE.1090301@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5703A4AE.1090301-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbif-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>, Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>, Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Ivan T . Ivanov" <ivan.ivanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> writes:
> On 04/05/2016 01:29 PM, Felipe Balbi wrote:
>> Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> writes:
>>> On 04/05/2016 08:51 AM, Felipe Balbi wrote:
>>>> Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> writes:
>>>>> On 04/02/2016 11:28 AM, Felipe Balbi wrote:
>>>>>> Instead of having a static global just for
>>>>>> initializing dma_mask directly, let's use
>>>>>> dma_coerce_mask_and_coherent() for that.
>>>>>>
>>>>>> Signed-off-by: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>>>>>> ---
>>>>>>     drivers/usb/dwc3/dwc3-omap.c | 4 +---
>>>>>>     1 file changed, 1 insertion(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-om=
ap.c
>>>>>> index 22e9606d8e08..c219118bfda0 100644
>>>>>> --- a/drivers/usb/dwc3/dwc3-omap.c
>>>>>> +++ b/drivers/usb/dwc3/dwc3-omap.c
>>>>>> @@ -331,8 +331,6 @@ static void dwc3_omap_disable_irqs(struct dwc3_o=
map *omap)
>>>>>>     	dwc3_omap_write_irqmisc_clr(omap, reg);
>>>>>>     }
>>>>>>=20=20=20=20=20
>>>>>> -static u64 dwc3_omap_dma_mask =3D DMA_BIT_MASK(32);
>>>>>> -
>>>>>>     static int dwc3_omap_id_notifier(struct notifier_block *nb,
>>>>>>     	unsigned long event, void *ptr)
>>>>>>     {
>>>>>> @@ -490,7 +488,7 @@ static int dwc3_omap_probe(struct platform_devic=
e *pdev)
>>>>>>     	omap->irq	=3D irq;
>>>>>>     	omap->base	=3D base;
>>>>>>     	omap->vbus_reg	=3D vbus_reg;
>>>>>> -	dev->dma_mask	=3D &dwc3_omap_dma_mask;
>>>>>> +	dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
>>>>>
>>>>> I think, It'll be better to just remove DMA configuration code
>>>>> from this driver and other drivers which support DT-boot mode only.
>>>>
>>>> I don't have HW, can you test that on AM57x and/or AM437x ?
>>>>
>>>
>>> Yes. I can. With below change I see no issues with USB in Host mode
>>> on my AM57x board:
>>=20
>> what about peripheral side ? Host mode worked fine on K2 devices, only
>> peripheral suffered from the bad DMA API usage.
>>=20
>
> As I've mentioned before (and we verified that) on newer kernels=20
> peripheral mode has been fixed by commit:
>
> 7ace8fc usb: gadget: udc: core: Fix argument of dma_map_single for IOMMU
>
> Also, on OMAP devices dwc3 core device is created from DT now  (dwc3-omap=
 calls=20
> of_platform_populate()), so it's safe to drop manual DMA configuration co=
de
> from this driver (and if statement should be kept unchanged in dwc3/core.c
> - as per my comment on your patch 5).

fair enough, all I'm missing now is a proper patch ;-)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXA6UOAAoJEIaOsuA1yqRElusP/3DTCnVPfPQ0jHYeipHBA/pJ
gWbjGZ3vxcNEQqhwSyTS3e7IhT7y2w3urGZKOeUWwixG5n68cbCh31ZWUvX1YIHI
0y+qfZTwfd3QkHt8Es4Dz3vZhs51haN/iBmBuK6n7y4TjHUyhTK/Icz/p6fuOS34
HKT3lQL/DPgozw60fAS9i5Yc1qfHsEKz4RIFgYc9lxdqZCQlzZhTyIyt+VYZftiQ
NDF8pjX3t63IK8xOAbKG6xpvTrWzZu7JV3m7AT7Zx7q1SBmhQ7/MvltPGqk5Koqs
Lhi2BuzdBHmPlV+CCtpp8Jzgqnd543MCwH9DUbWe9nF6/fZdbGAmzM+np3W4mqLz
4vEzuRrfAprHo5NImkjQKbvSuPzyc2zY19HFRwvqkWAVVPDKXc+KY7QwxJ6wy/m4
0Tt61DTPeg/46rb90ascAO3LanV9O2edKsNVXWXN1Tb05WWv8Uib/iLyHzFppsxi
HqvV3ind0HLf2kvMmcCLGqTp/qAWaj+o+Gb0LPGLyHnC1ONmMu3ZkOl6WJumTFvv
o96+nnrRgLcjlrJBafyf4yQ90RTswN0YJm6qoQ8EJIbTCibmHgjXsZHyQTI5uqMa
HOk8GW/fUsBNdnKOYGd7qFipqYBQxLhENetkzdKDO3zxw6HPhDY64Y17tJt2/MSI
R4X6wkqR9vKpDn1SWiTr
=GD6F
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
