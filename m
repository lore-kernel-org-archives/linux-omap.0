From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
Date: Tue, 1 Sep 2015 15:35:38 +0300
Message-ID: <55E59B9A.1010007@ti.com>
References: <1432156863-19695-1-git-send-email-tony@atomide.com>
 <1432156863-19695-3-git-send-email-tony@atomide.com>
 <OFCA2F1DCE.C787A961-ONC1257EAE.001D79BC-C1257EAE.00203AFF@br-automation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <OFCA2F1DCE.C787A961-ONC1257EAE.001D79BC-C1257EAE.00203AFF@br-automation.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hannes Schmelzer <Hannes.Schmelzer@br-automation.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap-owner@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Hannes,

On 27/08/15 08:52, Hannes Schmelzer wrote:
> Hi Tony,
> =

> Did anyone test this changeset on some AM335x board?
> =

> Today I ran into trouble with that because:
> =

> The GPMC controller gets reseted on kernel boot due to the missing/remove=
d HWMOD_INIT_NO_RESET flag.
> =

> Primary this should not be a big problem, but on my board (maybe on all A=
M335x) the GPMC doesn't behave as described in TRM.
> Especially the GPMC_CONFIG register is not reset to 0h after reset, inste=
ad it holds the value 0xa00 which is very strange because bit 10-31 are res=
erved.
> =

> Further this 0xa00 means that Bit9 (WAIT1PINPOLARITY) is set, exactly thi=
s causes my system to stall on first access the connected NAND flash becaus=
e it never becomes ready due to the wrong wait pin polarity. Maybe others d=
ont't run into trouble because they may use WAIT0PIN, which one has it's ol=
d polarity.

So nand ready/busy pin is connected to waitpin1 through an inverter on your=
 board?

On am335x-evm we use waitpin0. Nand ready/busy is directly connected to wai=
tpin0.

For NAND operation read/write wait monitoring must be disabled.
The nand driver uses the WAIT pin purely for Read/Busy signalling.
Unfortunately the existing driver cannot handle anything other than waitpin=
 0 for nand for DT boot.

I've tried to address this issue here
http://thread.gmane.org/gmane.linux.drivers.devicetree/131076

cheers,
-roger

> =

> First approach was simply to write 0x0 to the GPMC_CONFIG register during=
 gpmc_probe function.
> It solves the problem.
> =

> I also tried to issue some SYSRESET through GPMC registers without succes=
s, same strange behavior.
> =

> What=92s your thinking around that?
> =

> Best regards,
> Hannes
> =

> =

> linux-omap-owner@vger.kernel.org schrieb am 20.05.2015 23:21:03:
> =

>> Von: Tony Lindgren <tony@atomide.com>
>> An: linux-omap@vger.kernel.org
>> Kopie: linux-arm-kernel@lists.infradead.org, Brian Hutchinson
>> <b.hutchman@gmail.com>, Paul Walmsley <paul@pwsan.com>, Roger Quadros <r=
ogerq@ti.com>
>> Datum: 20.05.2015 23:37
>> Betreff: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
>> Gesendet von: linux-omap-owner@vger.kernel.org
>>
>> We support decoding the bootloader values if DEBUG is defined.
>> But we also need to change the struct omap_hwmod flags to have
>> HWMOD_INIT_NO_RESET to avoid the GPMC being reset during the
>> boot. Otherwise just the default timings will be displayed
>> instead of the bootloader configured timings.
>>
>> This also allows us to clean up the various GPMC related
>> hwmod flags. For debugging, we only need HWMOD_INIT_NO_RESET,
>> and HWMOD_INIT_NO_IDLE is not needed.
>>
>> Cc: Brian Hutchinson <b.hutchman@gmail.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Cc: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>> ---
>>  arch/arm/mach-omap2/omap_hwmod.h                        |  6 ++++++
>>  arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c      | 12 ++--------=
--
>>  arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |  3 ++-
>>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c              | 12 ++--------=
--
>>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c              | 11 ++---------
>>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c               |  4 ++--
>>  arch/arm/mach-omap2/omap_hwmod_81xx_data.c              |  2 ++
>>  drivers/memory/Kconfig                                  |  8 ++++++++
>>  drivers/memory/omap-gpmc.c                              |  6 +++---
>>  9 files changed, 29 insertions(+), 35 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap=
_hwmod.h
>> index 9611c91..b5d27ec 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod.h
>> +++ b/arch/arm/mach-omap2/omap_hwmod.h
>> @@ -109,6 +109,12 @@ extern struct omap_hwmod_sysc_fields omap_hwmod_sys=
c_type3;
>>  =

>>  #define DEBUG_OMAPUART_FLAGS   (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESE=
T)
>>  =

