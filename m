From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH v5 4/7] arm: omap4: hwmod: introduce emu hwmod
Date: Sat, 19 Nov 2011 22:37:08 +0800
Message-ID: <CACVXFVN+8RXsheCwoneCz3AZcmhjfoOy+aG=PQVbuUMdpKaG5A@mail.gmail.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
	<1319467559-5518-5-git-send-email-ming.lei@canonical.com>
	<alpine.DEB.2.00.1111080750130.10451@utopia.booyaka.com>
	<CACVXFVMSJUT2Ac+bWetrLpbyOs6PqY+npNHsbvHipEVZ0gWdgQ@mail.gmail.com>
	<alpine.DEB.2.00.1111100152430.4195@utopia.booyaka.com>
	<4EC6566C.70202@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:55357 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932Ab1KSOhK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Nov 2011 09:37:10 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1RRm2W-0001Nk-Ta
	for linux-omap@vger.kernel.org; Sat, 19 Nov 2011 14:37:08 +0000
Received: by wwe3 with SMTP id 3so2767152wwe.1
        for <linux-omap@vger.kernel.org>; Sat, 19 Nov 2011 06:37:08 -0800 (PST)
In-Reply-To: <4EC6566C.70202@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux@arm.linux.org.uk, will.deacon@arm.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@deeprootsystems.com

Hi Benoit,

On Fri, Nov 18, 2011 at 8:58 PM, Cousson, Benoit <b-cousson@ti.com> wro=
te:
> Hi Ming Lei,
>
> Sorry, for the delay, it took me some time to gather the exhaustive d=
ata for that block.

The work is really great.

> On 11/10/2011 10:02 AM, Paul Walmsley wrote:
>> Hello Ming Lei,
>>
>> just a few quick comments for now -
>>
>> On Wed, 9 Nov 2011, Ming Lei wrote:
>>
>>> On Tue, Nov 8, 2011 at 11:26 PM, Paul Walmsley<paul@pwsan.com> =C2=A0=
wrote:
>>>
>>>>> +static struct omap_hwmod_irq_info omap44xx_emu_irqs[] =3D {
>>>>> + =C2=A0 =C2=A0 { .name =3D "cti0", .irq =3D 1 + OMAP44XX_IRQ_GIC=
_START },
>>>>> + =C2=A0 =C2=A0 { .name =3D "cti1", .irq =3D 2 + OMAP44XX_IRQ_GIC=
_START },
>>>>> + =C2=A0 =C2=A0 { .irq =3D -1 }
>>>>> +};
>>>>
>>>> Are you sure these are part of the emulation IP? =C2=A0We already =
have those
>>>
>>> I am not sure, I just figure out one way to make omap4 pmu work. Si=
nce there
>>> are few descriptions in TRM about it, it is a hacking based on [1],=
 :-)
>>>
>>>> IRQs in the MPU hwmod, see omap44xx_mpu_irqs[] in the same file.
>>>
>>> I just see it, but looks like the "mpu" hwmod isn't populated as om=
ap_device,
>>> so the CTI irqs aren't requested now.
>>
>> Okay. =C2=A0Maybe you can probably add some code in mach-omap2/devic=
es.c to
>> build an omap_device for this for right now? =C2=A0I am not 100% sur=
e whether
>> those cti0/1 interrupts should be associated with the MPU or with th=
e
>> DEBUGSS but Beno=C4=ABt might be able to answer this.
>>
>>> Also, current arm perf code don't handle three IRQs(one pl310 irq a=
nd
>>> two CTI irq) inside one device correctly.
>>
>> To fix this, that ARM perf code should either be using
>> platform_get_irq_byname(), or the hwmod hardware data will need to b=
e
>> rearranged to meet the arbitrary ordering requirement. =C2=A0I'd sug=
gest
>> pinging Will on this issue to see what he wants to do.
>>
>>> So any suggestion about CTI IRQs connecting to which hwmod, so that=
 they can
