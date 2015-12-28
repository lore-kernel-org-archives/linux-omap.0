From: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/5] arm: devtree: Set system_rev from DT "/revision"
Date: Mon, 28 Dec 2015 13:01:22 -0800
Message-ID: <5681A322.2090204@gmail.com>
References: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com> <1436214373-12969-2-git-send-email-pali.rohar@gmail.com> <20151224190237.GA17343@pali>
Reply-To: frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-spec-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151224190237.GA17343@pali>
Sender: devicetree-spec-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Laura Abbott <lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber-l3A5Bk7waGM@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Devicetree Spec List <devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Adding devicetree-spec, and commenting below.

On 12/24/2015 11:02 AM, Pali Roh=C3=A1r wrote:
> On Monday 06 July 2015 22:26:09 Pali Roh=C3=A1r wrote:
>> With this patch "/revision" DT entry is used to set global system_re=
v
>> variable. DT "/revision" is expected to be u32 numeric value.
>>
>> TODO: add documentation
>>
>> Signed-off-by: Pali Roh=C3=A1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  arch/arm/kernel/devtree.c |   12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
>> index 11c54de..7d82749 100644
>> --- a/arch/arm/kernel/devtree.c
>> +++ b/arch/arm/kernel/devtree.c
>> @@ -19,6 +19,7 @@
>>  #include <linux/of_irq.h>
>>  #include <linux/of_platform.h>
>>  #include <linux/smp.h>
>> +#include <linux/libfdt_env.h>
>> =20
>>  #include <asm/cputype.h>
>>  #include <asm/setup.h>
>> @@ -26,6 +27,7 @@
>>  #include <asm/smp_plat.h>
>>  #include <asm/mach/arch.h>
>>  #include <asm/mach-types.h>
>> +#include <asm/system_info.h>
>> =20
>> =20
>>  #ifdef CONFIG_SMP
>> @@ -204,6 +206,8 @@ static const void * __init arch_get_next_mach(co=
nst char *const **match)
>>  const struct machine_desc * __init setup_machine_fdt(unsigned int d=
t_phys)
>>  {
>>  	const struct machine_desc *mdesc, *mdesc_best =3D NULL;
>> +	unsigned long dt_root;
>> +	const u32 *rev;
>> =20
>>  #ifdef CONFIG_ARCH_MULTIPLATFORM
>>  	DT_MACHINE_START(GENERIC_DT, "Generic DT based system")
>> @@ -215,17 +219,16 @@ const struct machine_desc * __init setup_machi=
ne_fdt(unsigned int dt_phys)
>>  	if (!dt_phys || !early_init_dt_verify(phys_to_virt(dt_phys)))
>>  		return NULL;
>> =20
>> +	dt_root =3D of_get_flat_dt_root();
>>  	mdesc =3D of_flat_dt_match_machine(mdesc_best, arch_get_next_mach)=
;
>> =20
>>  	if (!mdesc) {
>>  		const char *prop;
>>  		int size;
>> -		unsigned long dt_root;
>> =20
>>  		early_print("\nError: unrecognized/unsupported "
>>  			    "device tree compatible list:\n[ ");
>> =20
>> -		dt_root =3D of_get_flat_dt_root();
>>  		prop =3D of_get_flat_dt_prop(dt_root, "compatible", &size);
>>  		while (size > 0) {
>>  			early_print("'%s' ", prop);
>> @@ -246,5 +249,10 @@ const struct machine_desc * __init setup_machin=
e_fdt(unsigned int dt_phys)
>>  	/* Change machine number to match the mdesc we're using */
>>  	__machine_arch_type =3D mdesc->nr;
>> =20
>> +	/* Set system revision from DT */
>> +	rev =3D of_get_flat_dt_prop(dt_root, "revision", NULL);
>> +	if (rev)
>> +		system_rev =3D fdt32_to_cpu(*rev);
>> +
>>  	return mdesc;
>>  }
>=20
> This patch and second one (with subject "[PATCH 2/5] arm: boot: conve=
rt
> ATAG_REVISION to DT "/revision" entry") are still needed.
>=20
> Are there any objections for them? If not, I will add missing DT
> documentation and will resend them.

Patch 2/5 copies the value from ATAG_REVISION into the fdt "/revision"
property.

If the use of /revision is limited to being a location to hold an ATAG
value to pass to the global variable system_rev, then it would make
sense to just copy directly from the ATAG value into system_rev in the
same board file where you are copying the ATAGs.

-Frank
