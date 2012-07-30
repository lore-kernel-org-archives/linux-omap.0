From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V2 08/10] ARM: OMAP4: Prevent EMU power domain transitioning
 to OFF when in-use
Date: Mon, 30 Jul 2012 18:26:57 -0500
Message-ID: <50171841.40309@ti.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com> <1339104132-26885-9-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1207111441300.25585@utopia.booyaka.com> <500028B3.1040309@ti.com> <alpine.DEB.2.00.1207131418500.25585@utopia.booyaka.com> <50045D17.9050704@ti.com> <alpine.DEB.2.00.1207161228470.28834@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50206 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754975Ab2G3X1B (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jul 2012 19:27:01 -0400
In-Reply-To: <alpine.DEB.2.00.1207161228470.28834@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

Hi Paul,

On 07/16/2012 01:38 PM, Paul Walmsley wrote:
> Hi Jon,
>=20
> On Mon, 16 Jul 2012, Jon Hunter wrote:
>=20
>> Yes I see that makes sense. However, patch #7 has already changed th=
e
>> mapping of the flags. I had intended that patch #7 and #8 would be
>> applied together. However, I could see that patch #7 can be taken ju=
st
>> to eliminate using the SW_SLEEP state. So basically, what I am sayin=
g is
>> does patch #7 have any value without #8?
>=20
> Certainly not as much value as it had before.  But my understanding, =
which=20
> is possibly incorrect, matches what you wrote in patch #7's descripti=
on:
>=20
> "For OMAP4 devices, SW_SLEEP is equivalent to HW_AUTO and NO_SLEEP is=
=20
> equivalent to SW_WKUP. The only difference between HW_AUTO and SW_SLE=
EP=20
> for OMAP4 devices is that the PRM_IRQSTATUS_MPU.TRANSITION_ST interru=
pt=20
> status is set in case of SW_SLEEP transition, and not set in case of=20
> HW_AUTO transition."
>=20
> We don't use that PRM_IRQSTATUS_MPU.TRANSITION_ST interrupt bit.  So =
if=20
> SW_SLEEP and HW_AUTO really have identical meanings otherwise, then I=
=20
> suppose we might as well use the one that does what we need with no=20
> extraneous side-effects?  My recollection from a conversation with Be=
no=EEt=20
> a few months ago was that this was his view as well.
>=20
>> That's fine with me. We can always workaround such issues by adding =
flags.
>>
>> I can give this a try this week and let you know how it goes.
>=20
> Okay, great.  No rush on my account.

I have been testing your patch [1] on OMAP3 and found that the EMU
clock domain was not being disabled for two reasons.=20

1. When HWMOD attempts to disable the clock domain for OMAP2/3 devices=20
   we simply return without doing anything. Not sure if it is safe to=20
   remove this but I can do some more testing on OMAP2/3.=20

commit a0307bd539ecef976793679a1c4ff0d47b22c4bd
Author: Jon Hunter <jon-hunter@ti.com>
Date:   Mon Jul 30 18:04:06 2012 -0500

    ARM: OMAP2/3: Allow HWMOD to disable clock domains
   =20
    Currently when HWMOD attempts to disable a clock domain on OMAP2/3 =
devices we
    will return from the function clkdm_hwmod_disable() without actuall=
y disabling
    the clock domain. Per the comment this is deliberate because initia=
lly HWMOD
    OMAP2/3 devices did not support clock domains. However, clock domai=
ns are now
    supported by HWMOD for these devices and so allow HWMOD to disable =
the clock
    domains.
   =20
    XXX - Tested on OMAP3430 beagle board, but needs more testing on OM=
AP2/3

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/cl=
ockdomain.c
index 011186f..8f7a941 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -1075,10 +1075,6 @@ int clkdm_hwmod_enable(struct clockdomain *clkdm=
, struct omap_hwmod *oh)
  */
 int clkdm_hwmod_disable(struct clockdomain *clkdm, struct omap_hwmod *=
oh)
 {
-       /* The clkdm attribute does not exist yet prior OMAP4 */
-       if (cpu_is_omap24xx() || cpu_is_omap34xx())
-               return 0;
-
        /*
         * XXX Rewrite this code to maintain a list of enabled
         * downstream hwmods for debugging purposes?


2. I need to make the following changes to your patch. The change to
   omap2_clkdm_clk_disable() was needed to get the EMU to turn off.
   At the same time I thought we should make the same change to
   omap2_clkdm_clk_enable().

diff --git a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c b/arch/arm/mach=
-omap2/clockdomain2xxx_3xxx.c
index 09385a9..c94b2fb 100644
--- a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
@@ -223,7 +223,8 @@ static int omap2_clkdm_clk_enable(struct clockdomai=
n *clkdm)
                _enable_hwsup(clkdm);
        } else {
                if (clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)
-                       omap2_clkdm_wakeup(clkdm);
+                       (cpu_is_omap24xx()) ? omap2_clkdm_wakeup(clkdm)=
 :
+                               omap3_clkdm_wakeup(clkdm);
        }
=20
        return 0;
@@ -257,7 +258,8 @@ static int omap2_clkdm_clk_disable(struct clockdoma=
in *clkdm)
                _enable_hwsup(clkdm);
        } else {
                if (clkdm->flags & CLKDM_CAN_FORCE_SLEEP)
-                       omap2_clkdm_sleep(clkdm);
+                       (cpu_is_omap24xx()) ? omap2_clkdm_sleep(clkdm) =
:
+                               omap3_clkdm_sleep(clkdm);
        }


I need to do more testing but wanted to give you this feedback and
get your comments.

Cheers
Jon

[1] http://marc.info/?l=3Dlinux-arm-kernel&m=3D134212814812557&w=3D2
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