>> +#ifdef CONFIG_OMAP_GPMC_DEBUG
>> +#define DEBUG_OMAP_GPMC_HWMOD_FLAGS   HWMOD_INIT_NO_RESET
>> +#else
>> +#define DEBUG_OMAP_GPMC_HWMOD_FLAGS   0
>> +#endif
>> +
>>  #if defined(CONFIG_DEBUG_OMAP2UART1)
>>  #undef DEBUG_OMAP2UART1_FLAGS
>>  #define DEBUG_OMAP2UART1_FLAGS DEBUG_OMAPUART_FLAGS
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/a=
rm/
>> mach-omap2/omap_hwmod_2xxx_ipblock_data.c
>> index 8821b9d..6dcfd03 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
>> @@ -762,16 +762,8 @@ struct omap_hwmod omap2xxx_gpmc_hwmod =3D {
>>     .name      =3D "gpmc",
>>     .class      =3D &omap2xxx_gpmc_hwmod_class,
>>     .main_clk   =3D "gpmc_fck",
>> -   /*
>> -    * XXX HWMOD_INIT_NO_RESET should not be needed for this IP
>> -    * block.  It is not being added due to any known bugs with
>> -    * resetting the GPMC IP block, but rather because any timings
>> -    * set by the bootloader are not being correctly programmed by
>> -    * the kernel from the board file or DT data.
>> -    * HWMOD_INIT_NO_RESET should be removed ASAP.
>> -    */
>> -   .flags      =3D (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET |
>> -            HWMOD_NO_IDLEST),
>> +   /* Skip reset for CONFIG_OMAP_GPMC_DEBUG for bootloader timings */
>> +   .flags      =3D HWMOD_NO_IDLEST | DEBUG_OMAP_GPMC_HWMOD_FLAGS,
>>     .prcm      =3D {
>>        .omap2   =3D {
>>           .prcm_reg_id =3D 3,
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/a=
rch/
>> arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
>> index cabc569..ae0cb67 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
>> @@ -668,7 +668,8 @@ struct omap_hwmod am33xx_gpmc_hwmod =3D {
>>     .name      =3D "gpmc",
>>     .class      =3D &am33xx_gpmc_hwmod_class,
>>     .clkdm_name   =3D "l3s_clkdm",
>> -   .flags      =3D (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
>> +   /* Skip reset for CONFIG_OMAP_GPMC_DEBUG for bootloader timings */
>> +   .flags      =3D DEBUG_OMAP_GPMC_HWMOD_FLAGS,
>>     .main_clk   =3D "l3s_gclk",
>>     .prcm      =3D {
>>        .omap4   =3D {
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-=
omap2/
>> omap_hwmod_3xxx_data.c
>> index 4e8e93c..0ca4d3f 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> @@ -2169,16 +2169,8 @@ static struct omap_hwmod omap3xxx_gpmc_hwmod =3D {
>>     .clkdm_name   =3D "core_l3_clkdm",
>>     .mpu_irqs   =3D omap3xxx_gpmc_irqs,
>>     .main_clk   =3D "gpmc_fck",
>> -   /*
>> -    * XXX HWMOD_INIT_NO_RESET should not be needed for this IP
>> -    * block.  It is not being added due to any known bugs with
>> -    * resetting the GPMC IP block, but rather because any timings
>> -    * set by the bootloader are not being correctly programmed by
>> -    * the kernel from the board file or DT data.
>> -    * HWMOD_INIT_NO_RESET should be removed ASAP.
>> -    */
>> -   .flags      =3D (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET |
>> -            HWMOD_NO_IDLEST),
>> +   /* Skip reset for CONFIG_OMAP_GPMC_DEBUG for bootloader timings */
>> +   .flags      =3D HWMOD_NO_IDLEST | DEBUG_OMAP_GPMC_HWMOD_FLAGS,
>>  };
>>  =

>>  /*
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-=
omap2/
>> omap_hwmod_44xx_data.c
>> index f5e68a7..43eebf2 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> @@ -1188,15 +1188,8 @@ static struct omap_hwmod omap44xx_gpmc_hwmod =3D {
>>     .name      =3D "gpmc",
>>     .class      =3D &omap44xx_gpmc_hwmod_class,
>>     .clkdm_name   =3D "l3_2_clkdm",
>> -   /*
>> -    * XXX HWMOD_INIT_NO_RESET should not be needed for this IP
>> -    * block.  It is not being added due to any known bugs with
>> -    * resetting the GPMC IP block, but rather because any timings
>> -    * set by the bootloader are not being correctly programmed by
>> -    * the kernel from the board file or DT data.
>> -    * HWMOD_INIT_NO_RESET should be removed ASAP.
>> -    */
>> -   .flags      =3D HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
>> +   /* Skip reset for CONFIG_OMAP_GPMC_DEBUG for bootloader timings */
>> +   .flags      =3D DEBUG_OMAP_GPMC_HWMOD_FLAGS,
>>     .prcm =3D {
>>        .omap4 =3D {
>>           .clkctrl_offs =3D OMAP4_CM_L3_2_GPMC_CLKCTRL_OFFSET,
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-o=
map2/
>> omap_hwmod_7xx_data.c
>> index 0e64c2f..a0411f3 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>> @@ -819,8 +819,8 @@ static struct omap_hwmod dra7xx_gpmc_hwmod =3D {
>>     .name      =3D "gpmc",
>>     .class      =3D &dra7xx_gpmc_hwmod_class,
>>     .clkdm_name   =3D "l3main1_clkdm",
>> -   .flags      =3D (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET |
>> -            HWMOD_SWSUP_SIDLE),
>> +   /* Skip reset for CONFIG_OMAP_GPMC_DEBUG for bootloader timings */
>> +   .flags      =3D HWMOD_SWSUP_SIDLE | DEBUG_OMAP_GPMC_HWMOD_FLAGS,
>>     .main_clk   =3D "l3_iclk_div",
>>     .prcm =3D {
>>        .omap4 =3D {
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-=
omap2/
>> omap_hwmod_81xx_data.c
>> index cab1eb6..c924137 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
>> @@ -478,6 +478,8 @@ static struct omap_hwmod dm81xx_gpmc_hwmod =3D {
>>     .clkdm_name   =3D "alwon_l3s_clkdm",
>>     .class      =3D &dm81xx_gpmc_hwmod_class,
>>     .main_clk   =3D "sysclk6_ck",
>> +   /* Skip reset for CONFIG_OMAP_GPMC_DEBUG for bootloader timings */
>> +   .flags      =3D DEBUG_OMAP_GPMC_HWMOD_FLAGS,
>>     .prcm =3D {
>>        .omap4 =3D {
>>           .clkctrl_offs =3D DM816X_CM_ALWON_GPMC_CLKCTRL,
>> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
>> index 868036f..8406c668 100644
>> --- a/drivers/memory/Kconfig
>> +++ b/drivers/memory/Kconfig
>> @@ -49,6 +49,14 @@ config OMAP_GPMC
>>       interfacing to a variety of asynchronous as well as synchronous
>>       memory drives like NOR, NAND, OneNAND, SRAM.
>>  =

>> +config OMAP_GPMC_DEBUG
>> +   bool
>> +   depends on OMAP_GPMC
>> +   help
>> +     Enables verbose debugging mostly to decode the bootloader provided
>> +     timings. Enable this during development to configure devices
>> +     connected to the GPMC bus.
>> +
>>  config MVEBU_DEVBUS
>>     bool "Marvell EBU Device Bus Controller"
>>     default y
>> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
>> index 0e524a1..3a27a84 100644
>> --- a/drivers/memory/omap-gpmc.c
>> +++ b/drivers/memory/omap-gpmc.c
>> @@ -403,7 +403,7 @@ static void gpmc_cs_bool_timings(int cs, const struct
>> gpmc_bool_timings *p)
>>              p->cycle2cyclediffcsen);
>>  }
>>  =

>> -#ifdef DEBUG
>> +#ifdef CONFIG_OMAP_GPMC_DEBUG
>>  /**
>>   * get_gpmc_timing_reg - read a timing parameter and print DTS settings=
 for it.
>>   * @cs:      Chip Select Region
>> @@ -612,7 +612,7 @@ static int set_gpmc_timing_reg(int cs, int reg, int
>> st_bit, int end_bit, int max
>>     }
>>  =

>>     l =3D gpmc_cs_read_reg(cs, reg);
>> -#ifdef DEBUG
>> +#ifdef CONFIG_OMAP_GPMC_DEBUG
>>     pr_info(
>>        "GPMC CS%d: %-17s: %3d ticks, %3lu ns (was %3i ticks) %3d ns\n",
>>            cs, name, ticks, gpmc_get_clk_period(cs, cd) * ticks / 1000,
>> @@ -767,7 +767,7 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_ti=
mings *t,
>>               GPMC_CONFIG1_CLKACTIVATIONTIME_MAX,
>>               clk_activation, GPMC_CD_FCLK);
>>  =

>> -#ifdef DEBUG
>> +#ifdef CONFIG_OMAP_GPMC_DEBUG
>>     pr_info("GPMC CS%d CLK period is %lu ns (div %d)\n",
>>           cs, (div * gpmc_get_fclk_period()) / 1000, div);
>>  #endif
>> --
>> 2.1.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> =
