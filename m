From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 12/12] OMAPDSS: DPI: always use DSI PLL if available
Date: Mon, 5 Nov 2012 10:55:11 +0200
Message-ID: <50977EEF.3040403@ti.com>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com> <1351613409-21186-13-git-send-email-tomi.valkeinen@ti.com> <5090D28E.6050703@ti.com> <50939B84.6090602@ti.com> <5093A3FB.1060806@ti.com> <5093A530.5050302@ti.com> <5093A9E8.70106@ti.com> <5093AE79.9010603@ti.com> <5093B4F3.1000703@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD9F82EE1C89DAB7BFEB8B8C1"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57864 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753018Ab2KEIzN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 03:55:13 -0500
In-Reply-To: <5093B4F3.1000703@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com

--------------enigD9F82EE1C89DAB7BFEB8B8C1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-02 13:56, Archit Taneja wrote:
> On Friday 02 November 2012 04:58 PM, Tomi Valkeinen wrote:
>> On 2012-11-02 13:09, Archit Taneja wrote:
>>> On Friday 02 November 2012 04:19 PM, Tomi Valkeinen wrote:
>>>> On 2012-11-02 12:44, Archit Taneja wrote:
>>>>
>>>>> Hmm, that makes sense. Anyway, I don't think it's really bad if we
>>>>> refer
>>>>> to dssdev->channel for now.
>>>>
>>>> It is, because dssdev->channel doesn't exist with DT.
>>>>
>>>> With DT we either need to figure out the channel in omapdss at runti=
me,
>>>> or add a property to the DT data telling the channel. And adding suc=
h a
>>>> property is not correct, as DT should be about describing the HW.
>>>
>>> Ok.
>>>
>>> I don't totally agree with your idea of figuring out the manager in
>>> panel the panel's probe. If it's done in the panel driver's probe
>>> itself, then by this point of time we have already set
>>> mgr->output->device links. If omapdss only does this stuff, then
>>
>> Hmm, I'm not sure I understand what's your point above? If figuring ou=
t
>> the mgr is done in panel's probe, the mgr->output link is not yet made=

>> before that time.
>=20
> My point is that we are trying to find a manager at panel's probe
> itself. It think that's what we do now. But one of your recent patch
> moves that to omapfb.

Ah. Yes, that's true.

>>> omapfb/omapdrm have just the job of connecting the overlays to the
>>> manager. Do you think that's okay?
>>
>> Yes, that's how I think it should be. I don't see why omapfb/omapdrm
>> should care about which manager is being used for the output, it doesn=
't
>> really matter as long there is one and it works.
>>
>> Then again, I don't have anything against omapfb/omapdrm choosing the
>> manager, but I don't see how they would have any better idea of which
>> manager to use than omapdss.
>>
>> But as doing the connections at probe time is a bit problematic, perha=
ps
>> we should have a new step in this whole sequence. Something like
>> "connect" or whatever, which would lock the required blocks in the who=
le
>> pipeline, and acquire the required resources that couldn't be gotten a=
t
>> probe time.
>>
>> But even then, choosing the manager is not easy, as whoever chooses th=
e
>> manager needs to observe all the possible displays used at the same
>> time...
>=20
> Right. I was wondering if omapfb/omapdrm could understand the 'all
> possible displays information' better compared to a panel's probe.
>=20
> Even omapdrm/omafb can't be perfect because we could insert a panel
> driver module at any time, and omapfb/omapdrm may miss that out.

True, omapdrm/fb may have a better idea. It's still unclear though.
Currently we have quite strict order in the sequence the modules need to
be loaded, which is quite bad and causes issues. We should make things
more dynamic, so that the initialization of the drivers could happen
more freely.

But that creates more problems: when booting up, omapfb starts. But
omapfb can't know if all the panel drivers have already been loaded.
omapfb may see that DVI is the default display, but what should it do if
DVI doesn't have a driver yet? It could wait, but perhaps the driver for
DVI will never even be loaded.

 Tomi



--------------enigD9F82EE1C89DAB7BFEB8B8C1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQl37vAAoJEPo9qoy8lh71x9MQAIXcV52yZtuqx9BjYhUr5Uz5
EPpowMArNtsJ0MBOkO05gpUl9zJrLaTfrwwwqe6Y3m4kAU0y5LHOdTok0zxXCI/H
59tCMyLmLvI4GVB2pIU8VUZhPFXooxdk/YkooS2zMRfGmSzCUS/cCqD2xUyD9CAO
9Lwhi9vZJWWv+1jXwMqu/Hf7mLiXPvcqFHCcQJpnYEARayNsY35X/tDuUXvRh4br
xukvS89FE6sIdy0qfpvXIpFwPvdRzzje++NiTeQbqnK1n/TEtmIPhbgcq0LYvdJu
YsQ314pkwbOsTgBeV2VjUXgcODFgF3/Np4VDhSaMJzLU2/Y1xX+qZNjumpwJkrRo
8pZ4kpy2ZtIIhfPKOKRyPckjwaQ5vZbaTt7S4SPn0Mo2UDmXky4pc1m9Bgf8MYYr
zbzSKGbdiwUOn1CDg72q/Cn0i44HHE78tv1hWDKW1R+ItZt2nR0jySQEwgdDPKfa
1wbQo+DxrgLk3izDtFZWTPTn6RxBG7rsPQ/SFi1hXJ+tsAq26RSfeQRjEBVvQZQO
PUXKAT8CFc8KQWrLAMq3kVgrbxYDDbeVUZnX6nWLIg8ySoDRgK1P72vjHeY/aOeY
bIIRZzNmMHDBJu+ggjJJwiS7tUSZYSjcRI4bqZLf1ET9vfNIFvPgn8XhYShYyb80
twBK2RJZw8COgzceWRyP
=9LaY
-----END PGP SIGNATURE-----

--------------enigD9F82EE1C89DAB7BFEB8B8C1--
