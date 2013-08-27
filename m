From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/21] ARM: OMAP2+: use new display drivers
Date: Tue, 27 Aug 2013 12:20:57 +0300
Message-ID: <521C6F79.9070806@ti.com>
References: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com> <5204CA12.5070203@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="mDiaErbpiaF3bUjNquw4lPlTvlRsCg43t"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42019 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752692Ab3H0JV1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Aug 2013 05:21:27 -0400
In-Reply-To: <5204CA12.5070203@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--mDiaErbpiaF3bUjNquw4lPlTvlRsCg43t
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Tony,

Ping again...

 Tomi

On 09/08/13 13:53, Tomi Valkeinen wrote:
> Hi Tony,
>=20
> Ping. It'd be nice to get this in for 3.12, so I can remove all the old=

> drivers and the related legacy code.
>=20
> Note that the first patch "ARM: OMAP: dss-common: fix Panda's DVI DDC
> channel", is a fix for 3.11, and I've sent a fbdev pull request
> containing that just now. Merging without that patch will cause a
> trivial conflict. If you want, I can also create a branch that has thes=
e
> on top of the fbdev-fixes branch.
>=20
>  Tomi
>=20
> On 26/07/13 10:08, Tomi Valkeinen wrote:
>> Hi,
>>
>> The display drivers for new OMAP DSS driver model were merged in v3.11=
, but the
>> board files were not changed to use them. This series changes the boar=
d files
>> to take those new drivers into use.
>>
>> There's mostly nothing special in the patches. One complication is wit=
h Overo
>> board file, which adds two panel devices, located in add-on boards, th=
at use
>> the same GPIOs, meaning that the two panel devices cannot be probed at=
 the same
>> time. The solution used here is to parse the kernel command line, and =
decide
>> the panel device to be added depending on the given default display.
>>
>> The omap2plus_defconfig is changed to include a few most commonly used=
 display
>> drivers as modules, and the old drivers are removed.
>>
>> Note: The first patch in this series has been sent separately
>> (http://mid.gmane.org/1374570405-8301-2-git-send-email-tomi.valkeinen@=
ti.com),
>> and is a fix for v3.11. It's included here as an another patch in the =
series
>> depends on it.
>>
>> Tested on 4430SDP, Panda, Beagle, Beagle xM, Overo.
>>
>>  Tomi
>>
>> Tomi Valkeinen (21):
>>   ARM: OMAP: dss-common: fix Panda's DVI DDC channel
>>   ARM: OMAP2+: Remove legacy DSS initialization for omap4
>>   ARM: OMAP2+: Add selected display drivers to omap2plus_defconfig
>>   ARM: OMAP: dss-common: use new display drivers
>>   ARM: OMAP: 4430SDP: remove picodlp device data
>>   ARM: OMAP: overo: use new display drivers
>>   ARM: OMAP: rx51: use new display drivers
>>   ARM: OMAP: beagle: use new display drivers
>>   ARM: OMAP: devkit8000: use new display drivers
>>   ARM: OMAP: 2430SDP: use new display drivers
>>   ARM: OMAP: LDP: use new display drivers
>>   ARM: OMAP: omap3stalker: use new display drivers
>>   ARM: OMAP: igep0020: use new display drivers
>>   ARM: OMAP: cm-t35: use new display drivers
>>   ARM: OMAP: H4: use new display drivers
>>   ARM: OMAP: 3430SDP: use new display drivers
>>   ARM: OMAP: OMAP3EVM: use new display drivers
>>   ARM: OMAP: Pandora: use new display drivers
>>   ARM: OMAP: Zoom: use new display drivers
>>   ARM: OMAP: AM3517EVM: use new display drivers
>>   ARM: OMAP2+: Remove old display drivers from omap2plus_defconfig
>>
>>  arch/arm/configs/omap2plus_defconfig         |  12 +-
>>  arch/arm/mach-omap2/board-2430sdp.c          |  57 ++++---
>>  arch/arm/mach-omap2/board-3430sdp.c          |  83 +++++----
>>  arch/arm/mach-omap2/board-am3517evm.c        | 113 +++++++++----
>>  arch/arm/mach-omap2/board-cm-t35.c           | 100 +++++++----
>>  arch/arm/mach-omap2/board-devkit8000.c       |  96 +++++++----
>>  arch/arm/mach-omap2/board-h4.c               |  48 ++++--
>>  arch/arm/mach-omap2/board-igep0020.c         |  36 ++--
>>  arch/arm/mach-omap2/board-ldp.c              |  68 +++++---
>>  arch/arm/mach-omap2/board-omap3beagle.c      |  56 +++---
>>  arch/arm/mach-omap2/board-omap3evm.c         |  87 ++++++----
>>  arch/arm/mach-omap2/board-omap3pandora.c     |  48 +++---
>>  arch/arm/mach-omap2/board-omap3stalker.c     |  61 ++++---
>>  arch/arm/mach-omap2/board-overo.c            | 160 +++++++++++-------=

>>  arch/arm/mach-omap2/board-rx51-peripherals.c |  12 ++
>>  arch/arm/mach-omap2/board-rx51-video.c       |  35 ++--
>>  arch/arm/mach-omap2/board-zoom-display.c     |  30 ++--
>>  arch/arm/mach-omap2/dss-common.c             | 244 ++++++++++++------=
---------
>>  arch/arm/mach-omap2/dss-common.h             |   2 -
>>  19 files changed, 787 insertions(+), 561 deletions(-)
>>
>=20
>=20



--mDiaErbpiaF3bUjNquw4lPlTvlRsCg43t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSHG99AAoJEPo9qoy8lh71Ik0P/1l0n2ewurLMzf/vpMj9f2aE
/mgXrzul+ryySCWpPfHWqrAAn8OUPbNPvz2nGIcQxHfttJBGU1QXs8xNn4Hn43cZ
jNSoGzKUJf2LVX49dVRotXIc8+ZOzZ7DqxqXi8GHVTSHqNIZQ0sxoR54LAtzQ+t0
X5GoNTFgHt89Nj17LWwX2r4JoHIUDvHhJgIAQEAklwDnLYX2kbdsR+jWnXH6l2ct
AJZT5qc+8cuh7EjyOTLHV9o1XFGn1OotQYa9FBDzjPUgYB07uFZ1hT5NwRvuR1Rw
3OVCmEwizJrNvX4/fmGxHESyjhDyC/4ZXD/XvexBnwKN/tZeq9ZtP94+88mpkZvW
0QKEegdsOl5F5xAzYBXZ1w7eyrp1tA6PUd9EAAVZEDpngXFEPmHiyZ8MALUi8tw6
L+DQlkrwf3MfY2Ir5dOaXNYqHsbk8xMEhScpuAzqiWR1fpESJY7AG9O6SkBLBviq
fgcCysgx79Egmya4lk0JX0F++U/k8inSbfJ4+zulhMtbeF2L7wuWs+Jg9glnpHsK
KWRQyXykjF0RUs8g5EKWydl1d90ph0NFt9mkYENzc+u6Ij5GGb431XWHwKSi2Tv8
QTSwxojE5vqIt7/xkIp7Q7LABhzvcBqNgotAv5ELK0Uo46Ic3/OcQp+u5N7gM9xx
9yS3Qk3QO4Sqmce0tOWO
=H5G8
-----END PGP SIGNATURE-----

--mDiaErbpiaF3bUjNquw4lPlTvlRsCg43t--
