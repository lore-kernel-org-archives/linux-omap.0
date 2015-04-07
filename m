From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: OMAP DRA7xx display-related hwmod data
 changes for v4.1
Date: Tue, 7 Apr 2015 15:11:29 +0300
Message-ID: <5523C971.1030904@ti.com>
References: <alpine.DEB.2.02.1504031953150.19540@utopia.booyaka.com> <20150403230833.GB18048@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="qttsJJHJDjdNtOkbB0vkJFxgFbcCgMahq"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37545 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752605AbbDGMMA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Apr 2015 08:12:00 -0400
In-Reply-To: <20150403230833.GB18048@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, arm@kernel.org, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--qttsJJHJDjdNtOkbB0vkJFxgFbcCgMahq
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

No, don't pull this, it doesn't work.

Paul, the hwmod patch cannot be picked from the DRA7 DSS series. We have
the problem with the DES HDCP clock, without that clock we will see
WARNINGs when booting if the "set DSS submodule parent hwmods" is applied=
=2E

We do see some errors when booting even with the current mainline,
caused by not having that clock enabled:

[    0.194524] omap_hwmod: dss_core: _wait_target_disable failed
[    0.194540] omap_hwmod: dss_core: _wait_target_ready failed: -16
[    0.194554] omap_hwmod: dss_core: cannot be enabled for reset (3)
[    0.197143] omap_hwmod: dss_dispc: _wait_target_ready failed: -16
[    0.197156] omap_hwmod: dss_dispc: cannot be enabled for reset (3)
[    0.199745] omap_hwmod: dss_hdmi: _wait_target_ready failed: -16
[    0.199759] omap_hwmod: dss_hdmi: cannot be enabled for reset (3)

But that's still much less spam than the above plus ~4 WARNs.

I'd rather merge the DRA7 DSS patches in one go, to avoid issues related
to the HDPC clock.

 Tomi

On 04/04/15 02:08, Tony Lindgren wrote:
> Hi Arnd & Olof,
>=20
> Please feel free to pull this directly from Paul.
>=20
> Regards,
>=20
> Tony
>=20
> * Paul Walmsley <paul@pwsan.com> [150403 12:55]:
>> Hi Tony
>>
>> The following changes since commit c517d838eb7d07bbe9507871fab3931decc=
ff539:
>>
>>   Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git t=
ags/for-v4.1/omap-hwmod-b
>>
>> for you to fetch changes up to 0d75ebdd3230b3d085812df80ec54138828cc76=
a:
>>
>>   ARM: DRA7: hwmod: set DSS submodule parent hwmods (2015-04-03 13:15:=
07 -0600)
>>
>> ----------------------------------------------------------------
>> OMAP DRA7xx display-related hwmod data changes for v4.1
>>
>> Add DMM hwmod data for DRA7xx, and set the parent hwmods fields
>> appropriately for the DRA7xx DSS submodules as we've done for
>> other OMAP devices.
>>
>> Note that I do not have a DRA7xx board, and thus cannot boot-test
>> these patches.
>>
>> Basic build, boot, and PM idle test logs are available at:
>>
>> http://www.pwsan.com/omap/testlogs/omap-hwmod-b-for-v4.1/2015040312370=
2/
>>
>> ----------------------------------------------------------------
>> Tomi Valkeinen (2):
>>       ARM: DRA7: hwmod: add DMM hwmod description
>>       ARM: DRA7: hwmod: set DSS submodule parent hwmods
>>
>>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 32 ++++++++++++++++++++++=
+++++++++
>>  1 file changed, 32 insertions(+)
>>
>>
>>
>> vmlinux object size
>> (delta in bytes from test_v4.0-rc1 (c517d838eb7d07bbe9507871fab3931dec=
cff539)):
>>    text     data      bss    total  kernel
>>       0        0        0        0  omap1_defconfig
>>       0        0        0        0  omap1_defconfig_1510innovator_only=

>>       0        0        0        0  omap1_defconfig_5912osk_only
>>       0     +192        0     +192  multi_v7_defconfig
>>       0     +216        0     +216  omap2plus_defconfig
>>       0        0        0        0  omap2plus_defconfig_2430sdp_only
>>       0        0        0        0  omap2plus_defconfig_am33xx_only
>>       0        0        0        0  omap2plus_defconfig_am43xx_only
>>       0     +224        0     +224  omap2plus_defconfig_cpupm
>>       0     +192        0     +192  omap2plus_defconfig_dra7xx_only
>>       0        0        0        0  omap2plus_defconfig_n800_multi_oma=
p2xxx
>>       0        0        0        0  omap2plus_defconfig_n800_only_a
>>       0     +192        0     +192  omap2plus_defconfig_no_pm
>>       0        0        0        0  omap2plus_defconfig_omap2_4_only
>>       0        0        0        0  omap2plus_defconfig_omap3_4_only
>>       0        0        0        0  omap2plus_defconfig_omap5_only
>>       0        0        0        0  rmk_omap3430_ldp_allnoconfig
>>       0        0        0        0  rmk_omap3430_ldp_oldconfig
>>      +8        0       -8        0  rmk_omap4430_sdp_allnoconfig
>>       0        0        0        0  rmk_omap4430_sdp_oldconfig
>>
>> Boot-time memory difference
>> (delta in bytes from test_v4.0-rc1 (c517d838eb7d07bbe9507871fab3931dec=
cff539))
>>   avail  rsrvd   high  freed  board          kconfig
>>     -4k     4k      .      .  4460pandaes    omap2plus_defconfig
>>    -12k    12k      .      .  4460varsomom   omap2plus_defconfig
>>     -4k     4k      .      .  5430es2sbct54  omap2plus_defconfig
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20



--qttsJJHJDjdNtOkbB0vkJFxgFbcCgMahq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJVI8lxAAoJEPo9qoy8lh719BQP/2ZJzJUdi+ELQlqsvfJs0sqY
ejiSQ5m+h6d/0bzS6DJynjw+1XPGnH/f8iNZTub3/MCS92s3Ao+1uUoAQQAt5Tag
rbeNVO0zaR2GSNDO1eU+8U4I56WABaMWexd/RKrG+6CpYhJO9DrRZJkEirSUEDfx
MAcpLddCMSDNkRVqPyZHlIv9A4Cjuav+XlGXsfcsk3iD8WsO1DluljPTHHZ92W6+
MBSZQvUPzT8806CkQzaPfp+cbjfqboLRwT5bO2dYbWAL1avOo2qBJbKpHvfZyAgY
Fr079izaaPd1aW99lEcfp+t+nBZnOaDRDRiCj2sWhIPxjtAx9oGkh2lJ6HhEquHo
xs34h7Z/iLD4lyMNMoSlXb7o55dUpIZcNcLtk1SBGtAiiZqwe82PmgWU8/+7m2VI
z+t0a7Se6l/U7WlmqVf6HAdH6w81yuyQ56Y3g12rbpoeuHSi1rddbzDF3DRY4CAl
DBiqJWGb9svup+HjpWi6zsph31OPX6V+vxPQS4Rh4yQpuAQDkBZikOhHNPGDv8VH
pekmKMk/COsz6DGcrEadTaHrJ9pAF0VD/nf5Dt6DLY+mct+gBsr+WmyMkEm08rRD
iPhWUl6ECjF+nnY/s2yeRptI7aFQvyKM76zll7GFL+CfBl2uPeft/e/A42Ohp+/V
vGPP+SnnJyQI85cUL2SN
=dZEU
-----END PGP SIGNATURE-----

--qttsJJHJDjdNtOkbB0vkJFxgFbcCgMahq--
