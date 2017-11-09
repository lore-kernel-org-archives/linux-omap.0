From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: USB regression in next-20171108 with hub spamming
Date: Thu, 09 Nov 2017 12:59:25 +0200
Message-ID: <87po8rra42.fsf@linux.intel.com>
References: <20171108230511.GY28152@atomide.com> <20171109080007.GA17098@kroah.com> <871sl7sq9i.fsf@linux.intel.com> <87wp2zrasg.fsf@linux.intel.com> <87shdnrak7.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87shdnrak7.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> writes:
> Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> writes:
>
>> Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> writes:
>>
>>> Hi,
>>>
>>> Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> writes:
>>>> On Wed, Nov 08, 2017 at 03:05:11PM -0800, Tony Lindgren wrote:
>>>>> Hi Felipe & Greg,
>>>>>=20
>>>>> Looks like in next-20171108 USB hub is spamming console about once a
>>>>> second after commit 7dfd74fd128 ("Merge remote-tracking branch
>>>>> 'usb/usb-next'").
>>>>>=20
>>>>> Any ideas? See the log below.
>>>>
>>>> Any chance you can run 'git bisect'?
>>>
>>> I wonder if it was caused by the usb_get_std_status() changes. We didn't
>>> catch this in our testing, though. I left the patches in intel's
>>> validation for a few days before sending out.
>>>
>>> Let me compile that very tag and try it with one of our machines.
>>>
>>> Tony, a bisection would be useful, indeed.
>>
>> reproduced. Digging to figure out what's going on.
>
> Okay, found it. Testing a patch.

Here's the patch, I'll send it formally shortly.

diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 0cdc463c9509..c15fbf76f8f7 100644
=2D-- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -975,6 +975,7 @@ int usb_get_status(struct usb_device *dev, int recip, i=
nt type, int target,
 		}
=20
 		*(u32 *) data =3D le32_to_cpu(*(__le32 *) status);
+		ret =3D 0;
 		break;
 	case 2:
 		if (type !=3D USB_STATUS_TYPE_STANDARD) {
@@ -983,6 +984,7 @@ int usb_get_status(struct usb_device *dev, int recip, i=
nt type, int target,
 		}
=20
 		*(u16 *) data =3D le16_to_cpu(*(__le16 *) status);
+		ret =3D 0;
 		break;
 	default:
 		ret =3D -EIO;
=2D-=20
2.14.2.642.g20fed7cad4


=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAloENQ0ACgkQzL64meEa
mQYxEQ/+KTt30u4C97l/Ue8Tk1A2hfH2XB3EcmH3RrumWkW9ibDzhf5U89L2KJqN
E6idMQtQJ1eYF0SIEle6dsh2xNgCZKXG23BIIcE+nJNEuaNP59uKFFg0hdjvcTuu
j9LlKVgMndQaVW/NevEy7zcsEr+EeKlmQIE+qU/DYCIlW5hN6kuaEo0EnckK21PE
JHyVqL8RQiPzK4Mxs5vmOiCw0TQlIjtpP68ZD8/fzt/8s+oBcyTMK1yDpi0xaXKj
WBZJ4mMpFYXRvM6lNBSypbbVjJ/1gycVh4Yg1EefWI6U4CjsfOVpxQT7Ok3FEMOa
k/7X0KkoAAgSO2TxL6ksATe8CEVnnfQqLgHvdat6/wBDbsVWYZKSxMLo1FH561b0
NpobEk9APpIMKOEkOIuExxzkBcgbJrEvLkSQpsr9188Yl20FvPmX6cWSfhqCWRGA
AyD1rfJWHix2TMygcOkQ4qLyyTV8mjhkox8SpC0mzKcxbLHhjeGGxPk9H+SdtmKk
LVuU1vjIzLN5hzJ2545VHjeHsHqNMbIwADIo56vs+b2KTBF5/Ji+CrBeCtzPaPht
lALrKSNGrTS/R4tT7vy7Iuc+4BK0lAF6H0Y9CETouO3PrAzDp2ypffAjoUdTu7CK
NC9PkoO80Qn3lyiUqm4PRmsmN2+hGS6iJBCxREtali7dwh5s6kQ=
=D8qy
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
