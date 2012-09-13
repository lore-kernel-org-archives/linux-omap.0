From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 4/4] can: c_can: Add d_can suspend resume support
Date: Thu, 13 Sep 2012 10:30:47 +0200
Message-ID: <505199B7.2000903@pengutronix.de>
References: <1346673139-14540-1-git-send-email-anilkumar@ti.com> <1346673139-14540-5-git-send-email-anilkumar@ti.com> <50450C9F.6010203@pengutronix.de> <331ABD5ECB02734CA317220B2BBEABC13EA26300@DBDE01.ent.ti.com> <5045AD56.2050400@pengutronix.de> <331ABD5ECB02734CA317220B2BBEABC13EA2D7FA@DBDE01.ent.ti.com> <505087FD.7000907@pengutronix.de> <331ABD5ECB02734CA317220B2BBEABC13EA2E0AA@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF1946D18D22DF327A9F7DE4E"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52336 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938Ab2IMIaz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Sep 2012 04:30:55 -0400
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA2E0AA@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "tony@atomide.com" <tony@atomide.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF1946D18D22DF327A9F7DE4E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/13/2012 09:24 AM, AnilKumar, Chimata wrote:
> Marc,
>=20
> On Wed, Sep 12, 2012 at 18:32:53, Marc Kleine-Budde wrote:
>> On 09/12/2012 02:48 PM, AnilKumar, Chimata wrote:
>>> Hi Marc,
>>>
>>> On Tue, Sep 04, 2012 at 12:57:18, Marc Kleine-Budde wrote:
>>>> On 09/04/2012 08:14 AM, AnilKumar, Chimata wrote:
>>>>> Marc,
>>>>>
>>>>> Thanks for the comments,
>>>>>
>>>>> On Tue, Sep 04, 2012 at 01:31:35, Marc Kleine-Budde wrote:
>>>>>> On 09/03/2012 01:52 PM, AnilKumar Ch wrote:
>>>>>>> Adds suspend resume support to DCAN driver which enables
>>>>>>> DCAN power down mode bit (PDR). Then DCAN will ack the local
>>>>>>> power-down mode by setting PDA bit in STATUS register.
>>>>>>>
>>>>>>> Also adds a status flag to know the status of DCAN module,
>>>>>>> whether it is opened or not.
>>>>>>
>>>>>> Use "ndev->flags & IFF_UP" for that. Have a look at the at91_can d=
river
>>>>>> [1]. I'm not sure if you need locking here.
>>>>>>
>>>>>
>>>>> Then I can use this to check the status, lock is not
>>>>> required.
>>>>>
>>>>>> [1] http://lxr.free-electrons.com/source/drivers/net/can/at91_can.=
c#L1198
>>>>>>
>>>>>>> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
>>>>>>> ---
>>>>>>>  drivers/net/can/c_can/c_can.c          |   78 ++++++++++++++++++=
++++++++++++++
>>>>>>>  drivers/net/can/c_can/c_can.h          |    5 ++
>>>>>>>  drivers/net/can/c_can/c_can_platform.c |   70 ++++++++++++++++++=
++++++++--
>>>>>>>  3 files changed, 150 insertions(+), 3 deletions(-)
>>>
>>> [snip]
>>>
>>>>>>> +#ifdef CONFIG_PM
>>>>>>> +int c_can_power_down(struct net_device *dev)
>>>>>>> +{
>>>>>>> +	unsigned long time_out;
>>>>>>> +	struct c_can_priv *priv =3D netdev_priv(dev);
>>>>>>> +
>>>>>>> +	if (!priv->is_opened)
>>>>>>> +		return 0;
>>>>>>
>>>>>> Should we add a BUG_ON(id->driver_data !=3D BOSCH_D_CAN)?
>>>>>
>>>>> These APIs are called from platform driver where device type
>>>>> device type is verified. I think we have to add BUG_ON() in
>>>>> platform driver.
>>>>
>>>> The platform driver returns if not on D_CAN and will not call this
>>>> function. But this functions are exported, so can be called by someo=
ne
>>>> else. So if the caller is not D_CAN, it's a bug.
>>>>
>>>
>>> I agree with you, but I have some concern here.
>>> I think we should do "return 0;" instead of BUG_ON(). With
>>> BUG_ON() system will hang and ultimately user lost his/her
>>> contents.
>>
>> Good point, better safe then sorry.
>> But this should not happen. What about WARN_ON()?
>>
>=20
> Either would be fine printing a warning message or WARN_ON()

I'm for a  WARN_ON()

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigF1946D18D22DF327A9F7DE4E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBRmbcACgkQjTAFq1RaXHMX2gCgj7YrkMFdSieK7LFAr+1YuM3K
xUQAn18ykqZVGKLprMIY+B6N+aVcjqOF
=j2nN
-----END PGP SIGNATURE-----

--------------enigF1946D18D22DF327A9F7DE4E--
