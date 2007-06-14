From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH 6 / 12] Mach omap2 updation for 3430
Date: Thu, 14 Jun 2007 16:03:01 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47011E659F@dlee13.ent.ti.com>
References: <20070614114651.GF28804@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070614114651.GF28804@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

>> +#ifdef CONFIG_ARCH_OMAP24XX
>> +		if (cpu_is_omap24xx()) {
>> +			bank->base_reg =3D IO_ADDRESS(OMAP24XX_IC_BASE);
>> +		}
>> +#endif
>> +#ifdef CONFIG_ARCH_OMAP34XX
>> +		if (cpu_is_omap34xx()) {
>> +			bank->base_reg =3D IO_ADDRESS(OMAP34XX_IC_BASE);
>> +		}
>> +#endif
>>  		omap_irq_bank_init_one(bank);
>>
>>  		nr_irqs +=3D bank->nr_irqs;
>>
>
>You should be able to leave out the ifdefs above, if one of the omaps
>is disabled, then it will get optimized out as it will be if (0) {}.

In few more places I found this kind of issue. I think this kind of =
common definition issues will be more in future.

>This is assuming the _IC_BASE defines are visible to both, of course.

Basically we have omap24xx.h and omap34xx.h for OMAP2/3 specific =
definitions. Now for the above illustrated approach we should have two =
different definitions, where to define such Macros?=20

Note: We will not include omap24xx.h for 34xx compilation (vice versa).

Option 1: Having such Macros with same name in both 24xx and 34xx .h =
files

In omap24xx.h:
#define OMAP_IC_BASE	<OMAP2 IC BASE VALUE>

In omap34xx.h
#define OMAP_IC_BASE	< OMAP3 IC BASE VALUE >

Option 2: Having a separate header file for such macros.

omap_common.h
#define OMAP24XX_IC_BASE	< OMAP2 IC BASE VALUE >
#define OMAP34XX_IC_BASE	< OMAP3 IC BASE VALUE >

This common header file can be included in both 24xx and 34xx board =
files

Option 3: Define both macros in 24xx and 34xx header files (Crap).

In omap24xx.h:
#define OMAP24XX_IC_BASE	< OMAP2 IC BASE VALUE >
#define OMAP34XX_IC_BASE	< OMAP3 IC BASE VALUE >#define OMAP_IC_BASE

In omap34xx.h
#define OMAP24XX_IC_BASE	< OMAP2 IC BASE VALUE >
#define OMAP34XX_IC_BASE	< OMAP3 IC BASE VALUE >#define OMAP_IC_BASE


Kindly let me know your views on the same.

Regards,
Khasim
