From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: Let DT say what devices should not to
 idled or reset
Date: Wed, 9 Oct 2013 13:07:08 +0530
Message-ID: <525507A4.9010308@ti.com>
References: <1376983966-16490-1-git-send-email-rnayak@ti.com> <1376983966-16490-4-git-send-email-rnayak@ti.com> <alpine.DEB.2.02.1310090720230.30199@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40275 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752586Ab3JIHho (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Oct 2013 03:37:44 -0400
In-Reply-To: <alpine.DEB.2.02.1310090720230.30199@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: bcousson@baylibre.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org

On Wednesday 09 October 2013 12:54 PM, Paul Walmsley wrote:
> Hi Beno=EEt, Rajendra,
>=20
> On Tue, 20 Aug 2013, Rajendra Nayak wrote:
>=20
>> Now that we have DT bindings to specify which devices on the SoC sho=
uld not
>> be reset or idled, get rid of the same information existing as part =
of the
>> hwmod data files and pass this info from DT instead.
>>
>> For GPMC, the HWMOD_INIT_NO_RESET flag seems to be added in hwmod no=
t due to
>> any errata around the GPMC IP, but rather because any timings
>> set by the bootloader are not being correctly programmed by the kern=
el.
>> This seems like something that needs to be fixed as part of GPMC dri=
ver
>> in the kernel, and hence the flag is left as is in hwmod, which can =
be
>> removed once the driver does what its expected to.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> ---
>>  arch/arm/boot/dts/am33xx.dtsi              |    2 ++
>>  arch/arm/boot/dts/omap4.dtsi               |    3 +++
>>  arch/arm/boot/dts/omap5.dtsi               |    2 ++
>>  arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    4 ++--
>>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    4 +---
>>  arch/arm/mach-omap2/omap_hwmod_54xx_data.c |    2 --
>>  6 files changed, 10 insertions(+), 7 deletions(-)
>=20
> Looking at this one, maybe the best thing for this patch is for Rajen=
dra=20
> to split it into two patches.  Beno=EEt can merge the DTS patch first=
, then=20
> I can merge the hwmod side as a cleanup once the first one goes in.  =
That=20
> will avoid conflicts from other DTS and hwmod changes going into the =
tree.
>=20
> Rajendra, when you do the split, please add in the DT documentation p=
art=20
> from patch 2.  Am going to strip that out from the second patch and j=
ust=20
> merge the hwmod changes.
>=20
> Sound good?

Sure Paul, I'll repost the complete series with proper splits such that=
 its
easier for you and Benoit to pick them up independently.

>=20
>=20
> - Paul
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
