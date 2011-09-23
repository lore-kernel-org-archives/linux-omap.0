From: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/5 v11] arm: omap: usb: ehci and ohci hwmod structures
 for omap3
Date: Fri, 23 Sep 2011 15:34:30 +0530
Message-ID: <CAP05o4+Zc2z6sBOX_rQeoDQ9PneypcLRCyBbaaB2m+ZjeXZnaw@mail.gmail.com>
References: <1316691479-1849-1-git-send-email-keshava_mgowda@ti.com>
	<1316691479-1849-2-git-send-email-keshava_mgowda@ti.com>
	<1316691479-1849-3-git-send-email-keshava_mgowda@ti.com>
	<alpine.DEB.2.00.1109221115320.10719@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1109221115320.10719-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, vishwanath.bs-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 22, 2011 at 11:31 PM, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi
>
> a few comments
>
> On Thu, 22 Sep 2011, Keshava Munegowda wrote:
>
>> following 4 hwmod structures are added
>> 1. usb_host_hs hwmod of usbhs with uhh base address and functional c=
lock,
>> 2. usb_ehci_hs hwmod with irq and base address,
>> 3. usb_ohci_hs hwmod with irq and base address,
>> =A0 =A0 =A0 - the ehci and ohci hwmods does not require functional c=
lock
>> =A0 =A0 =A0 =A0 because usb_host_hs has functional clock which is su=
fficient
>> =A0 =A0 =A0 =A0 =A0 to access ehci and ohci address space.
>
> Every hwmod should have a functional clock defined. =A0If they use th=
e same
> functional clock as usb_host_hs, then the same main_clk should be lis=
ted
> for ehci/ohci also.

yes it is right in general convention.
But USB host is different case. :-)

Yes, Ehci and Ohci are embedded within usbhs ; hence they do not need
separate functional clocks.

But the question arises here , why do we need these ehci and ohci as tw=
o
different hwmods containing only irq and base address?
It is required for future - to implement remote wakeup feature for ehci
and ohci ports depending on irq-chain handler patches by Tero.
Separate hwmods for ehci and ohci are needed to enable prcm chain-handl=
er
to uniquely identify the wakeup source as ehci or ohci and call only th=
e
corresponding interrupt handler.
We will be using omap_hwmod_mux_init for ehci and ohci hwmods to enable
I/O wakeup capability for respective IO-pads. Depending on the particul=
ar
wakeup source(ehci/ohci), the corresponding ehci or ohci irq handler wi=
ll
be called.

If ehci and ohci are combined with usbhs hwmod as a single hwmod , then
for every wakeup (either ehci or ohci port wakeup) only the first
interrupt handler will be called (please look at the function
omap_hwmod_mux_handle_irq of

/arch/arm/mach-omap2/mux.c file ; in tero's latest patch:
http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg53139.html)
, so in this
case, if ehci interrupt is the first interrupt , then even for ohci wak=
eup
, only ehci interrupt will get called; which will break the functionali=
ty.

