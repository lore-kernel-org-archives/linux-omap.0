From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 08/14] OMAPDSS: DSS: add new clock calculation code
Date: Thu, 21 Mar 2013 10:13:48 +0200
Message-ID: <514AC13C.6030300@ti.com>
References: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com> <1362743569-10289-9-git-send-email-tomi.valkeinen@ti.com> <5149D30F.2010801@ti.com> <5149D5A7.204@ti.com> <514AA556.4040300@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1AAAC4781BAB1477A217B314"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44340 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753244Ab3CUINz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Mar 2013 04:13:55 -0400
In-Reply-To: <514AA556.4040300@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enig1AAAC4781BAB1477A217B314
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-21 08:14, Archit Taneja wrote:
> On Wednesday 20 March 2013 08:58 PM, Tomi Valkeinen wrote:
>> On 2013-03-20 17:17, Archit Taneja wrote:
>>> On Friday 08 March 2013 05:22 PM, Tomi Valkeinen wrote:

>>>> +    if (dss.dpll4_m4_ck =3D=3D NULL) {
>>>> +        /* XXX can we change the clock on omap2? */
>>>
>>> We can change dss_fclk1 on omap2, and the cclock2420_data.c and
>>> cclock2430_data.c have clksel structs which allow a set of dividers. =
The
>>> dividers are not continuous though, 1 to 12 and 16 are allowed. So we=

>>> might need to change the code here a bit, if we want to change the cl=
ock
>>> in the first place.
>>
>> Ok, good to know. Note that the comment is copied from the old code. I=

>> think I tried changing the clock on N800 with clk_set_rate long ago, b=
ut
>> I didn't get it to work. Things might have changed, but, well, I don't=

>> think we should spend time on omap2 code. I'm sure we'll get a patch i=
f
>> somebody needs it =3D).
>=20
> We could change the comment to a TODO for now.

Yep, not a bad idea. I'll make the change.

 Tomi




--------------enig1AAAC4781BAB1477A217B314
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRSsFAAAoJEPo9qoy8lh71XJoQAKbcpjcwM8C733TZg7vdl04g
GN6KKsZ4n0J14iTZS8eZtqhQLyaN6xyiPEm/8G69Ic1+Xc5UUtU5kQuJsLBk+xmF
YYiJpxN8Tw7Gjkmc+FeAPo46h9Cpt8TjfyZtDO7lllWokY/eBbBPA7r9Ct3VRvNb
KK9gUnfCFLq8gwYEGab/2Eyb/XJqkd/vXkjqIz6dEckSH3aMme+Pp22TvDOsywEK
TdlEC1eTmYOrlX/Aa1ALsdCkU7zvvNauWIAV3m82DVdHlclTfw1/qixyZwCtTJZV
LOLUOldvA1FN6pAM8oIJwIxkGlJddQJJxPOb/yJ/ho7h8y2i15ZQmyUMH4JtERDG
761H2CH2XVCHO5ncThP2Gxiu7WsQTFssE8g2kEZGd2m6D/hr1pNw9ulUx3vNoUrG
Z9kJz8XzUO0TvmZ+u6Hwnd81n6kJv6F0uTp9OEuGMMu/jEj2IK3j0DBCvAnvndFb
zNv1VUcSp4lV5aZV7hedbAGnapjYyvSix9KCeenjKP3WsNbiJchPoqvlFYxvGeJ7
s5qcWzn4HLBb8Do7Pam7j2ETRCSJ5ZIpzIY+MxD8tygzwxZjE0j2+KuzuVFjETW6
mF5SxKKOyB6ujsrRo7bkTK5uL/gVs2kL4dVTAV58gvikKAG48dG5C6k16xdue006
jlazDJNv6a35lPXKxlWt
=2CwS
-----END PGP SIGNATURE-----

--------------enig1AAAC4781BAB1477A217B314--
