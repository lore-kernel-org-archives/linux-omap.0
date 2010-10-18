From: "Nilofer, Samreen" <samreen@ti.com>
Subject: RE: [PATCH v2] OMAP3: DSS: Kconfig changes to enable display
 options on OMAP3
Date: Mon, 18 Oct 2010 17:14:41 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087034BB00C1D@dbde02.ent.ti.com>
References: <1287381341-4450-1-git-send-email-samreen@ti.com>
	<AANLkTimrSj0_ussokxOnwqF=kWQoRt=cefyxDbBYXs0E@mail.gmail.com>
 <AANLkTi=g3iXKcFRLz1Spyke1xJ0cgsS5LDWRvEnY0Ukh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47443 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755163Ab0JRLot convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Oct 2010 07:44:49 -0400
In-Reply-To: <AANLkTi=g3iXKcFRLz1Spyke1xJ0cgsS5LDWRvEnY0Ukh@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Grazvydas Ignotas wrote:
> On Mon, Oct 18, 2010 at 12:37 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Mon, Oct 18, 2010 at 8:55 AM, Samreen <samreen@ti.com> wrote:
>>> The defconfig options for display are taken in the respective Kconf=
ig
>>> to enable display by default on OMAP3 platforms
>>=20
>>=20
>>> =A0config FB_OMAP2_NUM_FBS
>>> =A0 =A0 =A0 =A0int "Number of framebuffers"
>>> =A0 =A0 =A0 =A0range 1 10
>>> - =A0 =A0 =A0 default 3
>>> + =A0 =A0 =A0 default 1 =A0if ARCH_OMAP2 || ARCH_OMAP3
>>> + =A0 =A0 =A0 default 3 =A0if ARCH_OMAP4
>>> =A0 =A0 =A0 =A0depends on FB_OMAP2
>>> =A0 =A0 =A0 =A0help
>>> =A0 =A0 =A0 =A0 =A0Select the number of framebuffers created. OMAP2=
/3 has 3
>>> overlays
>>=20
>> I think this should be 3 also for OMAP3.
>=20
> Right, please don't change defaults out of the blue like this.
>=20
> Also when sending DSS patches, please CC linux-fbdev and DSS
> maintainer (Tomi), run ./scripts/get_maintainer.pl <your patch> for
> maintainers.=20

Will fix this, and will make sure to include the right maintainers
While posting the patches.

-Samreen --
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
