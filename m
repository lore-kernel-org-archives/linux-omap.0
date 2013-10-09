From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: Let DT say what devices should not to
 idled or reset
Date: Wed, 9 Oct 2013 07:24:53 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1310090720230.30199@utopia.booyaka.com>
References: <1376983966-16490-1-git-send-email-rnayak@ti.com> <1376983966-16490-4-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-833251992-1381303395=:30199"
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1376983966-16490-4-git-send-email-rnayak@ti.com>
Content-ID: <alpine.DEB.2.02.1310090723200.30199@utopia.booyaka.com>
Sender: linux-doc-owner@vger.kernel.org
To: bcousson@baylibre.com, Rajendra Nayak <rnayak@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-833251992-1381303395=:30199
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.02.1310090723201.30199@utopia.booyaka.com>

Hi Beno=EEt, Rajendra,

On Tue, 20 Aug 2013, Rajendra Nayak wrote:

> Now that we have DT bindings to specify which devices on the SoC should n=
ot
> be reset or idled, get rid of the same information existing as part of th=
e
> hwmod data files and pass this info from DT instead.
>=20
> For GPMC, the HWMOD_INIT_NO_RESET flag seems to be added in hwmod not due=
 to
> any errata around the GPMC IP, but rather because any timings
> set by the bootloader are not being correctly programmed by the kernel.
> This seems like something that needs to be fixed as part of GPMC driver
> in the kernel, and hence the flag is left as is in hwmod, which can be
> removed once the driver does what its expected to.
>=20
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/boot/dts/am33xx.dtsi              |    2 ++
>  arch/arm/boot/dts/omap4.dtsi               |    3 +++
>  arch/arm/boot/dts/omap5.dtsi               |    2 ++
>  arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    4 ++--
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    4 +---
>  arch/arm/mach-omap2/omap_hwmod_54xx_data.c |    2 --
>  6 files changed, 10 insertions(+), 7 deletions(-)

Looking at this one, maybe the best thing for this patch is for Rajendra=20
to split it into two patches.  Beno=EEt can merge the DTS patch first, then=
=20
I can merge the hwmod side as a cleanup once the first one goes in.  That=
=20
will avoid conflicts from other DTS and hwmod changes going into the tree.

Rajendra, when you do the split, please add in the DT documentation part=20
from patch 2.  Am going to strip that out from the second patch and just=20
merge the hwmod changes.

Sound good?


- Paul
--843723315-833251992-1381303395=:30199--