>> 4. usb_tll_hs hwmod of usbhs with the TLL base address and irq.
>>
>> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
>> Reviewed-by: Partha Basak <parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org>
>> ---
>> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0271 +++++++++++++=
+++++++++++++++
>> =A01 files changed, 271 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/m=
ach-omap2/omap_hwmod_3xxx_data.c
>> index 59fdb9f..d79f728 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> @@ -84,6 +84,10 @@ static struct omap_hwmod omap3xxx_mcbsp4_hwmod;
>> =A0static struct omap_hwmod omap3xxx_mcbsp5_hwmod;
>> =A0static struct omap_hwmod omap3xxx_mcbsp2_sidetone_hwmod;
>> =A0static struct omap_hwmod omap3xxx_mcbsp3_sidetone_hwmod;
>> +static struct omap_hwmod omap34xx_usb_host_hs_hwmod;
>> +static struct omap_hwmod omap34xx_usbhs_ohci_hwmod;
>> +static struct omap_hwmod omap34xx_usbhs_ehci_hwmod;
>> +static struct omap_hwmod omap34xx_usb_tll_hs_hwmod;
>>
>> =A0/* L3 -> L4_CORE interface */
>> =A0static struct omap_hwmod_ocp_if omap3xxx_l3_main__l4_core =3D {
>> @@ -3196,6 +3200,266 @@ static struct omap_hwmod omap3xxx_mmc3_hwmod=
 =3D {
>> =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP343=
0),
>> =A0};
>>
>> +/*
>> + * 'usb_host_hs' class
>> + * high-speed multi-port usb host controller
>> + */
>> +static struct omap_hwmod_ocp_if omap34xx_usb_host_hs__l3_main_2 =3D=
 {
>> + =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap34xx_usb_host_hs_hwmod,
>> + =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap3xxx_l3_main_hwmod,
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "core_l3_ick",
>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU,
>> +};
>> +
>> +static struct omap_hwmod_class_sysconfig omap34xx_usb_host_hs_sysc =
=3D {
>> + =A0 =A0 .rev_offs =A0 =A0 =A0 =3D 0x0000,
>> + =A0 =A0 .sysc_offs =A0 =A0 =A0=3D 0x0010,
>> + =A0 =A0 .syss_offs =A0 =A0 =A0=3D 0x0014,
>> + =A0 =A0 .sysc_flags =A0 =A0 =3D (SYSC_HAS_MIDLEMODE | SYSC_HAS_SID=
LEMODE),
>
> This is missing a bunch of SYSC bits, according to Table 24-152
> "UHH_SYSCONFIG" of the 34xx public TRM, version ZR.

 some time back i had extended this , but it was causing system resets;
I will check this and add the remaining flags.



>> + =A0 =A0 .idlemodes =A0 =A0 =A0=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_=
SMART |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MSTANDBY_FORCE | MS=
TANDBY_NO | MSTANDBY_SMART),
>> + =A0 =A0 .sysc_fields =A0 =A0=3D &omap_hwmod_sysc_type1,
>> +};
>> +
>> +static struct omap_hwmod_class omap34xx_usb_host_hs_hwmod_class =3D=
 {
>> + =A0 =A0 .name =3D "usb_host_hs",
>> + =A0 =A0 .sysc =3D &omap34xx_usb_host_hs_sysc,
>> +};
>> +
>> +static struct omap_hwmod_ocp_if *omap34xx_usb_host_hs_masters[] =3D=
 {
>> + =A0 =A0 &omap34xx_usb_host_hs__l3_main_2,
>> +};
>> +
>> +static struct omap_hwmod_addr_space omap34xx_usb_host_hs_addrs[] =3D=
 {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "uhh",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x48064000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x480643ff,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYPE_RT
>> + =A0 =A0 },
>> + =A0 =A0 {}
>> +};
>> +
>> +static struct omap_hwmod_ocp_if omap34xx_l4_cfg__usb_host_hs =3D {
>> + =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap3xxx_l4_core_hwmod,
>> + =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap34xx_usb_host_hs_hwmod,
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_ick",
>> + =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap34xx_usb_host_hs_addrs,
>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_SDMA=
,
>> +};
>> +
>> +static struct omap_hwmod_ocp_if omap34xx_f128m_cfg__usb_host_hs =3D=
 {
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "usbhost_120m_fck",
>
> This doesn't look right. =A0This is an interface structure record, so=
 it
> should be associated with an interface clock. =A0Is the hardware real=
ly
> using the functional clock as the interface clock? =A0Or, as seems mo=
re
> likely...


Agreed, how about:

main clock: usbhost_120m_fck
optional f clock: usbhost_48m_fck
interface clock: usbhost_ick.



>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU,
>> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D OCPIF_SWSUP_IDLE,
>
> ... is this just a hack? =A0OCPIF_SWSUP_IDLE is intended to work arou=
nd
> hardware autoidle bugs only. =A0Are you sure this shouldn't be define=
d as an
> optional clock instead?

yes ! it was causeing resets, hence you this flag.

>
>> +};
>> +
>> +static struct omap_hwmod_ocp_if omap34xx_f48m_cfg__usb_host_hs =3D =
{
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "usbhost_48m_fck",
>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU,
>> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D OCPIF_SWSUP_IDLE,
>> +};
>
> Same comments as the above.

>> +
>> +static struct omap_hwmod_ocp_if *omap34xx_usb_host_hs_slaves[] =3D =
{
>> + =A0 =A0 &omap34xx_l4_cfg__usb_host_hs,
>> + =A0 =A0 &omap34xx_f128m_cfg__usb_host_hs,
>> + =A0 =A0 &omap34xx_f48m_cfg__usb_host_hs,
>> +};
>> +
>> +static struct omap_hwmod omap34xx_usb_host_hs_hwmod =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usb_host_hs",
>> + =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap34xx_usb_host_hs_hwmod_=
class,
>> + =A0 =A0 .main_clk =A0 =A0 =A0 =3D "usbhost_ick",
>
> Is this really the main clock? =A0The main clock is the clock that dr=
ives
> the register logic in the IP block. =A0Looks to me, based on the inte=
gration
> document in the 34xx TRM vZR, that this module has a functional clock=
=2E =A0In
> general, the only time that the main_clk should be an interface clock=
 is
> when the clock is a combined interface and functional clock. =A0The m=
ailbox
> IP block is a classic example.

As I mentioned above;  I can make

main clock: usbhost_120m_fck
optional f clock: usbhost_48m_fck
interface clock: usbhost_ick.

do you agree?

