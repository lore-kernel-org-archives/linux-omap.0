From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/3] ASoC: OMAP: HDMI: Obtain DMA port from resources
Date: Thu, 15 Nov 2012 14:36:17 +0200
Message-ID: <50A4E1C1.7080609@ti.com>
References: <1352860249-26348-1-git-send-email-ricardo.neri@ti.com> <1352860249-26348-4-git-send-email-ricardo.neri@ti.com> <20121114032712.GQ4415@opensource.wolfsonmicro.com> <50A3CFBD.5080903@ti.com> <20121114230848.GA4536@opensource.wolfsonmicro.com> <50A45467.6070404@ti.com> <50A4B9A6.5070806@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB8803FFFB9D681A0BA5126E3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47703 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993283Ab2KOMgY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 07:36:24 -0500
In-Reply-To: <50A4B9A6.5070806@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

--------------enigB8803FFFB9D681A0BA5126E3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-15 11:45, Tomi Valkeinen wrote:
> On 2012-11-15 04:33, Ricardo Neri wrote:
>> Hi Mark,
>>
>> On 11/14/2012 05:08 PM, Mark Brown wrote:
>>> On Wed, Nov 14, 2012 at 11:07:09AM -0600, Ricardo Neri wrote:
>>>> On 11/13/2012 09:27 PM, Mark Brown wrote:
>>>
>>>>> Presumably this needs some other corresponding change in the resour=
ce
>>>>> setup to go in simultaneously...
>>>
>>>> Yes, the change in the resources setup has been submitted to the
>>>> OMAPDSS HDMI driver and accepted by Tomi [1].
>>>
>>> Don't do this.  With a change like this which must be made at the sam=
e
>>> time over multiple subsystems it is very important that you send all =
the
>>> parts of the changes together.  Otherwise there's a risk that one of
>>> them won't get merged and even if they do both get merged you'll brea=
k
>>> bisection - it's clear that nobody can be testing this on Tomi's bran=
ch.
>>
>> but the changes will hit linux-next at some point and they could be
>> tested there, right?
>>
>> Sorry, as changes for the HDMI drivers go to several maintainers, I wa=
s
>> trying to send the relevant patches to the respective maintainers and
>> avoid potential merge/rebase issues.
>>
>> Tomi has already taken the DSS changes. Perhaps, if you and Tomi agree=
,
>> Tomi could also take the ASoC and the arch/arm/mach-omap2 changes. Thi=
s
>> way all changes come from the same tree.
>=20
> Hmm, ok, I'm a bit confused here.
>=20
> I though the omap_hdmi_audio device was a new thing, and thus it was ok=

> to add to omapdss. But now I see omap_hdmi_audio is already registered
> in arch/arm/mach-omap2/devices.c, meaning the same platform device is
> registered twice now. Well, with the exception of the device id, which
> is -1 for the one from devices.c, and 0 for the one in omapdss.
>=20
> Mark is right, this is not right. The kernel should work fine after eac=
h
> patch, which means that sometimes a patch will touch multiple different=

> areas of kernel.
>=20
> omapdss master branch is a stable branch, so I don't want to rebase it.=

> But I guess I can "reset" it by merging a mainline using some merge
> strategy. I haven't done that before, but I guess it'll work.
>=20
> Can you look at all the HDMI patches related to this hdmi-device change=
,
> and rewrite them so that they'll keep the kernel working after each pat=
ch?

After some testing I think resetting my master branch with merge is not
a very good option.

However, the HDMI audio platform device patch is almost on top of the
branch, so reverting it would only create a few steps where the HDMI
audio may be broken.

So I can revert the patch and apply a new series with the patches
organized so that things will work.

 Tomi



--------------enigB8803FFFB9D681A0BA5126E3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQpOHBAAoJEPo9qoy8lh71SkgP/2JR1Qo7UNFwG0at9AUlj5Mz
eNC4HCmbKMGHChbmk4zTUtukEJobyPWyyJV+TwdYgp0d49X57YJDQLhGHqOKEyW2
u6cDFGS3CsCsOu80PDN321WQSzEAiaaTBkD6mD6oaGS4dY5CRFmgqcVN+zWxHxsB
koyUqNmuXxvtzHzLzmjPAw4oGhao+CmN3q+DSq54IsErok+7OndaUuFFQT9EpfTi
jmReImT4MzVmD7Qwz/ohOjWvllXpN4BdI0rHkWC+u5y1lGiesDeOp37rEha10drc
ODZKBvQo7v2JAy6BZg6rtSwNX/F423kpn6uv2+yWZiAlYkQD3gPRUPcJnSaRyUuc
T0DTeoocpPzEllwGpGSvuIUzX2wqsg9SKZVpTuuiENCQYbWlAME9qsCE2dF027tJ
0G2VIVjQTnGEq+CmBEuSRzxNlxLS3eS+OfR7qiwMNSMLmDEOP+elWgqsncmdZ0r/
1o/K2BLCZXuU6MaGHXruKamy67gIVNjqxFG3fj94pWBqDU4X1gXdatmldIiTLoqE
xdNtpCIi92xi3eTDg0zLka+bF/fN4FqHbtpJoi7fXPFq0PnfF8bqkIbZ+BMnrS7+
KwrE2GVSStQRC+Yv+oCZmlvoi1vTUF7hiJyZOmvxPV7sj+9n7mVtXkE6XxxK7Hbj
K1R4EILO2bJULSnssdVb
=TI5n
-----END PGP SIGNATURE-----

--------------enigB8803FFFB9D681A0BA5126E3--
