From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/8] mfd: twl-core: Rename TWL4030_CORE Kconfig option to
 TWL_CORE
Date: Tue, 5 Apr 2016 13:21:18 +0300
Message-ID: <5703919E.3020707@ti.com>
References: <1459279341-17389-1-git-send-email-contact@paulk.fr>
 <1459279341-17389-3-git-send-email-contact@paulk.fr>
 <56FBF1FD.8090903@ti.com> <1459627935.12073.35.camel@paulk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459627935.12073.35.camel-W9ppeneeCTY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 04/02/2016 11:12 PM, Paul Kocialkowski wrote:
> Le mercredi 30 mars 2016 =C3=A0 18:34 +0300, Grygorii Strashko a =C3=A9=
crit :
>> On 03/29/2016 10:22 PM, Paul Kocialkowski wrote:
>>>
>>> Since the twl-core mfd driver is not limited to twl4030 support, bu=
t also
>>> supports other chips of the TWL family, it makes sense to rename it=
s
>>> matching
>>> Kconfig opton to a non-model-specific name.
>>
>> Personally I don't see too much reason for this, but it's up to main=
tainers to
>> decide.
>=20
> I'm a strong advocate of consistency in naming and using twl4030 pref=
ixes for
> drivers that are common to more twl chips looks very inconsistent to =
me.
> Besides, some common twl drivers are already using the twl prefix, so=
 this can
> also be seen as harmonisation.

Yah. May be.

But I see the problem with your series - small amount of functional cha=
nges
is hidden in the fog of huge amount of renaming/beautification ;)

But, again, this is my personal opinion - final decision is up to maint=
ainers

+ cc: Lee Jones

>=20
>> Regarding this patch - pls, do not mix Kconfig and code changes.
>=20
> Do you mean that for code changes that are directly affected by Kconf=
ig changes
> (e.g. #ifdef CONFIG_)? Is the policy that "each commit must produce a=
 working
> result" or is it okay to break drivers in between commits of the same=
 series?

I mean this:
  */
-#define TWL4030_CORE_NR_IRQS	8
+#define TWL_CORE_NR_IRQS	8
 #define TWL4030_PWR_NR_IRQS	8
=20
 /* PIH register offsets */
@@ -693,7 +693,7 @@ int twl4030_init_irq(struct device *dev, int irq_nu=
m)
 	 * the hwirqs numbers are defined contiguously from 1 to 15.
 	 * Create only one domain for both.
 	 */
-	nr_irqs =3D TWL4030_PWR_NR_IRQS + TWL4030_CORE_NR_IRQS;
+	nr_irqs =3D TWL4030_PWR_NR_IRQS + TWL_CORE_NR_IRQS;
=20
 	irq_base =3D irq_alloc_descs(-1, 0, nr_irqs, 0);
 	if (IS_ERR_VALUE(irq_base)) {
@@ -704,7 +704,7 @@ int twl4030_init_irq(struct device *dev, int irq_nu=
m)
 	irq_domain_add_legacy(node, nr_irqs, irq_base, 0,
 			      &irq_domain_simple_ops, NULL);
=20
-	irq_end =3D irq_base + TWL4030_CORE_NR_IRQS;
+	irq_end =3D irq_base + TWL_CORE_NR_IRQS;

>=20
>> And it will be good to have cover letter.
>=20
> Noted, I'll come up with something for v2.
>=20
>>> Signed-off-by: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
>>> ---
>>>    arch/arm/mach-omap2/Kconfig     | 2 +-
>>>    arch/arm/mach-omap2/Makefile    | 2 +-
>>>    arch/arm/mach-omap2/pm.h        | 2 +-
>>>    arch/arm/plat-omap/Kconfig      | 2 +-

[..]


--=20
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
