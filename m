From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP: Remove plat-omap/common.c
Date: Mon, 5 Nov 2012 17:48:41 +0200
Message-ID: <5097DFD9.5030800@ti.com>
References: <20121101224703.2103.95474.stgit@muffinssi.local> <20121101224828.2103.82950.stgit@muffinssi.local> <50936A6E.3020202@ti.com> <5093891D.6070302@ti.com> <50938A69.9040908@ti.com> <20121102154901.GU15766@atomide.com> <20121102185453.GY15766@atomide.com> <50977319.9070902@ti.com> <20121105153632.GH4953@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig35FDF58EE3B050DB3D99A070"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37336 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750987Ab2KEPsq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 10:48:46 -0500
In-Reply-To: <20121105153632.GH4953@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

--------------enig35FDF58EE3B050DB3D99A070
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-05 17:36, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [121105 00:06]:
>> On 2012-11-02 20:54, Tony Lindgren wrote:
>>>> * Santosh Shilimkar <santosh.shilimkar@ti.com> [121102 01:56]:
>>>>> On Friday 02 November 2012 02:19 PM, Tomi Valkeinen wrote:
>>>>>> On 2012-11-02 08:38, Santosh Shilimkar wrote:
>>>>>>>
>>>>>>> Lets not move this in DMA code since the above is really related
>>>>>>> to frame buffer. It reserves more DMA area for dma_alloc_coherent=
()
>>>>>>> etc than default 2 MB. Infact, we should no longer need this with=

>>>>>>> CMA and memblock in place.
>>>>>>>
>>>>>>> Tomi,
>>>>>>> Can we not get rid of the above memory reservation ?
>>>>>>
>>>>>> Yes, I think so. This one is only used for the old omapfb, i.e. om=
ap1,
>>>>>> and I have no means to test it out, though. But below is a patch t=
o
>>>>>> remove it. I also attached the patch, as it looks like thunderbird=
 wants
>>>>>> to reformat the pasted patch... I'll remove the
>>>>>> CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE from the omapfb driver's Kconfi=
g file
>>>>>> in my tree later.
>>>
>>> Hmm actually, is it safe to remove for omap1, or should we
>>> still keep it around for omap1?
>>
>> Why wouldn't it be safe? Do you mean that CMA doesn't work on omap1,
>> or...? I'm no expert on CMA, but as far as I can see with it's ARM
>> generic stuff.
>=20
> Just wondering after your comment "This one is only used for the old
> omapfb, i.e. omap1". But sounds like it should no longer be needed
> there either if I parse that right.

I meant that the code that was moved in the patch "Remove
plat-omap/common.c" is only compiled and ran on omap1, when the old
omapfb has been enabled in the Kconfig. It's not used on omap2+.

old omapfb uses dma_alloc_*() to allocate memory, so if CMA works on
omap1, I think this code in question can be removed, as done in my patch.=


 Tomi



--------------enig35FDF58EE3B050DB3D99A070
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQl9/ZAAoJEPo9qoy8lh711oQP/3LfXlUT+fEW2pA/QwIcOus2
8SNrU4LGxW83EP5z6MMKFrLSIQwJmRNPYWekmURFq/Ehcp1hoNwopC6EUUqdBPeS
Fs6c3573Wiu9DKZi8pEZch1t8hKOaugHnB+3AV3oVpYqkPYZqcOy1dSAM5+70d8V
X7zKiHYfq8D4UspSL7Cuknc5vKFldRZ3/xnLCKTwp9VE6AnPufEjlnFPmtYMGsij
nlZeP7zDG/VNQ0s6lNd+zJWRKT/RZGraZWG7Y/Jqkiy3GJCGOon6SB7ts3K3N+fy
XLVJFdfaFfA1Tn/Adgau5oarYplsU6FAgntSImrFKwQLSPAhmi513zoUpX31OjYh
xYzhwgA2pmgHTY/f3o7VasaLbHSHl0IAvLXiJ8vbyFKu9CDZ1RHxRwE8ns6Ozi7S
DVZRhaVC8avEXBYll1f80VQ27hQeKDqIS79FJ/q4+K9L6d9AmOYw2HCdNkkvIqE6
pvexQEl4SocK4vDz55R+PlrOCgpT9X38GEheI7BoKsBIr0Hk0g1bTtLJA7QaZOKD
Get7hUBlNwNBxLMx3h1SYe92wKk4SmWw/bkEenf0dy6u7ykmS6OfKX3n3P573QTv
C3Aa44xg7OFsL0Mh13AJICKP+vJLWVfyzwPaowYLQRBNWHBX167dXGVTJ0F4sh6s
NNWgpCR++XVTndMe+4z9
=t3Vf
-----END PGP SIGNATURE-----

--------------enig35FDF58EE3B050DB3D99A070--
