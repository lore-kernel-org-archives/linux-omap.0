From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH 00/12] DSS: Series description
Date: Mon, 12 Jan 2009 16:39:16 +0100
Message-ID: <6942A07D-820D-4700-91DE-D6351E7A5098@student.utwente.nl>
References: <19F8576C6E063C45BE387C64729E739403ECF7099C@dbde02.ent.ti.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-5-64486593"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx3.utsp.utwente.nl ([130.89.2.14]:60610 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752167AbZALPjq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Jan 2009 10:39:46 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E739403ECF7099C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-5-64486593
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 12 jan 2009, om 15:52 heeft Hiremath, Vaibhav het volgende  
geschreven:

>
>
> Thanks,
> Vaibhav Hiremath
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Koen Kooi
>> Sent: Monday, January 12, 2009 7:14 PM
>> To: Tomi Valkeinen
>> Cc: linux-fbdev-devel@lists.sourceforge.net; linux-
>> omap@vger.kernel.org
>> Subject: Re: [PATCH 00/12] DSS: Series description
>>
>>
>> Op 12 jan 2009, om 12:47 heeft Tomi Valkeinen het volgende
>> geschreven:
>>
>>> New Display Subsystem for OMAP2/3
>>> ---------------------------------
>>>
>>> This patch set implements new Display Subsystem (DSS) for OMAP2/3
>>> processors.
>>> The DSS is still under work and these patches are for review.
>>
>> I've tested these patches on beagleboard and omap35x EVM. The
>> beagleboard is fully functional with it, the EVM has some glitches
>> with DVI, but that might be due to differences between revisions of
>> the EVM board (or rather the PMIC + SoC daugtherboards).
>
> [Hiremath, Vaibhav] Koen, I have also tested DVI output on EVM and  
> facing same issues but I believe they are not because of board  
> revisions. I have validated the DVI output with our previous (TI  
> version of DSS library) on the same board and it comes absolutely  
> fine. I need to dig bit more to find where exactly the issue is.

The LCD redtint was fixed by adding guards for OMAP3 ES >= 2.0, so I  
was thinking DVI would need the same :)

regards,

KOen

