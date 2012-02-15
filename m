From: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Subject: Re: [RFC 00/11]O MAP/ASoC: Move and merge McBSP driver
	under ASoC
Date: Wed, 15 Feb 2012 17:56:15 +0200
Message-ID: <CAPo=G1z6H+ZXd-cmYSpKXC-XNci7=iUz2he62ze9MyErkmUfOA@mail.gmail.com>
References: <1329320280-1621-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1329320280-1621-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, jkrzyszt@tis.icnet.pl
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

CC-ing Janusz, since he is the only one I know who have, and use OMAP1
with audio...
Janusz: if your time allows would you be able to test this series on
OMAP1 (it compiles...)?

Thanks,
P=E9ter


On Wed, Feb 15, 2012 at 5:37 PM, Peter Ujfalusi <peter.ujfalusi@ti.com> wro=
te:
> Hello,
>
> The aim of this series is to move the plat-omap/mcbsp.c driver out to
> sound/soc/omap/
> By doing this we can combine the two levels of McBSP driver stack into a =
single
> one.
> Formally we had omap-mcbsp.[1-X] drivers (plat-omap/mcbsp.c), and
> omap-mcbsp-dai.[0-(X-1) drivers (sound/soc/omap/omap-mcbsp.c).
> We had global, shared structures, variables, pointers. The API between th=
e two
> driver was a set of exported function calls where one of the parameter wa=
s the
> McBSP port id.
>
> With this series we will have one driver for McBSP (omap-mcbsp.[1-X]) whi=
ch is
> basically the ASoC dai driver. All exported/shared global structures are =
gone
> since we can use driver data for all ports in this way.
>
> With the code in one place we can do further clean up in the McBSP driver=
, and
> adding new features will be much easier in the future. Also the DT suppor=
t for
> McBSP will be significantly easier if we have one set of driver.
>
> McBSP is only used by audio, there are no known other users of the OMAP M=
cBSP
> (well, Nokia n700 has the WLAN connected through McBSP but we do not have
> driver for that anyway).
>
> The series was created against Takashi's topic/asoc branch. I have tested=
 it on
> Beagle xM, and compile tested it for OMAP1, OMAP2, and OMAP4 as well.
>
> I'm going to do more work on the cleanup, and the plan is to merge the tw=
o files
> into one (mcbsp.c -> omap-mcbsp.c) eventually.
>
> Comments, testers are welcome...
>
> CC-ing Samuel as well since he is the original author of the plat-omap/mc=
bsp.c
> driver.
>
> Regards,
> Peter
> ---
> Peter Ujfalusi (11):
> =A0ARM: OMAP: mcbsp: Convert core driver to proper platform driver
> =A0OMAP: mcbsp: Move core driver under sound/soc/omap
> =A0ASoC: OMAP: McBSP: Consolidate plat/mcbsp.h content
> =A0ASoC: core - Add API call to register dai kcontrols.
> =A0ASoC: omap-mcbsp: Create a single driver for McBSP
> =A0ARM: OMAP: Do not register omap-mcbsp-dai device
> =A0ASoC: OMAP: mcbsp.h: Clean up bit definitions
> =A0ASoC: OMAP McBSP: Remove redundant accessors
> =A0ASoC: omap-mcbsp: Cleanup of module probe/remove code
> =A0ASoC: omap-mcbsp: Merge the omap_mcbsp_data into omap_mcbsp structure
> =A0ASoC: omap-mcbsp: Simplify DMA configuration
>
> =A0arch/arm/mach-omap1/devices.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A09 -
> =A0arch/arm/mach-omap1/mcbsp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 14 +-
> =A0arch/arm/mach-omap2/devices.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 22 --
> =A0arch/arm/mach-omap2/mcbsp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A08 +-
> =A0arch/arm/plat-omap/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A08 -
> =A0arch/arm/plat-omap/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A02 -
> =A0arch/arm/plat-omap/include/plat/mcbsp.h =A0 =A0 =A0 =A0| =A0321 ------=
----------
> =A0include/sound/soc.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A02 +
> =A0sound/soc/omap/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A04 +
> =A0sound/soc/omap/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A01 +
> =A0sound/soc/omap/am3517evm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A02 +-
> =A0sound/soc/omap/ams-delta.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A02 +-
> =A0sound/soc/omap/igep0020.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A02 +-
> =A0{arch/arm/plat-omap =3D> sound/soc/omap}/mcbsp.c | =A0463 ++++--------=
------------
> =A0sound/soc/omap/mcbsp.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0337 +++++++++++++++++
> =A0sound/soc/omap/n810.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A02 +-
> =A0sound/soc/omap/omap-mcbsp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0287 ++++++++-------
> =A0sound/soc/omap/omap-mcbsp.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A02 +-
> =A0sound/soc/omap/omap-pcm.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A02 +
> =A0sound/soc/omap/omap3beagle.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A02 +-
> =A0sound/soc/omap/omap3evm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A02 +-
> =A0sound/soc/omap/omap3pandora.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A04 +-
> =A0sound/soc/omap/osk5912.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 =A02 +-
> =A0sound/soc/omap/overo.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A02 +-
> =A0sound/soc/omap/rx51.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A04 +-
> =A0sound/soc/omap/sdp3430.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 =A04 +-
> =A0sound/soc/omap/zoom2.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A04 +-
> =A0sound/soc/soc-core.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0 31 ++
> =A028 files changed, 631 insertions(+), 914 deletions(-)
> =A0rename {arch/arm/plat-omap =3D> sound/soc/omap}/mcbsp.c (69%)
> =A0create mode 100644 sound/soc/omap/mcbsp.h
>
> --
> 1.7.8.4
>
