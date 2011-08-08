From: "Koyamangalath, Abhilash" <abhilash.kv@ti.com>
Subject: RE: [PATCH 2/2] omap_twl: Prevent SR to enable for am3517/am3505
	devices
Date: Mon, 8 Aug 2011 18:18:40 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870370A4D96E@dbde02.ent.ti.com>
References: <1312473569-1212-1-git-send-email-abhilash.kv@ti.com>,
	<87hb5w3kq0.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87hb5w3kq0.fsf@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Cousson,
	Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Kevin Hilman wrote:
>Abhilash K V <abhilash.kv@ti.com> writes:
> 
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> >
> > In case of AM3517 & AM3505, Smart Reflex is not applicable so
> > we must not enable it. So add check for am3517/05 cpu revision
> > in omap3_twl_init() and return -ENODEV if true, else continue.
> >
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Signed-off-by: Abhilash K V <abhilash.kv@ti.com>
> > ---
> >  arch/arm/mach-omap2/omap_twl.c |    8 ++++++++
> >  1 files changed, 8 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/omap_twl.c
> b/arch/arm/mach-omap2/omap_twl.c
> > index 07d6140..92fadcb 100644
> > --- a/arch/arm/mach-omap2/omap_twl.c
> > +++ b/arch/arm/mach-omap2/omap_twl.c
> > @@ -269,6 +269,14 @@ int __init omap3_twl_init(void)
> >        if (!cpu_is_omap34xx())
> >                return -ENODEV;
> > 
> > +     /*
> > +      * In case of AM3517/AM3505 we should not be going down
> > +      * further, since SR is not applicable there.
> > +      */
> > +     if (cpu_is_omap3505() || cpu_is_omap3517()) {
> > +             return -ENODEV;
> > +     }
> > +
> 
> Rather than using cpu_is_*, you should add a new "feature" flag for
> SmartReflex.  We already have this for things like SGX, IVA, NEON, etc.
> See <plat/feature.h>
I did not find a feature.h; did you mean OMAP3_CHECK_FEATURE macro which is used by
omap3_check_features(), which gleans for presence of L2CACHE, IVA, SGX, NEON, ISP features
from the Control Device Status Register (0x4800 244C) ?
There is no such bit-field to indicate the presence of smart-reflex feature in this register.
AFAIK, there is no such global register as well which could indicate this.

- Abhilash

> Kevin
> 
> 
> >        if (cpu_is_omap3630()) {
> >                omap3_mpu_volt_info.vp_vddmin =
> OMAP3630_VP1_VLIMITTO_VDDMIN;
> >                omap3_mpu_volt_info.vp_vddmax =
> OMAP3630_VP1_VLIMITTO_VDDMAX; 
> 
> 