>> The
>> internal
>> LCD works great on the EVM, the "3 dots in the corner" problem that
>> DSS1 had is gone.
>>
>> Summary: please merge this, for beagleboard and omap3evm there are
>> no
>> regressions, only feature additions (s-video, better pixclock, etc)
>> over the current code.
>>
>> regards,
>>
>> Koen
>>
>>
>>
>>> This is an updated version of the patch set I sent back in
>> november:
>>> http://marc.info/?l=linux-fbdev-devel&m=122581504222406&w=2
>>>
>>> The first patch is a doc file that tries to explain a bit how the
>>> drivers work.
>>>
>>> The patch set is based on the current linux-omap tree.
>>>
>>> You can find the patches also from a git tree at
>>> http://www.bat.org/~tomba/git/linux-omap-dss.git/
>>>
>>> ---
>>>
>>> Tomi Valkeinen (12):
>>>    DSS: Hacked N810 support
>>>    DSS: Support for OMAP3 EVM board
>>>    DSS: Support for OMAP3 SDP board
>>>    DSS: Sharp LS037V7DW01 LCD Panel driver
>>>    DSS: support for Beagle Board
>>>    DSS: Add generic DVI panel
>>>    DSS: OMAPFB: fb driver for new display subsystem
>>>    DSS: DSI support
>>>    DSS: VENC support
>>>    DSS: RFBI support
>>>    DSS: Display subsystem for OMAP2/3
>>>    DSS: Documentation for DSS2
>>>
>>>
>>> Documentation/arm/OMAP/DSS                    |  270 ++
>>> arch/arm/configs/dss_omap3_beagle_defconfig   | 1437 +++++++++++
>>> arch/arm/configs/dss_omap_3430sdp_defconfig   | 1603 +++++++++++++
>>> arch/arm/mach-omap2/board-3430sdp.c           |  215 ++
>>> arch/arm/mach-omap2/board-n800.c              |  214 +-
>>> arch/arm/mach-omap2/board-omap3beagle.c       |  101 +
>>> arch/arm/mach-omap2/board-omap3evm.c          |  203 ++
>>> arch/arm/plat-omap/Kconfig                    |    2
>>> arch/arm/plat-omap/Makefile                   |    4
>>> arch/arm/plat-omap/dss/Kconfig                |   71 +
>>> arch/arm/plat-omap/dss/Makefile               |    6
>>> arch/arm/plat-omap/dss/dispc.c                | 2113
>> +++++++++++++++++
>>> arch/arm/plat-omap/dss/display.c              |  787 ++++++
>>> arch/arm/plat-omap/dss/dpi.c                  |  344 +++
>>> arch/arm/plat-omap/dss/dsi.c                  | 3187
>> ++++++++++++++++
>>> +++++++++
>>> arch/arm/plat-omap/dss/dss.c                  |  774 ++++++
>>> arch/arm/plat-omap/dss/dss.h                  |  274 ++
>>> arch/arm/plat-omap/dss/rfbi.c                 | 1262 ++++++++++
>>> arch/arm/plat-omap/dss/sdi.c                  |  174 +
>>> arch/arm/plat-omap/dss/venc.c                 |  506 ++++
>>> arch/arm/plat-omap/fb-vram.c                  |  646 +++++
>>> arch/arm/plat-omap/fb.c                       |   22
>>> arch/arm/plat-omap/include/mach/display.h     |  462 ++++
>>> arch/arm/plat-omap/include/mach/omapfb.h      |   14
>>> drivers/video/Kconfig                         |    1
>>> drivers/video/Makefile                        |    1
>>> drivers/video/omap/Kconfig                    |    5
>>> drivers/video/omap2/Kconfig                   |   62
>>> drivers/video/omap2/Makefile                  |    8
>>> drivers/video/omap2/ctrl-blizzard.c           |  279 ++
>>> drivers/video/omap2/omapfb-ioctl.c            |  460 ++++
>>> drivers/video/omap2/omapfb-main.c             | 1442 +++++++++++
>>> drivers/video/omap2/omapfb-sysfs.c            |  901 +++++++
>>> drivers/video/omap2/omapfb.h                  |  115 +
>>> drivers/video/omap2/panel-generic.c           |   97 +
>>> drivers/video/omap2/panel-n800.c              |  437 +++
>>> drivers/video/omap2/panel-sharp-ls037v7dw01.c |  109 +
>>> 37 files changed, 18537 insertions(+), 71 deletions(-)
>>> create mode 100644 Documentation/arm/OMAP/DSS
>>> create mode 100644 arch/arm/configs/dss_omap3_beagle_defconfig
>>> create mode 100644 arch/arm/configs/dss_omap_3430sdp_defconfig
>>> create mode 100644 arch/arm/plat-omap/dss/Kconfig
>>> create mode 100644 arch/arm/plat-omap/dss/Makefile
>>> create mode 100644 arch/arm/plat-omap/dss/dispc.c
>>> create mode 100644 arch/arm/plat-omap/dss/display.c
>>> create mode 100644 arch/arm/plat-omap/dss/dpi.c
>>> create mode 100644 arch/arm/plat-omap/dss/dsi.c
>>> create mode 100644 arch/arm/plat-omap/dss/dss.c
>>> create mode 100644 arch/arm/plat-omap/dss/dss.h
>>> create mode 100644 arch/arm/plat-omap/dss/rfbi.c
>>> create mode 100644 arch/arm/plat-omap/dss/sdi.c
>>> create mode 100644 arch/arm/plat-omap/dss/venc.c
>>> create mode 100644 arch/arm/plat-omap/fb-vram.c
>>> create mode 100644 arch/arm/plat-omap/include/mach/display.h
>>> create mode 100644 drivers/video/omap2/Kconfig
>>> create mode 100644 drivers/video/omap2/Makefile
>>> create mode 100644 drivers/video/omap2/ctrl-blizzard.c
>>> create mode 100644 drivers/video/omap2/omapfb-ioctl.c
>>> create mode 100644 drivers/video/omap2/omapfb-main.c
>>> create mode 100644 drivers/video/omap2/omapfb-sysfs.c
>>> create mode 100644 drivers/video/omap2/omapfb.h
>>> create mode 100644 drivers/video/omap2/panel-generic.c
>>> create mode 100644 drivers/video/omap2/panel-n800.c
>>> create mode 100644 drivers/video/omap2/panel-sharp-ls037v7dw01.c
>>>
>>> --
>>> Tomi Valkeinen
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-
>>> omap" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>
>


--Apple-Mail-5-64486593
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJa2QnMkyGM64RGpERArN/AJ4xPPCnRLyQPZmHpjELd878/8lDAQCfZfpg
+VpNw5ljXiZGSI8+XQYbJK4=
=BNtJ
-----END PGP SIGNATURE-----

--Apple-Mail-5-64486593--
