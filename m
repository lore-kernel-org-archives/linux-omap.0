From: David Cohen <david.cohen@nokia.com>
Subject: Re: [PATCHv3 1/6] omap3: Add external VBUS power switch and
 overcurrent detect on IGEP v2 board.
Date: Tue, 5 Oct 2010 13:35:16 +0300
Message-ID: <20101005103516.GC12614@esdhcp036161.research.nokia.com>
References: <1285967349-32767-1-git-send-email-eballetbo@gmail.com>
 <1285967349-32767-2-git-send-email-eballetbo@gmail.com>
 <20101002080427.GC14377@esdhcp036161.research.nokia.com>
 <AANLkTin0FBudq5saFhcuonrzK2LqU0UueiN_-C=B0N0j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.ext.nokia.com ([147.243.1.48]:57139 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634Ab0JEKpe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 06:45:34 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTin0FBudq5saFhcuonrzK2LqU0UueiN_-C=B0N0j@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Enric =?iso-8859-1?Q?Balletb=F2?= i Serra <eballetbo@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sat, Oct 02, 2010 at 12:12:32PM +0200, ext Enric Balletb=F2 i Serra =
wrote:
> 2010/10/2 David Cohen <david.cohen@nokia.com>:
> > Hi,
> >
> > On Fri, Oct 01, 2010 at 11:09:04PM +0200, ext Enric Balletbo i Serr=
a wrote:
> >> GPIO for various devices are missing from the board initialization=
=2E
> >> This patch adds support for the VBUS and over current gpios. =A0Wi=
thout this
> >> patch, input/outputs from these two sources are ignored.
> >>
> >> Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
> >> ---
> >> =A0arch/arm/mach-omap2/board-igep0020.c | =A0 16 ++++++++++++++++
> >> =A01 files changed, 16 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-=
omap2/board-igep0020.c
> >> index 175f043..07dbdb7 100644
> >> --- a/arch/arm/mach-omap2/board-igep0020.c
> >> +++ b/arch/arm/mach-omap2/board-igep0020.c
> >> @@ -274,6 +274,22 @@ static int igep2_twl_gpio_setup(struct device=
 *dev,
> >> =A0 =A0 =A0 igep2_vmmc1_supply.dev =3D mmc[0].dev;
> >> =A0 =A0 =A0 igep2_vmmc2_supply.dev =3D mmc[1].dev;
> >>
> >> + =A0 =A0 /*
> >> + =A0 =A0 =A0* REVISIT: need ehci-omap hooks for external VBUS
> >> + =A0 =A0 =A0* power switch and overcurrent detect
> >> + =A0 =A0 =A0*/
> >> + =A0 =A0 if ((gpio_request(gpio + 1, "GPIO_EHCI_NOC") < 0) ||
> >> + =A0 =A0 =A0 =A0 (gpio_direction_input(gpio + 1) < 0))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("IGEP2: Could not obtain gpio for=
 EHCI NOC");
> >
> > Shouldb't you return error if it can't request the GPIO?
>=20
> I'm not sure what happens if I return and error, I see only prints a
> debug message. Maybe the twl4030-gpio maintainer can explain if I nee=
d
> return and error or not.
>=20
> Other omap boards just don't check the gpio_request call and always
> return 0. I don't consider this a critical error so maybe should be
> better replace the pr_err with a pr_warning.

I checked some board files and it seems they're not verifying gpio_requ=
est()
results most of the times. But if you check board-omap3pandor.c, it's
been done in a better way.

Br,

David

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
