From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/5] OMAPFB: simplify locking
Date: Fri, 7 Dec 2012 15:42:10 +0200
Message-ID: <50C1F232.80508@ti.com>
References: <1354881309-17625-1-git-send-email-tomi.valkeinen@ti.com> <1354881309-17625-2-git-send-email-tomi.valkeinen@ti.com> <20121207125350.GE32230@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB964850A7CF8554F933660C3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34247 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030383Ab2LGNmN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Dec 2012 08:42:13 -0500
In-Reply-To: <20121207125350.GE32230@intel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enigB964850A7CF8554F933660C3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-12-07 14:53, Ville Syrj=E4l=E4 wrote:
> On Fri, Dec 07, 2012 at 01:55:06PM +0200, Tomi Valkeinen wrote:
>> Kernel lock verification code has lately detected possible circular
>> locking in omapfb. The exact problem is unclear, but omapfb's current
>> locking seems to be overly complex.
>>
>> This patch simplifies the locking in the following ways:
>>
>> - Remove explicit omapfb mem region locking. I couldn't figure out the=

>>   need for this, as long as we take care to take omapfb lock.
>=20
> I suppose the idea with that was that you wouldn't need the global
> omapfb lock, and also it was an rwsem so it allowed parallel access to
> the mem regions, unless the region size was being changed, in which
> case it took the write lock. I can't really remember what the reason
> for using an rwsem was, but I suppose there was one at the time.

Right. Yes, I have no recollection either of the possible reason for it
=3D). Did we have multiple concurrerent users for the fbs? It still sound=
s
like a useless optimization, as all the region locks were only held for
a short time, as far as I saw.

It could also be that we're missing something from the mainline kernel,
which we had in the Nokia kernel, and which would explain the need for
region locks.

> I think the only correctness issue with your patch is that you're
> opening up a race between omapfb_mmap and
> omapfb_setup_mem/store_size.

Good point. I think this can be fixed by taking fb_info->mm_lock in
omapfb_setup_mem & co.

 Tomi



--------------enigB964850A7CF8554F933660C3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQwfIyAAoJEPo9qoy8lh715soP/0o68S6wTQLD6/C9NotTYNZK
kOzSvf3uF8ZHRNWsgOLjuRq9mHzrE4ok495iz/iFRtqN4zhLY04NDXrJz7hPy2F0
H5vl0fzNoML5LLO+BCdA+dhS7unjrrZTNTVaIKsA4bI8wbS2Dro3TInfMX/7H5Mh
PwLlS3H0IaTh8he5IpRetyKvkazrdUxkT3EcMqJsByOCT9ALUoFxBVFG5tCXjyq/
l5aXmV9TohjgHGB10G2AW5mc0HEQD6/+TwwAA5n0ufaWrIFEbD98FbhVQc+0/Z0b
ixeEQlJnnvsmqH+YNoSJqYHJFMaaQF9e5VLfH41lwZL+IDa28kKvybCsDxqgkcqN
Bv5mIU0vtpkrvw+ZtL2yw3E8Q5Lw0Q0BF9GjhdY0P3oiCq/vsWD6DspvpOJokWhn
XP+4GWKJElHfYIlHFhrv+rwwXJsrkvtYEBnLMhDZr/qt1GMjlc2FnL4wT1OfHHHH
BPkuvEw6cQpDsN4ZEdpaHICQEB6lWVuuGLYouMqR+LtRbFZj4qeDP5pb/b0FcaBU
VwneT3biA7475sljhS+wg5wdKcWF7mOwubEAr+FhywpBcLFjGN9w7gz/afwHhBT8
DYFrTlFSEEEPV1QJjRbQhOFR6meenbi7V927DunO1mZsVwlbk8ZQFIW1iHqdHx2g
JQNBZwK9MQbi3pBjhKxP
=foQw
-----END PGP SIGNATURE-----

--------------enigB964850A7CF8554F933660C3--
