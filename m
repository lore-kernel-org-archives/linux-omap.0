From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 03/10] usb: dwc3: omap: Pass VBUS and ID events transparently
Date: Mon, 11 Apr 2016 16:26:18 +0300
Message-ID: <87r3ecmg3p.fsf@intel.com>
References: <1460374506-9779-1-git-send-email-rogerq@ti.com> <1460374506-9779-4-git-send-email-rogerq@ti.com> <87egacnxtr.fsf@intel.com> <570BA0B1.1060404@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <570BA0B1.1060404-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
> On 11/04/16 15:18, Felipe Balbi wrote:
>>=20
>> Hi,
>>=20
>> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
>>> Don't make any decisions regarding VBUS session based on ID
>>> status. That is best left to the OTG core.
>>=20
>> what about builds who don't want OTG and/or dual-role ?
>>=20
>>> Pass ID and VBUS events independent of each other so that OTG
>>> core knows exactly what to do.
>>>
>>> This makes dual-role with extcon work with OTG irq on OMAP platforms.
>>>
>>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>>> ---
>>>  drivers/usb/dwc3/dwc3-omap.c | 15 ++++++---------
>>>  1 file changed, 6 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
>>> index 51ca098..c9b918d 100644
>>> --- a/drivers/usb/dwc3/dwc3-omap.c
>>> +++ b/drivers/usb/dwc3/dwc3-omap.c
>>> @@ -233,19 +233,14 @@ static void dwc3_omap_set_mailbox(struct dwc3_oma=
p *omap,
>>>  		}
>>>=20=20
>>>  		val =3D dwc3_omap_read_utmi_ctrl(omap);
>>> -		val &=3D ~(USBOTGSS_UTMI_OTG_CTRL_IDDIG
>>> -				| USBOTGSS_UTMI_OTG_CTRL_VBUSVALID
>>> -				| USBOTGSS_UTMI_OTG_CTRL_SESSEND);
>>> -		val |=3D USBOTGSS_UTMI_OTG_CTRL_SESSVALID
>>> -				| USBOTGSS_UTMI_OTG_CTRL_POWERPRESENT;
>>> +		val &=3D ~USBOTGSS_UTMI_OTG_CTRL_IDDIG;
>>=20
>> this creates the possibility of having a USB peripheral with VBUS_VALID,
>> right=20
>
> Sorry, I didn't get what you meant.

if you're touching these bits independently from each other, won't you
have a situation where you notify IDFLOAT but don't notify that VBUS is
off ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXC6X7AAoJEIaOsuA1yqREdQ8QAKAZbYASgeiCWRP5RL09ONRK
GhylL0pHfVOYiyltNEms2OZQXJoo5J/KVKicOXqyvKVaYa+CZ4KEwBvGVo7ASrdj
V7v6z02ebS5y6CvUJ37fZm7xl76Qh/embYop4QSMN3yoVCchOrnwjK60O4sGmr2g
folHV1BsJtkErdQBq75UVjOP/EOOuJz6DWqZz7aCggHduCOjCKRvdH7r6akmZ4E7
Xs3rpf0y9yo7RQ9DdOrR9Ss/djoRLk2VgczyFr2yc10p2eFK9TKPewm5nEcf+VRc
/GebLKc8d98sb4bkd1veyqMnu7SZh1z5HfPiw9Xr0WjPcqWkhuFf4HIkRniEELxA
86T17Qw96b77vZj06Vtk3csWdeNXix96pw9mznpOQ6umsMxYhkzqMFkCJ+SFNlCc
I++zIXvWcM1M+1x+CkvcUjbxUBrsicmiDWAkKpwjaRqHmJg+nhsuo1aAF7rbfa7A
SO6aQdLORuSI5jaa2MCI98SF8auqhks/ePVZedMetwWl+mn2vqzBwd0qa5l9vGpC
f3Eqj1Yv8moj6CYrMrK1fjPXtfDM1EY3TLXkFQTtvMWnW1GjZCO5mIN/VnuJCIwJ
XOCJsn2B5OvvzQDEphMo8XILjLPRtMEZUX1AgbCwngZ8F2fZpxgwZlaRo0pAmpcg
3tYyzgiPZZ30p/BOCczs
=bq3g
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
