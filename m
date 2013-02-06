From: Ruslan Bilovol <ruslan.bilovol@ti.com>
Subject: Re: [PATCH v2 1/2] ARM: OMAP2+: SoC name and revision unification
Date: Thu, 7 Feb 2013 00:12:46 +0200
Message-ID: <CAB=otbRp_DFCdUv0+GN5MYWaKPVRvgeBj1Q1-zXCf=2ThfNLFw@mail.gmail.com>
References: <1360177196-18196-1-git-send-email-ruslan.bilovol@ti.com>
 <1360177196-18196-2-git-send-email-ruslan.bilovol@ti.com>
 <20130206191923.GE25185@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130206191923.GE25185@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 6, 2013 at 9:19 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
> * Ruslan Bilovol <ruslan.bilovol@ti.com> [130206 11:03]:
>> This is a long story where for each new generation of
>> OMAP we used different approaches for creating
>> strings for SoCs names and revisions that this patch
>> fixes. It makes future exporting of this information
>> to SoC infrastructure easier.
>>
>> Signed-off-by: Ruslan Bilovol <ruslan.bilovol@ti.com>
>> ---
>>  arch/arm/mach-omap2/id.c |   89 ++++++++++++++++++++++++++--------------------
>>  1 file changed, 51 insertions(+), 38 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
>> index 8a68f1e..b16a432 100644
>> --- a/arch/arm/mach-omap2/id.c
>> +++ b/arch/arm/mach-omap2/id.c
>> @@ -31,8 +31,11 @@
>>  #define OMAP4_SILICON_TYPE_STANDARD          0x01
>>  #define OMAP4_SILICON_TYPE_PERFORMANCE               0x02
>>
>> +#define OMAP_SOC_MAX_NAME_LENGTH             16
>> +
>>  static unsigned int omap_revision;
>> -static const char *cpu_rev;
>> +static char soc_name[OMAP_SOC_MAX_NAME_LENGTH];
>> +static char soc_rev[OMAP_SOC_MAX_NAME_LENGTH];
>>  u32 omap_features;
>>
>>  unsigned int omap_rev(void)
>
> Sorry I was not clear earlier with what I meant, but if
> you remove static const char *cpu_rev here and use
> soc_name and soc_rev here..
>
>> @@ -181,8 +187,7 @@ void __init omap2xxx_check_revision(void)
>>
>>  static void __init omap3_cpuinfo(void)
>>  {
>> -     const char *cpu_name;
>> -
>> +     const char *omap3_soc_name;
>>       /*
>>        * OMAP3430 and OMAP3530 are assumed to be same.
>>        *
>
> ..then no need to replace cpu_name with omap3_soc_name here?
>
>> @@ -191,28 +196,30 @@ static void __init omap3_cpuinfo(void)
>>        * and CPU class bits.
>>        */
>>       if (cpu_is_omap3630()) {
>> -             cpu_name = "OMAP3630";
>> +             omap3_soc_name = "OMAP3630";
>>       } else if (soc_is_am35xx()) {
>> -             cpu_name = (omap3_has_sgx()) ? "AM3517" : "AM3505";
>> +             omap3_soc_name = (omap3_has_sgx()) ? "AM3517" : "AM3505";
>>       } else if (cpu_is_ti816x()) {
>> -             cpu_name = "TI816X";
>> +             omap3_soc_name = "TI816X";
>>       } else if (soc_is_am335x()) {
>> -             cpu_name =  "AM335X";
>> +             omap3_soc_name =  "AM335X";
> ...
>
> Or here?
>
>>  void __init omap3xxx_check_revision(void)
>>  {
>> +     const char *omap3_soc_rev;
>>       u32 cpuid, idcode;
>>       u16 hawkeye;
>>       u8 rev;
>
> Then here if you just make it a local cpu_rev..
>
>> @@ -303,7 +311,7 @@ void __init omap3xxx_check_revision(void)
>>       cpuid = read_cpuid(CPUID_ID);
>>       if ((((cpuid >> 4) & 0xfff) == 0xc08) && ((cpuid & 0xf) == 0x0)) {
>>               omap_revision = OMAP3430_REV_ES1_0;
>> -             cpu_rev = "1.0";
>> +             omap3_soc_rev = "ES1.0";
>>               return;
>>       }
>>
>> @@ -324,26 +332,26 @@ void __init omap3xxx_check_revision(void)
>>               case 0: /* Take care of early samples */
>>               case 1:
>>                       omap_revision = OMAP3430_REV_ES2_0;
>> -                     cpu_rev = "2.0";
>> +                     omap3_soc_rev = "ES2.0";
>>                       break;
>>               case 2:
>>                       omap_revision = OMAP3430_REV_ES2_1;
>> -                     cpu_rev = "2.1";
>> +                     omap3_soc_rev = "ES2.1";
>>                       break;
>>               case 3:
>>                       omap_revision = OMAP3430_REV_ES3_0;
>> -                     cpu_rev = "3.0";
>> +                     omap3_soc_rev = "ES3.0";
>>                       break;
>>               case 4:
>>                       omap_revision = OMAP3430_REV_ES3_1;
>> -                     cpu_rev = "3.1";
>> +                     omap3_soc_rev = "ES3.1";
>>                       break;
>
> ..no need to replace cpu_rev with omap3_soc_rev all over the
> place?

Okay, I understood what do you mean here. Will fix it in next patchset..

>
> Regards,
>
> Tony
