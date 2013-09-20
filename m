From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] drm: omap: fix: Defer probe if an omapdss device requests
 for it at connect
Date: Fri, 20 Sep 2013 13:22:04 +0300
Message-ID: <523C21CC.1010503@ti.com>
References: <1379502502-8781-1-git-send-email-archit@ti.com> <523C02C8.30207@ti.com> <523C0BFE.5010409@ti.com> <523C0D6E.30701@ti.com> <523C20DC.2090100@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="SMqcW3ruivD581AnjgDL8i1suJXplGcQG"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51157 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754238Ab3ITKWH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Sep 2013 06:22:07 -0400
In-Reply-To: <523C20DC.2090100@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: robdclark@gmail.com, linux-omap@vger.kernel.org

--SMqcW3ruivD581AnjgDL8i1suJXplGcQG
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 20/09/13 13:18, Archit Taneja wrote:
> On Friday 20 September 2013 02:25 PM, Tomi Valkeinen wrote:
>> On 20/09/13 11:49, Archit Taneja wrote:
>>
>>> I suppose we would hit this case if all of the displays are deferred
>>> because of some dependency and are probed after omapdrm probes.
>>>
>>> Is that the case with beagle-xm?
>>
>> Yes, DVI is probed after omapdrm. There's also analog TV out on beagle=
=2E
>> I'm not sure why that wasn't ready earlier, or was it available at all=
=2E
>> I didn't study it further.
>>
>> If the analog tv would've been available, omapdrm would have started
>> with only tv out, and DVI would have been left out. So it's still not
>> perfect.
>=20
> Right, I suppose omapdrm should be probed only after all the dssdevs ar=
e
> probed. That's a bit tough to do.

Yes. Omapfb has the same issue.

>>> I think we need to move this from pdev_probe() anyway. I don't see ot=
her
>>> drivers doing much in pdev_probe(), they do most of their stuff in
>>> dev_load() itself. I'll try with that along with disabling of the
>>> dssdevs in encoder's destroy.
>>
>> Ok. The dssdevs are disabled in omap_connector already, though.
>=20
> I couldn't find where it is disabled in omap_connector. The only
> function which calls dssdrv->disable is omap_connector_set_enabled().
> That doesn't seem to be called in omap_connector.

Ah, right. Sorry, it seems I remembered totally wrong. I guess I was
thinking about omap_dss_put_device instead.

 Tomi



--SMqcW3ruivD581AnjgDL8i1suJXplGcQG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSPCHMAAoJEPo9qoy8lh711ZIP/1RsE6JzhqSlwwHV01QFJIlL
ey4SYMc8px3jLAZ3JgiwzPZCuKH/Yvx/Q9v9fFY96h1P9E2wKGssyBASP2ZqjUlN
M5NYl5vlpDKB+3dY50mHx/JoJ3DbI/enbMjLL/4JSVpcmtmTtoOQw5hjrpn5mTKs
QdyWKjy2lXkuPcsawWINgvWgwi0oHdtE076jTbTA3qjUyoR+fVmF4Ey/6sUFRkQe
jHXULM65kl8i/cwB9lfU1fnb+g3HBYXKYcey2jubfCQOzakb5ZcI11cbeu7SfqMb
xdn15LxVseJILW+AkslbjkLtHjkYTPAAdNcQfa+oMRN5O4xrtovn0PmjEhUY1fCD
MKq6yOv3pI7ful818Zqvaa9++34yseeSLItQKfm+6fiTTjuY1XBoAWiJdbUy6e6o
P/aJYMrk7fcM4/ELOTsYfVhwO7BlrPNJNP/gAAOXYP2vYJHTez+vGCarNzUc7E+e
HPqqn9DdqfDg/ct/CUZztaG5jzOwznyqsgmMh3SFbQ1SxqdDEtN/AiXsZ8ndAbLw
Xs//WzyrxJFeC41G1qUwkFhtyH+NO5bVa6lK0ok1+JP6dawYDplF821jvGGoOYKN
ALmMwhl0z8QCPZisH++ZFscYbbCeoMD5c8CgiFjR1YHXPmhSDPi5DnZcfzmNEbhW
pfvBivqxUnWy/NyG5MC3
=FJtL
-----END PGP SIGNATURE-----

--SMqcW3ruivD581AnjgDL8i1suJXplGcQG--