>> + =A0 =A0 .prcm =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .omap2 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_offs =3D OMAP3430E=
S2_USBHOST_MOD,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .prcm_reg_id =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_bit =3D 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_reg_id =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_idle_bit =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_stdby_bit =3D 0,
>
> These bit shifts should use macros, rather than numbers, which is the
> existing practice for the other hwmods in the
> omap_hwmod_3xxx_data.c file.

Ok, I will make this change.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 },
>> + =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap34xx_usb_host_hs_slaves,
>> + =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap34xx_usb_host_hs_sl=
aves),
>> + =A0 =A0 .masters =A0 =A0 =A0 =A0=3D omap34xx_usb_host_hs_masters,
>> + =A0 =A0 .masters_cnt =A0 =A0=3D ARRAY_SIZE(omap34xx_usb_host_hs_ma=
sters),
>> +/*
>> + * The usbhs controller prevents the enter omap to low power mode
>> + * if other than FORCE IDLE and FORCE STANDBY are used.
>> + */
>> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_SWSUP_SIDLE | HWMOD_SW=
SUP_MSTANDBY,
>> + =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)=
,
>
> Please rebase this series on Tony's current master branch, which gets=
 rid
> of the omap_chip structure field.


yes, I will do this;

>> +};
>> +
>> +/* 'usb_ohci_hs' class =A0*/
>> +static struct omap_hwmod_class omap34xx_usbhs_ohci_hwmod_class =3D =
{
>> + =A0 =A0 .name =3D "usb_ohci_hs",
>> +};
>> +
>> +static struct omap_hwmod_irq_info omap34xx_usbhs_ohci_irqs[] =3D {
>> + =A0 =A0 { .name =3D "ohci-irq", .irq =3D 76 },
>> + =A0 =A0 { .irq =3D -1 }
>> +};
>> +
>> +static struct omap_hwmod_addr_space omap34xx_usbhs_ohci_addrs[] =3D=
 {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "ohci",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x48064400,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x480647ff,
>
> This is missing a
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYP=
E_RT
>
> since this address range is a register target.
>
>> + =A0 =A0 },
>> + =A0 =A0 {}
>> +};
>> +
>> +static struct omap_hwmod_ocp_if omap34xx_l4_cfg__usbhs_ohci =3D {
>> + =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap3xxx_l4_core_hwmod,
>> + =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap34xx_usbhs_ohci_hwmod,
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_ick",
>> + =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap34xx_usbhs_ohci_addrs,
>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_SDMA=
,
>> +};
>> +
>> +static struct omap_hwmod_ocp_if *omap34xx_usbhs_ohci_slaves[] =3D {
>> + =A0 =A0 &omap34xx_l4_cfg__usbhs_ohci,
>> +};
>> +
>> +static struct omap_hwmod omap34xx_usbhs_ohci_hwmod =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usb_ohci_hs",
>
> This is missing a main_clk.
>
>> + =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap34xx_usbhs_ohci_hwmod_c=
lass,
>> + =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap34xx_usbhs_ohci_irqs,
>> + =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap34xx_usbhs_ohci_slaves,
>> + =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap34xx_usbhs_ohci_sla=
ves),
>> +/*
>> + * The ohci hwmod does not has any sysconfig , so
>> + * there is no RESET and IDLE settings.
>> + */
>> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_INIT_NO_RESET | HWMOD_=
NO_IDLEST,
>> + =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)=
,
>> +};
>> +
>> +/* 'usb_ehci_hs' class =A0*/
>> +static struct omap_hwmod_class omap34xx_usbhs_ehci_hwmod_class =3D =
{
>> + =A0 =A0 .name =3D "usb_ehci_hs",
>> +};
>> +
>> +static struct omap_hwmod_irq_info omap34xx_usbhs_ehci_irqs[] =3D {
>> + =A0 =A0 { .name =3D "ehci-irq", .irq =3D 77 },
>> + =A0 =A0 { .irq =3D -1 }
>> +};
>> +
>> +static struct omap_hwmod_addr_space omap34xx_usbhs_ehci_addrs[] =3D=
 {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "ehci",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x48064800,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x48064cff,
>
> This is missing a
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYP=
E_RT
>
> since this address range is a register target.
>
>> + =A0 =A0 },
>> + =A0 =A0 {}
>> +};
>> +
>> +static struct omap_hwmod_ocp_if omap34xx_l4_cfg__usbhs_ehci =3D {
>> + =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap3xxx_l4_core_hwmod,
>> + =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap34xx_usbhs_ehci_hwmod,
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_ick",
>> + =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap34xx_usbhs_ehci_addrs,
>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_SDMA=
,
>> +};
>> +
>> +static struct omap_hwmod_ocp_if *omap34xx_usbhs_ehci_slaves[] =3D {
>> + =A0 =A0 &omap34xx_l4_cfg__usbhs_ehci,
>> +};
>> +
>> +static struct omap_hwmod omap34xx_usbhs_ehci_hwmod =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usb_ehci_hs",
>> + =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap34xx_usbhs_ehci_hwmod_c=
lass,
>
> This is missing a main_clk.
>
>> + =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap34xx_usbhs_ehci_irqs,
>> + =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap34xx_usbhs_ehci_slaves,
>> + =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap34xx_usbhs_ehci_sla=
ves),
>> +/*
>> + * The ehci hwmod does not has any sysconfig , so
>> + * there is no RESET and IDLE settings.
>> + */
>> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_INIT_NO_RESET | HWMOD_=
NO_IDLEST,
>> + =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)=
,
>> +};
>> +
>> +/*
>> + * 'usb_tll_hs' class
>> + * usb_tll_hs module is the adapter on the usb_host_hs ports
>> + */
>> +static struct omap_hwmod_class_sysconfig omap34xx_usb_tll_hs_sysc =3D=
 {
>> + =A0 =A0 .rev_offs =A0 =A0 =A0 =3D 0x0000,
>> + =A0 =A0 .sysc_offs =A0 =A0 =A0=3D 0x0010,
>> + =A0 =A0 .syss_offs =A0 =A0 =A0=3D 0x0014,
>> + =A0 =A0 .sysc_flags =A0 =A0 =3D (SYSC_HAS_AUTOIDLE | SYSC_HAS_SIDL=
EMODE |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SYSC_HAS_SOFTRESET | SYSC_=
HAS_ENAWAKEUP |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SYSC_HAS_CLOCKACTIVITY),
>
> These flags should be aligned with the character after the first
> parenthesis.

Sorry !  It was comment from benoit; I will fixed in may places; some h=
ow
i have missed this.

>
>> + =A0 =A0 .idlemodes =A0 =A0 =A0=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_=
SMART),
>> + =A0 =A0 .sysc_fields =A0 =A0=3D &omap_hwmod_sysc_type1,
>> +};
>> +
>> +static struct omap_hwmod_class omap34xx_usb_tll_hs_hwmod_class =3D =
{
>> + =A0 =A0 .name =3D "usb_tll_hs",
>> + =A0 =A0 .sysc =3D &omap34xx_usb_tll_hs_sysc,
>> +};
>> +
>> +static struct omap_hwmod_irq_info omap34xx_usb_tll_hs_irqs[] =3D {
>> + =A0 =A0 { .name =3D "tll-irq", .irq =3D 78 },
>> + =A0 =A0 { .irq =3D -1 }
>> +};
>> +
>> +static struct omap_hwmod_addr_space omap34xx_usb_tll_hs_addrs[] =3D=
 {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "tll",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x48062000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x48062fff,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYPE_RT
>> + =A0 =A0 },
>> + =A0 =A0 {}
>> +};
>> +
>> +static struct omap_hwmod_ocp_if omap34xx_f_cfg__usb_tll_hs =3D {
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "usbtll_fck",
>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU,
>> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D OCPIF_SWSUP_IDLE,
>> +};
>
> Same comments as for omap34xx_f128m_cfg__usb_host_hs above.
>
>> +
>> +static struct omap_hwmod_ocp_if omap34xx_l4_cfg__usb_tll_hs =3D {
>> + =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap3xxx_l4_core_hwmod,
>> + =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap34xx_usb_tll_hs_hwmod,
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_ick",
>> + =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap34xx_usb_tll_hs_addrs,
>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_SDMA=
,
>> +};
>> +
>> +static struct omap_hwmod_ocp_if *omap34xx_usb_tll_hs_slaves[] =3D {
>> + =A0 =A0 &omap34xx_l4_cfg__usb_tll_hs,
>> + =A0 =A0 &omap34xx_f_cfg__usb_tll_hs,
>> +};
>> +
>> +static struct omap_hwmod omap34xx_usb_tll_hs_hwmod =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "usb_tll_hs",
>> + =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap34xx_usb_tll_hs_hwmod_c=
lass,
>> + =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap34xx_usb_tll_hs_irqs,
>> + =A0 =A0 .main_clk =A0 =A0 =A0 =3D "usbtll_ick",
>
> Is this really the main clock? =A0The main clock is the clock that dr=
ives
> the register logic in the IP block. =A0Looks to me, based on the inte=
gration
> document in the 34xx TRM vZR, that this module has a functional clock=
=2E

I can make

main clock: usbtll_fck
interface clock: usbtll_ick.

do you agree?



>> + =A0 =A0 .prcm =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .omap2 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_offs =3D CORE_MOD,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .prcm_reg_id =3D 3,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_bit =3D 2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_reg_id =3D 3,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_idle_bit =3D 2,
>
> These bit shifts should use macros, rather than numbers, which is the
> existing practice for the other hwmods in the
> omap_hwmod_3xxx_data.c file.

yes, I will do this.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
