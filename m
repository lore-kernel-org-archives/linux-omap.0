From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC] add BUG_ON_MAPPABLE_NULL macro
Date: Fri, 10 Dec 2010 18:26:36 +0200
Message-ID: <AANLkTi=zhjT1fw5_8hWufDDM4QkOcb=kBhhyiZ1PcDMo@mail.gmail.com>
References: <1291543563-5655-1-git-send-email-ohad@wizery.com> <20101207161054.d502fae8.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101207161054.d502fae8.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Greg KH <greg@kroah.com>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 8, 2010 at 2:10 AM, Andrew Morton <akpm@linux-foundation.or=
g> wrote:
> Every time someone sends me a patch with text after the "---", I deci=
de
> it was good changelog material and I promote it to above the "---".
> How's about you save us the effort :)

sure :)

>> +/**
>> + * BUG_ON_MAPPABLE_NULL() - BUG_ON(condition) only if address 0 is =
mappable
>> + * @condition: =A0 =A0 =A0 condition to check, should contain a NUL=
L check
>> + *
>> + * In general, NULL dereference Oopses are not desirable, since the=
y take down
>> + * the system with them and make the user extremely unhappy. So as =
a general
>> + * rule drivers should avoid dereferencing NULL pointers by doing a=
 simple
>
> s/drivers/code/

definitely.

>> + * check (when appropriate), and just return an error rather than c=
rash.
>> + * This way the system, despite having reduced functionality, will =
just keep
>> + * running rather than immediately reboot.
>> + *
>> + * _Critical_ kernel code, OTOH, that should not (/cannot) keep run=
ning when
>> + * given an unexpected NULL pointer, should just crash. On some arc=
hitectures,
>> + * a NULL dereference will always reliably produce an Oops. On othe=
rs, where
>> + * the zero address can be mmapped, an Oops is not guaranteed. Rely=
ing on
>> + * NULL dereference Oopses to happen on these architectures might l=
ead to
>> + * data corruptions (system will keep running despite a critical bu=
g and
>> + * the results will be horribly undefined). In addition, these situ=
ations
>> + * can also have security implications - we have seen several privi=
lege
>> + * escalation exploits with which an attacker gained full control o=
ver the
>> + * system due to NULL dereference bugs.
>
> yup.
>
>> + * This macro will BUG_ON if @condition is true on architectures wh=
ere the zero
>> + * address can be mapped. On other architectures, where the zero ad=
dress
>> + * can never be mapped, this macro is compiled out. It only makes s=
ense to
>> + * use this macro if @condition contains a NULL check, in order to =
optimize that
>> + * check out on architectures where the zero address can never be m=
apped.
>> + * On such architectures, those checks are not necessary, since the=
 code
>> + * itself will reliably reproduce an Oops as soon as the NULL addre=
ss will
>> + * be dereferenced.
>> + *
>> + * As with BUG_ON, use this macro only if @condition cannot be tole=
rated.
>> + * If proceeding with degraded functionality is an option, it's muc=
h
>> + * better to just simply check for @condition and return some error=
 code rather
>> + * than crash the system.
>> + */
>> +#define BUG_ON_MAPPABLE_NULL(cond) do { \
>> + =A0 =A0 if (arch_mmap_check(0, 1, MAP_FIXED) =3D=3D 0) \
>> + =A0 =A0 =A0 =A0 =A0 =A0 BUG_ON(cond); \
>> +} while (0)
>
> - arch_mmap_check() didn't have any documentation. =A0Please fix?

Sure.

>
> - arch_mmap_check() is a pretty poor identifier (identifiers which
> =A0include the word "check" are usually poor ones). =A0Maybe
> =A0arch_address_accessible()?

Maybe arch_address_mappable() might be more accurate (an address might
be accessible but not mappable due to some other arch-specific usage)
?

But, do you think it makes sense to rename arch_mmap_check() without
adding any functional benefit to it ?

arch_mmap_check is already defined today for ARM, IA64, MN10300, S390
and SPARC, and used by get_unmapped_area() [mmap.c], and this patch
adds a second usage of it.

To rename it, the patch will have to touch all of those architectures,
and usually, patches that carry stylistic changes in areas which they
don't add any functional benefit to, are considered pretty annoying...

> - I worry about arch_mmap_check(). =A0Is it expected that it will
> =A0perform a runtime check, like probe_kernel_address()? =A0Spell out=
 the
> =A0expectations, please.

Yes, arch_mmap_check does perform a runtime check: get_unmapped_area()
calls it with its addr, len and flags parameters.

But, since BUG_ON_MAPPABLE_NULL() calls it with constant values, I
expect arch_mmap_check() to be compiled out (tested on ARM and
X86_64).

> - BUG_ON_MAPPABLE_NULL() will evaluate arch_mmap_check() even if
> =A0CONFIG_BUG=3Dn. =A0Seems bad, depending on what those unspelled-ou=
t
> =A0expectations are!

Definitely. I'll add:

#define BUG_ON_MAPPABLE_NULL(condition)  do { if (condition) ; } while(=
0)

in case CONFIG_BUG=3Dn.

>
> - BUG_ON_MAPPABLE_NULL() is a mouthful. =A0I can't immedaitely think =
of
> =A0anythinjg nicer :(

Heartily agree...

> - Is BUG_ON_MAPPABLE_NULL() really the interface you want? =A0Or do w=
e
> =A0just want an interface which checks a pointer for nearly-nullness?

I guess we can start with BUG_ON_MAPPABLE_NULL(), since this is what
people commonly check today, and we will now be able to optimize those
checks out when they are unnecessary.

Thanks a lot,
Ohad.

>
>
>
