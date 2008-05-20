From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 4/9] OMAP: Add new function to check wether there is irq pending
Date: Tue, 20 May 2008 09:27:34 +0300
Message-ID: <87od71qyll.fsf@trdhcp146196.ntc.nokia.com>
References: <878wyav7ti.fsf@trdhcp146196.ntc.nokia.com>
	<1210935435-27617-1-git-send-email-jouni.hogander@nokia.com>
	<20080516154425.GE23002@atomide.com>
	<87od724t47.fsf@trdhcp146196.ntc.nokia.com>
	<20080519185449.GL23002@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:44089 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754726AbYETG1p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 May 2008 02:27:45 -0400
In-Reply-To: <20080519185449.GL23002@atomide.com> (ext Tony Lindgren's message
	of "Mon, 19 May 2008 11:54:51 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

"ext Tony Lindgren" <tony@atomide.com> writes:

> * H=C3=B6gander Jouni <jouni.hogander@nokia.com> [080519 01:05]:
>> "ext Tony Lindgren" <tony@atomide.com> writes:
>>=20
>> > Hi,
>> >
>> > * Jouni Hogander <jouni.hogander@nokia.com> [080516 03:57]:
>> >> Add common omap2/3 function to check wether there is irq pending.
>> >> Switch to use it in omap2 pm code instead of its own.
>> >>=20
>> >> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
>> >> ---
>> >>  arch/arm/mach-omap2/irq.c        |   29 +++++++++++++++++++++++-=
-----
>> >>  arch/arm/mach-omap2/pm24xx.c     |   19 +++----------------
>> >>  include/asm-arm/arch-omap/irqs.h |    1 +
>> >>  3 files changed, 27 insertions(+), 22 deletions(-)
>> >>=20
>> >> diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.=
c
>> >> index ac062ee..f1e1e2e 100644
>> >> --- a/arch/arm/mach-omap2/irq.c
>> >> +++ b/arch/arm/mach-omap2/irq.c
>> >> @@ -20,12 +20,13 @@
>> >> =20
>> >>  /* selected INTC register offsets */
>> >> =20
>> >> -#define INTC_REVISION	0x0000
>> >> -#define INTC_SYSCONFIG	0x0010
>> >> -#define INTC_SYSSTATUS	0x0014
>> >> -#define INTC_CONTROL	0x0048
>> >> -#define INTC_MIR_CLEAR0	0x0088
>> >> -#define INTC_MIR_SET0	0x008c
>> >> +#define INTC_REVISION		0x0000
>> >> +#define INTC_SYSCONFIG		0x0010
>> >> +#define INTC_SYSSTATUS		0x0014
>> >> +#define INTC_CONTROL		0x0048
>> >> +#define INTC_MIR_CLEAR0		0x0088
>> >> +#define INTC_MIR_SET0		0x008c
>> >> +#define INTC_PENDING_IRQ0	0x0098
>> >> =20
>> >>  /*
>> >>   * OMAP2 has a number of different interrupt controllers, each i=
nterrupt
>> >> @@ -122,6 +123,22 @@ static void __init omap_irq_bank_init_one(st=
ruct omap_irq_bank *bank)
>> >>  	intc_bank_write_reg(1 << 0, bank, INTC_SYSCONFIG);
>> >>  }
>> >> =20
>> >> +int omap_irq_pending(void)
>> >> +{
>> >> +	int i;
>> >> +
>> >> +	for (i =3D 0; i < ARRAY_SIZE(irq_banks); i++) {
>> >> +		struct omap_irq_bank *bank =3D irq_banks + i;
>> >> +		int irq;
>> >> +
>> >> +		for (irq =3D 0; irq < bank->nr_irqs; irq +=3D 32)
>> >> +			if (intc_bank_read_reg(bank, INTC_PENDING_IRQ0 +
>> >> +					       ((irq >> 5) << 5)))
>> >> +				return 1;
>> >> +	}
>> >> +	return 0;
>> >> +}
>> >> +
>> >
>> > In this case it should be enough to know if anything is set in the
>> > bank registers, so you should be able to leave out the second for =
loop.
>> > At most you need to read only the four bank registers. No need to =
check
>> > for individual interrupts.
>>=20
>> Current code is presenting each interrupt controller as a bank. I
>> think in TRM they are talking about banks in each controller. So the=
re
>> is three banks in mpu intc 0..2. This is in arch/arm/mach-omap2/irq.=
c:
>>=20
>>  * OMAP2 has a number of different interrupt controllers, each inter=
rupt
>>  * controller is identified as its own "bank". Register definitions =
are
>>  * fairly consistent for each bank, but not all registers are implem=
ented
>>  * for each bank.. when in doubt, consult the TRM.
>>  */
>>=20
>> So the first loop is going through controllers which is only mpu
>> intc. Second loop is going through bank registers. I'm using irq onl=
y
>> for finding out right offset for bank register. This is another
>> implementation. Which does exactly same thing:
>>=20
>> int omap_irq_pending(void)
>> {
>> 	int i, j;
>>=20
>> 	for (i =3D 0; i < ARRAY_SIZE(irq_banks); i++) {
>> 		struct omap_irq_bank *bank =3D irq_banks + i;
>>=20
>> 		for (j =3D 0; j < 3; j++)
>> 			if (intc_bank_read_reg(bank, INTC_PENDING_IRQ0 +
>> 					       0x20 * j))
>> 				return 1;
>> 	}
>> 	return 0;
>> }
>>=20
>> If you think this is better I can change it. In first version I was
>> just trying to follow practices used in irq.c for finding out offset=
s.
>
> Hmm, AFAIK, something like below should be enough to see if any inter=
rupts
> are pending (patch untested). See also
> include/asm-arm/arch-omap/entry-macro.S> and what pm.c was doing.

No it doesn't work. It would work if irq_banks were presenting banks
instead of controllers. See my comments below.

>
> Regards,
>
> Tony
>
>
>
> diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> index ac062ee..aef28ab 100644
> --- a/arch/arm/mach-omap2/irq.c
> +++ b/arch/arm/mach-omap2/irq.c
> @@ -26,6 +26,7 @@
>  #define INTC_CONTROL	0x0048
>  #define INTC_MIR_CLEAR0	0x0088
>  #define INTC_MIR_SET0	0x008c
> +#define INTC_PENDING	0x0098
> =20
>  /*
>   * OMAP2 has a number of different interrupt controllers, each inter=
rupt
> @@ -122,6 +123,20 @@ static void __init omap_irq_bank_init_one(struct=
 omap_irq_bank *bank)
>  	intc_bank_write_reg(1 << 0, bank, INTC_SYSCONFIG);
>  }
> =20
> +int omap_irq_pending(void)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(irq_banks); i++) {

ARRAY_SIZE(irq_banks) =3D=3D 1, because there is only mpu intc in
irq_banks. irq_banks contains interrupt controllers, so we need to
loop through them and loop each pending (bank) register inside these
controllers.

> +		struct omap_irq_bank *bank =3D irq_banks + i;
> +
> +		if (intc_bank_read_reg(bank, INTC_PENDING))
> +			return 1;
> +	}
> +
> +	return 0;
> +}

Your function reads only first INTC_PENDING register. There are three
of them in mpu intc.

> +
>  void __init omap_init_irq(void)
>  {
>  	unsigned long nr_irqs =3D 0;
>

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
