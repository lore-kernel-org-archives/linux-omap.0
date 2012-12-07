From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/5] OMAPFB: simplify locking
Date: Fri, 7 Dec 2012 16:16:48 +0200
Message-ID: <50C1FA50.3040403@ti.com>
References: <1354881309-17625-1-git-send-email-tomi.valkeinen@ti.com> <1354881309-17625-2-git-send-email-tomi.valkeinen@ti.com> <20121207125350.GE32230@intel.com> <50C1F232.80508@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8D6B154CA8D4CE5558A751B7"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48769 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030606Ab2LGOQv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Dec 2012 09:16:51 -0500
In-Reply-To: <50C1F232.80508@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enig8D6B154CA8D4CE5558A751B7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-12-07 15:42, Tomi Valkeinen wrote:
> On 2012-12-07 14:53, Ville Syrj=E4l=E4 wrote:
>> On Fri, Dec 07, 2012 at 01:55:06PM +0200, Tomi Valkeinen wrote:
>>> Kernel lock verification code has lately detected possible circular
>>> locking in omapfb. The exact problem is unclear, but omapfb's current=

>>> locking seems to be overly complex.
>>>
>>> This patch simplifies the locking in the following ways:
>>>
>>> - Remove explicit omapfb mem region locking. I couldn't figure out th=
e
>>>   need for this, as long as we take care to take omapfb lock.
>>
>> I suppose the idea with that was that you wouldn't need the global
>> omapfb lock, and also it was an rwsem so it allowed parallel access to=

>> the mem regions, unless the region size was being changed, in which
>> case it took the write lock. I can't really remember what the reason
>> for using an rwsem was, but I suppose there was one at the time.
>=20
> Right. Yes, I have no recollection either of the possible reason for it=

> =3D). Did we have multiple concurrerent users for the fbs? It still sou=
nds
> like a useless optimization, as all the region locks were only held for=

> a short time, as far as I saw.
>=20
> It could also be that we're missing something from the mainline kernel,=

> which we had in the Nokia kernel, and which would explain the need for
> region locks.
>=20
>> I think the only correctness issue with your patch is that you're
>> opening up a race between omapfb_mmap and
>> omapfb_setup_mem/store_size.
>=20
> Good point. I think this can be fixed by taking fb_info->mm_lock in
> omapfb_setup_mem & co.

Well... Adding using of fb_info->mm_lock to omapfb_setup_mem again
causes possible circular locking warnings. And I still can't figure out
the exact reason. Perhaps the region locking was not involved in this
warning at all, but the problem is elsewhere.

(I hope the circular locking detection is correct =3D).

 Tomi



--------------enig8D6B154CA8D4CE5558A751B7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQwfpQAAoJEPo9qoy8lh71F2YQAI8uu9Dh4OqafQOhrH/URHn6
xGPpKlN27RpvVyhnZ++aVJZchKgOoxTv3leCT+KjmahPh20WVar2g3dvFsVFBU5X
xJmfPYU4yv138exkgZmzPkf54B8zYqASRLIqm+ymFzRcH1gBh7U9IfVx/v+VkZmj
fKyIhmAFqEiWbG+4DSyms6oHI7pO8Ud2a8o/tzAFs5z/IygDpmDe4zon+MZscygM
Pe+YJw3D3oHLVDc92GZeVQusR+6cJ132Yg/f/OROTV3uaTwbRwp0dqC+kCqBqh4n
vbnf9FiHgYXigGlAnoE+6ZYZ5DFMpiw30tgbDd+0UWUF5fuO1jEpCF8G/RImfTRm
HeaIRCxPL7Z/IemrXQ0Z5bFLbSvFZh476cgzx9sXPSYqT7tlMfErtLhwlF4JWioc
+R1zA8eYcP3Is51+ueIbYrsBTaFRLz7e8bMwSsSN7q5TepPd/ChiJlcRlQ4cKA94
XfAXK0v6cz4TNKv96lRLuJ/ZUjOaEdcyPgRCtm/IoTCwlTQVPz8x3qurDaUHg3QZ
fpj8mwAjfU4kGixpWR+8ZZhOC/WAn0JiKpoJ9pmpn1P8/Z2jCoZdfGCSbT7ojRue
VakvsyRA7s7AgKHnH9DZjEbqU0V6KsXwkuKp0HynDRQJtZKYovLHmGStrB7Y2JvS
/svmj95xbMAoYZ/A8gVk
=lPWH
-----END PGP SIGNATURE-----

--------------enig8D6B154CA8D4CE5558A751B7--