>>> be found by pmu driver?
>>>
>>>>> +/*emu hwmod*/
>>>>> +static struct omap_hwmod omap44xx_emu_hwmod =3D {
>>>>> + =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "emu=
",
>>>>> + =C2=A0 =C2=A0 .class =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D&omap=
44xx_emu_hwmod_class,
>>>>> + =C2=A0 =C2=A0 .clkdm_name =C2=A0 =C2=A0 =3D "emu_sys_clkdm",
>>>>> + =C2=A0 =C2=A0 .prcm =3D {
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .omap4 =3D {
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .clkctrl_offs =3D OMAP4_CM_EMU_CLKSTCTRL_OFFSET,
>>>>
>>>> This doesn't look right either: EMU is a clockdomain, not an IP bl=
ock.
>>>
>>> I defined the 'emu' hwmod to control the clock state transition of =
the EMU
>>> clock domain by writing to CLKTRCTRL.CM_EMU_CLKSTCTRL with standard
>>> hwmod interface(_enable / _idle). Is there any other neat way to do=
 it?
>>
>> So the clockdomain is already defined in
>> mach-omap2/clockdomains44xx_data.c and there's code to control it - =
see
>> for example clkdm_enable_idle(). =C2=A0But this code should not be c=
alled
>> directly by any device driver code or driver integration code. =C2=A0=
The thing
>> to do here is to ask Beno=C4=ABt to release the hwmod data for the D=
EBUGSS
>> hwmod, then someone will need to write an MFD driver for that which
>> exposes the PMU address space to the PMU platform driver.
>
> Following that discussion, here is the patch to expose debugss hwmod.
>
> I have moved the CTIs irq from MPU to debugss and exposed all the int=
ernals IP that are part of the OMAP debug subsystem.
>
> Since the DEBUGSS cannot be accessed at boot time if the l3_main_3 an=
d the l3_instr interconnects are not enable, you will have some warning=
s.
>

Currently these two modules are enabled in my patch 5/7 and 6/7, and th=
e
pmu omap device is built from the three IPs: debugss, l3_main_3 and
the l3_instr,
so that these two modules can be enabled in omap_device_enable().

I don't know how to enable the two IPs in other ways, also I am not
sure if the way
is suitable, but it does work, could you help to review the two patches=
?

> [ =C2=A0 =C2=A00.416992] omap_hwmod: debugss: softreset failed (waite=
d 10000 usec)
> [ =C2=A0 =C2=A00.426727] omap_hwmod: debugss: _wait_target_disable fa=
iled
>
> Just let me know if you have any issue with that patch.

In fact, now it is very easy to enable pmu on omap with your patch,
I have made omap4 pmu work already using debugss:

     - replace the patch 3/7 with your debugss patch(replace 'emu'
with 'debugss')
     - modify the patch  5/7 to create pmu omap device from 'debugss'
instead of 'emu'

thanks,
--
Ming Lei

>
> Please note that will will need the fix "ARM: OMAP: hwmod: Fix the ad=
dr space, irq, dma count APIs" to avoid hwmod core messing up with the =
resources.
>
> I've just posted a pull request for Tony to get it for -rc3.
> http://comments.gmane.org/gmane.linux.ports.arm.kernel/140458
>
> I pushed these two patches on a branch based on mainline for your con=
venience.
>
> git://gitorious.org/omap-pm/linux.git wip-emu/debuss_hwmod
>
> Regards,
> Benoit
>
> ---
> From: Benoit Cousson <b-cousson@ti.com>
> Date: Fri, 18 Nov 2011 11:42:12 +0100
> Subject: [PATCH] ARM: OMAP4: hwmod data: Add support for the debug mo=
dules
>
> The OMAP4 DEBUG subsystem contains all the IPs used for emulation,
> included the ones from the CortexA9 MPU.
> Expose the individual modules base address.
>
> Re-map the CTIs IRQs from MPU to DEBUGSS.
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Ming Lei <ming.lei@canonical.com>
> ---
> =C2=A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =C2=A0177 ++++++++=
+++++++++++++++++++-
> =C2=A01 files changed, 174 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/ma=
ch-omap2/omap_hwmod_44xx_data.c
> index 7695e5d..6cf21ee 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -47,6 +47,7 @@
>
> =C2=A0/* Backward references (IPs with Bus Master capability) */
> =C2=A0static struct omap_hwmod omap44xx_aess_hwmod;
> +static struct omap_hwmod omap44xx_debugss_hwmod;
> =C2=A0static struct omap_hwmod omap44xx_dma_system_hwmod;
> =C2=A0static struct omap_hwmod omap44xx_dmm_hwmod;
> =C2=A0static struct omap_hwmod omap44xx_dsp_hwmod;
> @@ -337,6 +338,14 @@ static struct omap_hwmod omap44xx_l3_main_1_hwmo=
d =3D {
> =C2=A0};
>
> =C2=A0/* l3_main_2 */
> +/* debugss -> l3_main_2 */
> +static struct omap_hwmod_ocp_if omap44xx_debugss__l3_main_2 =3D {
> + =C2=A0 =C2=A0 =C2=A0 .master =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &omap4=
4xx_debugss_hwmod,
> + =C2=A0 =C2=A0 =C2=A0 .slave =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &=
omap44xx_l3_main_2_hwmod,
> + =C2=A0 =C2=A0 =C2=A0 .clk =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D "dbgclk_mux_ck",
> + =C2=A0 =C2=A0 =C2=A0 .user =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D O=
CP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> =C2=A0/* dma_system -> l3_main_2 */
> =C2=A0static struct omap_hwmod_ocp_if omap44xx_dma_system__l3_main_2 =
=3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.master =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &o=
map44xx_dma_system_hwmod,
> @@ -686,7 +695,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwm=
od =3D {
> =C2=A0* =C2=A0ctrl_module_pad_core
> =C2=A0* =C2=A0ctrl_module_pad_wkup
> =C2=A0* =C2=A0ctrl_module_wkup
> - * =C2=A0debugss
> =C2=A0* =C2=A0efuse_ctrl_cust
> =C2=A0* =C2=A0efuse_ctrl_std
> =C2=A0* =C2=A0elm
> @@ -908,6 +916,168 @@ static struct omap_hwmod omap44xx_counter_32k_h=
wmod =3D {
> =C2=A0};
>
> =C2=A0/*
> + * 'debugss' class
> + * debug and emulation sub system
> + */
> +
> +static struct omap_hwmod_class_sysconfig omap44xx_debugss_sysc =3D {
> + =C2=A0 =C2=A0 =C2=A0 .rev_offs =C2=A0 =C2=A0 =C2=A0 =3D 0x0000,
> + =C2=A0 =C2=A0 =C2=A0 .sysc_offs =C2=A0 =C2=A0 =C2=A0=3D 0x0010,
> + =C2=A0 =C2=A0 =C2=A0 .syss_offs =C2=A0 =C2=A0 =C2=A0=3D 0x0014,
> + =C2=A0 =C2=A0 =C2=A0 .sysc_flags =C2=A0 =C2=A0 =3D (SYSC_HAS_SOFTRE=
SET | SYSS_HAS_RESET_STATUS),
> + =C2=A0 =C2=A0 =C2=A0 .sysc_fields =C2=A0 =C2=A0=3D &omap_hwmod_sysc=
_type1,
> +};
> +
> +static struct omap_hwmod_class omap44xx_debugss_hwmod_class =3D {
> + =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =3D "debugss",
> + =C2=A0 =C2=A0 =C2=A0 .sysc =C2=A0 =3D &omap44xx_debugss_sysc,
> +};
> +
> +/* debugss */
> +static struct omap_hwmod_irq_info omap44xx_debugss_irqs[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 { .name =3D "cti0", .irq =3D 1 + OMAP44XX_IRQ_=
GIC_START },
> + =C2=A0 =C2=A0 =C2=A0 { .name =3D "cti1", .irq =3D 2 + OMAP44XX_IRQ_=
GIC_START },
> + =C2=A0 =C2=A0 =C2=A0 { .irq =3D -1 }
> +};
> +
> +/* debugss master ports */
> +static struct omap_hwmod_ocp_if *omap44xx_debugss_masters[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 &omap44xx_debugss__l3_main_2,
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_debugss_addrs[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D "mipi_stm_add_sp_0",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_start =C2=A0 =C2=
=A0 =C2=A0 =3D 0x54000000,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_end =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D 0x540fffff,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D "mipi_stm_add_sp_1",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_start =C2=A0 =C2=
=A0 =C2=A0 =3D 0x54100000,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_end =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D 0x5413ffff,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D "mpu_c0_debug",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_start =C2=A0 =C2=
=A0 =C2=A0 =3D 0x54140000,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_end =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D 0x54141fff,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D "mpu_c1_debug",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_start =C2=A0 =C2=
=A0 =C2=A0 =3D 0x54142000,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_end =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D 0x54143fff,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D "cti0_mpu",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_start =C2=A0 =C2=
=A0 =C2=A0 =3D 0x54148000,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_end =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D 0x54148fff,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D "cti1_mpu",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_start =C2=A0 =C2=
=A0 =C2=A0 =3D 0x54149000,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_end =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D 0x54149fff,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D "ptm0_mpu",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_start =C2=A0 =C2=
=A0 =C2=A0 =3D 0x5414c000,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_end =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D 0x5414cfff,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D "ptm1_mpu",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_start =C2=A0 =C2=
=A0 =C2=A0 =3D 0x5414d000,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_end =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D 0x5414dfff,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D "tf_mpu",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_start =C2=A0 =C2=
=A0 =C2=A0 =3D 0x54158000,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_end =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D 0x54158fff,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D "dap_pc_mpu",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_start =C2=A0 =C2=
=A0 =C2=A0 =3D 0x54159000,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_end =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D 0x54159fff,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D "apb_bridge_a_ctrl_time_out",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_start =C2=A0 =C2=
=A0 =C2=A0 =3D 0x5415f000,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_end =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D 0x5415ffff,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D "drm",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_start =C2=A0 =C2=
=A0 =C2=A0 =3D 0x54160000,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_end =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D 0x54160fff,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D "mipi_stm",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_start =C2=A0 =C2=
=A0 =C2=A0 =3D 0x54161000,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_end =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D 0x54161fff,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0=3D ADDR_TYPE_RT
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D "csetb",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_start =C2=A0 =C2=
=A0 =C2=A0 =3D 0x54162000,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_end =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D 0x54162fff,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D "cstpiu",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_start =C2=A0 =C2=
=A0 =C2=A0 =3D 0x54163000,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_end =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D 0x54163fff,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D "cstf1",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_start =C2=A0 =C2=
=A0 =C2=A0 =3D 0x54164000,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_end =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D 0x54164fff,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D "cstf2",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_start =C2=A0 =C2=
=A0 =C2=A0 =3D 0x54165000,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_end =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D 0x54165fff,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D "l4_cfg_emu_conf_regs",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_start =C2=A0 =C2=
=A0 =C2=A0 =3D 0x54167000,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_end =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D 0x54167fff,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D "l3_instr_emu_conf_regs",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_start =C2=A0 =C2=
=A0 =C2=A0 =3D 0x54180000,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa_end =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D 0x54180fff,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 { }
> +};
> +
> +/* l3_instr -> debugss */
> +static struct omap_hwmod_ocp_if omap44xx_l3_instr__debugss =3D {
> + =C2=A0 =C2=A0 =C2=A0 .master =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &omap4=
4xx_l3_instr_hwmod,
> + =C2=A0 =C2=A0 =C2=A0 .slave =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &=
omap44xx_debugss_hwmod,
> + =C2=A0 =C2=A0 =C2=A0 .clk =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D "l3_div_ck",
> + =C2=A0 =C2=A0 =C2=A0 .addr =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D o=
map44xx_debugss_addrs,
> + =C2=A0 =C2=A0 =C2=A0 .user =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D O=
CP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* debugss slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_debugss_slaves[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 &omap44xx_l3_instr__debugss,
> +};
> +
> +static struct omap_hwmod omap44xx_debugss_hwmod =3D {
> + =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "=
debugss",
> + =C2=A0 =C2=A0 =C2=A0 .class =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &=
omap44xx_debugss_hwmod_class,
> + =C2=A0 =C2=A0 =C2=A0 .clkdm_name =C2=A0 =C2=A0 =3D "emu_sys_clkdm",
> + =C2=A0 =C2=A0 =C2=A0 .mpu_irqs =C2=A0 =C2=A0 =C2=A0 =3D omap44xx_de=
bugss_irqs,
> + =C2=A0 =C2=A0 =C2=A0 .main_clk =C2=A0 =C2=A0 =C2=A0 =3D "trace_clk_=
div_ck",
> + =C2=A0 =C2=A0 =C2=A0 .prcm =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .omap4 =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 .clkctrl_offs =3D OMAP4_CM_EMU_DEBUGSS_CLKCTRL_OFFSET,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 .context_offs =3D OMAP4_RM_EMU_DEBUGSS_CONTEXT_OFFSET,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 .slaves =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D omap44=
xx_debugss_slaves,
> + =C2=A0 =C2=A0 =C2=A0 .slaves_cnt =C2=A0 =C2=A0 =3D ARRAY_SIZE(omap4=
4xx_debugss_slaves),
> + =C2=A0 =C2=A0 =C2=A0 .masters =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D omap44=
xx_debugss_masters,
> + =C2=A0 =C2=A0 =C2=A0 .masters_cnt =C2=A0 =C2=A0=3D ARRAY_SIZE(omap4=
4xx_debugss_masters),
> +};
> +
> +/*
> =C2=A0* 'dma' class
> =C2=A0* dma controller for data exchange between memory to memory (i.=
e. internal or
> =C2=A0* external memory) and gp peripherals to memory or memory to gp=
 peripherals
> @@ -3902,8 +4072,6 @@ static struct omap_hwmod_class omap44xx_mpu_hwm=
od_class =3D {
> =C2=A0/* mpu */
> =C2=A0static struct omap_hwmod_irq_info omap44xx_mpu_irqs[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{ .name =3D "pl310", .irq =3D 0 + OMAP44XX=
_IRQ_GIC_START },
> - =C2=A0 =C2=A0 =C2=A0 { .name =3D "cti0", .irq =3D 1 + OMAP44XX_IRQ_=
GIC_START },
> - =C2=A0 =C2=A0 =C2=A0 { .name =3D "cti1", .irq =3D 2 + OMAP44XX_IRQ_=
GIC_START },
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{ .irq =3D -1 }
> =C2=A0};
>
> @@ -5308,6 +5476,9 @@ static __initdata struct omap_hwmod *omap44xx_h=
wmods[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* counter class */
> =C2=A0/* =C2=A0 =C2=A0 &omap44xx_counter_32k_hwmod, */
>
> + =C2=A0 =C2=A0 =C2=A0 /* debugss class */
> + =C2=A0 =C2=A0 =C2=A0 &omap44xx_debugss_hwmod,
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* dma class */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0&omap44xx_dma_system_hwmod,
>
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
