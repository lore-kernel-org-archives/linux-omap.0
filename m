From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v3 2/2] usb:dwc3: pass arch data to xhci-hcd child
Date: Fri, 01 Apr 2016 13:20:03 +0300
Message-ID: <87shz58wbw.fsf@intel.com>
References: <1457594332-7490-1-git-send-email-tqnguyen@apm.com> <1457594332-7490-3-git-send-email-tqnguyen@apm.com> <87mvpgi02f.fsf@intel.com> <56FBDA0D.4030507@ti.com> <87egashxz8.fsf@intel.com> <CAKrQpSvgTm+OM+ffO4ZKwpb=J3ewKoWYA7ojE+WKBbiYKwdMqw@mail.gmail.com> <87k2kjgjjf.fsf@intel.com> <56FD3D2F.8070501@ti.com> <871t6pahg8.fsf@intel.com> <56FE4378.3030205@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56FE4378.3030205-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, "Thang Q. Nguyen" <tqnguyen-qTEPVZfXA3Y@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "Karicheri, Muralidharan" <m-karicheri2-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Phong Vo <pvo-qTEPVZfXA3Y@public.gmane.org>, Loc Ho <lho-qTEPVZfXA3Y@public.gmane.org>, patches <patches-qTEPVZfXA3Y@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> writes:
>> if of_dma_configure() does what you want, why don't you just stick it in
>> dwc3-keystone.c and let the driver continue to copy things for now ?
>> Something like below, perhaps ?
>>=20
>
> I know (and i have patch to fix that which I'm going to send) that DMA co=
nfig=20
>  in dwc3-keystone.c is not correct and we are good till now just=20
> because dwc3_keystone is not used for DMA operations directly.
>
> Now about xhci and friends:
> dwc3_keystone *is created* from DT : of_platform_device_create() -> of_pl=
atform_device_create_pdata() -> of_dma_configure()
> |- dwc3 *is created* from DT : of_platform_device_create() -> of_platform=
_device_create_pdata() -> of_dma_configure()
>    |- [1] *creates* xhci dev manually : DMA configuration copied manually=
 in dwc3_host_init()
>    |- [2] *creates* usb_gadget dev manually: DMA configuration copied man=
ually in usb_add_gadget_udc_release()
>    |- *creates* usb_udc dev manually : not used for DMA operations direct=
ly (as I've checked)
>
> Now cases [1] & [2] introduces failures, because DMA configuration is not=
 complete for
> these devices.

right, then we just copy whatever's missing, right ? Until there's a
generic way of copying these bits, I want to avoid introducing any of_*
specific methodologies and prefer to have the manual copy.

> I can confirm that if I fix [1] & [2] as above USB Device/Dual modes will=
 start=20
> working on K2E.

cool, I'd be happy to take both patches ;-)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW/ktTAAoJEIaOsuA1yqRELfsP/RpvKKquRtDvU7y0N2JRFlUc
1jMPI3jKEWhqedeN5fWWO/AhZ81j95wj6hYXTL7fEClIIYzvqMzFR7K0ljD4pAls
xNj6sDKsApJsK93cMs4NUl3ZRUNieUiPIuYfEoM2Duq0A/+KhG7VjpZLufwZFRFx
7y1Q8nnPnNeyARSBftBZ2zE1PzSZKZvLidhUzhmpaTdFiDhh+sKAlnpUPkV3ESAE
TGD1bQnaSd99HJqbqPHYWl/2muHRcqJubdfWK60qUXgwr2ri5qS3uDy/87jvvtOT
/d6rVI99/jLEKifzhepz7Kq1wojNW7v++iEFcsVeyM8X3pJgvjZCNKnIhsdj2RKE
8PHXpLg0hhHOCJGa2ZADMAo+m54pTSFjUEmmg8/Zypdf1mbL6G5kWsuw3nMF17Sl
/4DY9RWmhsKjus4tc+1G61ib70HqmBWnhoayO13zY8NdTZOgWWuUxT6jbWLiDeSM
xeeqV8d+EB1bJfSqBaOAtgXY8N+XlkcjHmGs4lM7fmzj9DhW7fK0PFezyVcHFLW3
NfeT5fUAI1koHDfMGheBdNPD48g9EnvKSk4mPzJ716ik2zdDQPlT8PHYh8TVl1MU
rBLmcydYAjpgVoSDFs/SAPUOuLzEGXUjKgirrnHwg+q2TCLy2G6ngnQl/f85FpRX
7N0Esd3wtK2zidkcvCQj
=nt70
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
