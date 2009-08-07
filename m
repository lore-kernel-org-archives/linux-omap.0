From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 00/15] OMAP: DSS intro
Date: Fri, 07 Aug 2009 14:24:31 +0300
Message-ID: <4A7C0EEF.6000506@nokia.com>
References: <1249481741-14008-1-git-send-email-tomi.valkeinen@nokia.com> <4A7C0D56.2000106@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:60525 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757504AbZHGLY4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 07:24:56 -0400
In-Reply-To: <4A7C0D56.2000106@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Quadros Roger (EXT-Teleca/Helsinki)" <ext-roger.quadros@nokia.com>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Quadros Roger (EXT-Teleca/Helsinki) wrote:
> ext Tomi Valkeinen wrote:
>> This patch set implement new display subsystem driver (DSS2) and oma=
pfb driver
>> for OMAP2/3. The patches can also be found from
>> http://gitorious.org/linux-omap-dss2/linux
>>
>> The patches include DSS documentation patch that includes more instr=
uctions for
>> module parameters, sysfs files etc.
>>
>> The patches enable DSS2 for SDP, Beagle and Overo boards.
>>
>> I don't currently have any OMAP2 board to test DSS2, but it has work=
ed on OMAP2
>> and the possible fixes needed should be minimal.
>>
>> OMAP1 is not supported, and so the old DSS needs to be used on OMAP1=
 boards.
>>
>> DSS2 is partly based on the old omapfb driver by Imre Deak, and Imre=
 has also
>> contributed to DSS2 quite a bit. Ville Syrj=C3=A4l=C3=A4 has been co=
ntributing to scaling
>> and tv-out work. Also some contributions have been made by Hardik Sh=
ah, Vaibhav
>> Hiremath, and perhaps some others that I have forgotten =3D).
>>
>> ---
>>
>> [PATCH 01/15] OMAP: OMAPFB: split omapfb.h
>> [PATCH 02/15] OMAP: OMAPFB: add omapdss device
>> [PATCH 03/15] OMAP: Add VRAM manager
>> [PATCH 04/15] OMAP: Add support for VRFB rotation engine
>> [PATCH 05/15] OMAP: DSS2: Documentation for DSS2
>> [PATCH 06/15] OMAP: DSS2: Display Subsystem Driver core
>> [PATCH 07/15] OMAP: DSS2: VENC driver
>> [PATCH 08/15] OMAP: DSS2: RFBI driver
>> [PATCH 09/15] OMAP: DSS2: SDI driver
>> [PATCH 10/15] OMAP: DSS2: DSI driver
>> [PATCH 11/15] OMAP: DSS2: omapfb driver
>> [PATCH 12/15] OMAP: DSS2: Add panel drivers
>> [PATCH 13/15] OMAP: SDP: Enable DSS2 for OMAP3 SDP board
>> [PATCH 14/15] OMAP: Beagle: Enable DSS2 for Beagle board
>> [PATCH 15/15] OMAP: Overo: Enable DSS2 for Overo
>>
>=20
> Tomi,
>=20
> I didn't receive PATCH 06 from the series.

It was too big. It seems to have gone through to linux-fbdev-devel:

http://marc.info/?l=3Dlinux-fbdev-devel&r=3D1&b=3D200908&w=3D2

I have split it up more for next posting.

  Tomi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
