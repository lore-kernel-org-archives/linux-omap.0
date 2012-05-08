From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH V3 05/10] ARM: OMAP2+: SmartReflex: introduce a busy
 loop condition test macro
Date: Tue, 8 May 2012 10:17:41 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13E9B667C@DBDE01.ent.ti.com>
References: <1335462041-4949-1-git-send-email-j-keerthy@ti.com>
	<1335462041-4949-6-git-send-email-j-keerthy@ti.com>
	<331ABD5ECB02734CA317220B2BBEABC13E9B1B40@DBDE01.ent.ti.com>
 <CAJ6a13aA9nutZvRkcj8GHok9cEe8A=J2bwzSXt=Sd0Hu_WPaPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJ6a13aA9nutZvRkcj8GHok9cEe8A=J2bwzSXt=Sd0Hu_WPaPw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, "rjw@sisk.pl" <rjw@sisk.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "Pihet-XID, Jean" <j-pihet@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, May 07, 2012 at 10:51:53, J, KEERTHY wrote:
> On Fri, May 4, 2012 at 2:42 PM, AnilKumar, Chimata <anilkumar@ti.com>=
 wrote:
> > On Thu, Apr 26, 2012 at 23:10:36, J, KEERTHY wrote:
> >> From: Jean Pihet <j-pihet@ti.com>
> >>
> >> Now that omap_test_timeout is only accessible from mach-omap2/,
> >> introduce a similar function for SR.
> >>
> >> This change makes the SmartReflex implementation ready for the mov=
e
> >> to drivers/.
> >>
> >> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> >> Signed-off-by: J Keerthy <j-keerthy@ti.com>
> >> ---
> >> =A0arch/arm/mach-omap2/smartreflex.c | =A0 12 ++++++------
> >> =A0include/linux/power/smartreflex.h | =A0 23 ++++++++++++++++++++=
++-
> >> =A02 files changed, 28 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-oma=
p2/smartreflex.c
> >> index d859277..acef08d 100644
> >> --- a/arch/arm/mach-omap2/smartreflex.c
> >> +++ b/arch/arm/mach-omap2/smartreflex.c
> >> @@ -289,9 +289,9 @@ static void sr_v1_disable(struct omap_sr *sr)
> >> =A0 =A0 =A0 =A0* Wait for SR to be disabled.
> >> =A0 =A0 =A0 =A0* wait until ERRCONFIG.MCUDISACKINTST =3D 1. Typica=
l latency is 1us.
> >> =A0 =A0 =A0 =A0*/
> >> - =A0 =A0 omap_test_timeout((sr_read_reg(sr, ERRCONFIG_V1) &
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ERRCONFIG_MCUDISACKINTST=
), SR_DISABLE_TIMEOUT,
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout);
> >> + =A0 =A0 sr_test_cond_timeout((sr_read_reg(sr, ERRCONFIG_V1) &
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ERRCONFIG_MCU=
DISACKINTST), SR_DISABLE_TIMEOUT,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timeout);
> >>
> >> =A0 =A0 =A0 if (timeout >=3D SR_DISABLE_TIMEOUT)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&sr->pdev->dev, "%s: Smartref=
lex disable timedout\n",
> >> @@ -334,9 +334,9 @@ static void sr_v2_disable(struct omap_sr *sr)
> >> =A0 =A0 =A0 =A0* Wait for SR to be disabled.
> >> =A0 =A0 =A0 =A0* wait until IRQSTATUS.MCUDISACKINTST =3D 1. Typica=
l latency is 1us.
> >> =A0 =A0 =A0 =A0*/
> >> - =A0 =A0 omap_test_timeout((sr_read_reg(sr, IRQSTATUS) &
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQSTATUS_MCUDISABLEACKI=
NT), SR_DISABLE_TIMEOUT,
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout);
> >> + =A0 =A0 sr_test_cond_timeout((sr_read_reg(sr, IRQSTATUS) &
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0IRQSTATUS_MCU=
DISABLEACKINT), SR_DISABLE_TIMEOUT,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timeout);
> >>
> >> =A0 =A0 =A0 if (timeout >=3D SR_DISABLE_TIMEOUT)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&sr->pdev->dev, "%s: Smartref=
lex disable timedout\n",
> >> diff --git a/include/linux/power/smartreflex.h b/include/linux/pow=
er/smartreflex.h
> >> index 884eaee..78b795e 100644
> >> --- a/include/linux/power/smartreflex.h
> >> +++ b/include/linux/power/smartreflex.h
> >> @@ -22,7 +22,7 @@
> >>
> >> =A0#include <linux/types.h>
> >> =A0#include <linux/platform_device.h>
> >> -
> >> +#include <linux/delay.h>
> >> =A0#include <plat/voltage.h>
> >>
> >> =A0/*
> >> @@ -168,6 +168,27 @@ struct omap_sr {
> >> =A0};
> >>
> >> =A0/**
> >> + * test_cond_timeout - busy-loop, testing a condition
> >> + * @cond: condition to test until it evaluates to true
> >> + * @timeout: maximum number of microseconds in the timeout
> >> + * @index: loop index (integer)
> >> + *
> >> + * Loop waiting for @cond to become true or until at least @timeo=
ut
> >> + * microseconds have passed. =A0To use, define some integer @inde=
x in the
> >> + * calling code. =A0After running, if @index =3D=3D @timeout, the=
n the loop has
> >> + * timed out.
> >> + *
> >> + * Copied from omap_test_timeout */
> >> +#define sr_test_cond_timeout(cond, timeout, index) =A0 =A0 =A0 =A0=
 =A0 \
> >> +({ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> >> + =A0 =A0 for (index =3D 0; index < timeout; index++) { =A0 =A0 =A0=
 =A0 =A0 =A0 \
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (cond) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break; =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> >> + =A0 =A0 =A0 =A0 =A0 =A0 udelay(1); =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> >> + =A0 =A0 } =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> >> +})
> >
> > I think we can use time_after()/time_before() APIs for timeout and =
cpu_relax() for
> > tight loops instead of udelay().
>=20
> cpu_relax() changes the priority everytime to low and will yield to
> another thread.
> Considering that we are checking the condition every microsecond does=
 it make
> some saving using cpu_relax().
>=20

cpu_relax() does not involve any priority changes or scheduling AFAICS.
Have a look at this thread:

http://www.spinics.net/lists/netdev/msg151699.html

Regards
AnilKumar
