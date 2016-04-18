From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: RE: [PATCH v2 0/2] usb: dwc3: add disable receiver detection in P3 quirk
Date: Mon, 18 Apr 2016 10:56:41 +0300
Message-ID: <87lh4bgxja.fsf@intel.com>
References: <1457946651-23381-1-git-send-email-rajesh.bhagat@nxp.com> <DB5PR0401MB2024DEBF67F3990558A1D6BBF56B0@DB5PR0401MB2024.eurprd04.prod.outlook.com> <HE1PR0401MB202883D07F5AB0E1FF7C00E1E36B0@HE1PR0401MB2028.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <HE1PR0401MB202883D07F5AB0E1FF7C00E1E36B0-B0v07Ae2tapU4+HIaoOb3Y3W/0Ik+aLCnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "balbi@ti.com" <balbi-l0cyMroinI0@public.gmane.org>
Cc: "gregkh@linuxfoundation.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-usb@vger.kernel.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel@vger.kernel.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap@vger.kernel.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sriram Dash <sriram.dash-3arQi8VN3Tc@public.gmane.org>, Rajesh Bhagat <rajesh.bhagat-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Rajesh Bhagat <rajesh.bhagat-3arQi8VN3Tc@public.gmane.org> writes:
>>-----Original Message-----
>>From: Rajesh Bhagat [mailto:rajesh.bhagat-3arQi8VN3Tc@public.gmane.org]
>>Sent: Monday, March 14, 2016 2:41 PM
>>To: balbi-l0cyMroinI0@public.gmane.org
>>Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
>>kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Sriram Dash
>><sriram.dash-3arQi8VN3Tc@public.gmane.org>; Rajesh Bhagat <rajesh.bhagat-3arQi8VN3Tc@public.gmane.org>
>>Subject: [PATCH v2 0/2] usb: dwc3: add disable receiver detection in P3
>>quirk
>>
>>Adds disable receiver detection in P3 quirk in DWC3 driver.
>>
>>Rajesh Bhagat (2):
>>  usb: dwc3: add disable receiver detection in P3 quirk
>>  Documentation: dt: dwc3: Add snps,dis_rxdet_inp3_quirk property
>>
>> Documentation/devicetree/bindings/usb/dwc3.txt | 2 ++
>> drivers/usb/dwc3/core.c                        | 6 ++++++
>> drivers/usb/dwc3/core.h                        | 2 ++
>> drivers/usb/dwc3/platform_data.h               | 1 +
>> 4 files changed, 11 insertions(+)
>>
>
> Hello Felipe,
>
> Any comments on above [v2] patches?
>

https://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/commit/?h=3Dtest=
ing/next&id=3Dddf332eb6a5379c3f4bcade6760ae41bcd8f2202

https://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/commit/?h=3Dtest=
ing/next&id=3Dbdeb03b4ed887a36595fc8ccdd04f82e718e9ab4

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXFJM6AAoJEIaOsuA1yqREYsoP/39Jon1uld6sVF+HFg0mKLZ7
YzkqfSNU5ibpcWwA8OQIZuIYQuF8lvER3mw3GckM271qzvOOdiAVlOX7CoKFT9U+
Hqm7OfVY1hGHCVI7Q2VszNCQtNe9TJC2o8CTIlWHG/XKpPz5ijdvYYuRnb7ilaxk
MsTqQRyX2/Ezodv3ktfjtZK7TOSOnK9LV6exWpOtNmIQgiiPBzEs2vaYgG2HNvFM
biqyCTyiYWMWYVLPq3zhQklSXkmD9mWdP3+cdGiZLmwOn6DM0Tz3Of6FzIiGMgXw
MH3+4tKxauBaidbsJIpBuCTabQeTxCdbyJCTXKFW9cwoFBOzDtQ+i3fCLYNKV5DM
+2Z8QsbBVHDALtZ0jINs30Bth54ATI7m3y0A5VzY/ce48CxB1eaA8rQI8EcnJUbs
gL7RCAmH70CMFBgfIiufMsbAURlakPv9NV13C0SxfzGWfZTU4I6HmX8aMUeDynWk
eeg/7oM3oLl75OKg+7iiGMIb2pVux0ArUjQtGdKQADtJ5JbSN8bMZJ1+hcVFcWKt
6+2IwNDRrWlGhAlmRuWpEfILsGmn7heZeRsbVIZhMc0oManUB0KrKvBuSivPDuA/
wE/SKaDYObbwFYxtzGkBRPW2QcOHg6YFNO9At9PpcPUtfJ3x07tuSWzu3T1EQIHD
J9Qu79sr3UuFKjtmJ5KJ
=G7Xo
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
