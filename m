From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: [PATCH 6/7] [RFC] OMAP: hwmod: SYSCONFIG register modification
 for MCBSP
Date: Mon, 22 Nov 2010 21:29:49 +0530
Message-ID: <AANLkTimExJBgLTfO2Q7zgohHquShvm9kP64=DLjQv21u@mail.gmail.com>
References: <1286296662-7639-1-git-send-email-kishon@ti.com>
	<1286296662-7639-6-git-send-email-kishon@ti.com>
	<4CAECB70.4030705@ti.com>
	<4CB2AC44.6000804@ti.com>
	<AANLkTi=a80MLvj5YuC==evfGqY6xUToHcBU3TyWEBHAo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:37587 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751393Ab0KVP7z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 10:59:55 -0500
Received: by iwn34 with SMTP id 34so182266iwn.6
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 07:59:50 -0800 (PST)
In-Reply-To: <AANLkTi=a80MLvj5YuC==evfGqY6xUToHcBU3TyWEBHAo@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Basak, Partha" <p-basak2@ti.com>
Cc: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, linux-omap@vger.kernel.org, "Kamat, Nishant" <nskamat@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, ext-eero.nurkkala@nokia.com, eduardo.valentin@nokia.com

Resending the mail in plain text format..

On Mon, Nov 22, 2010 at 9:20 PM, ABRAHAM, KISHON VIJAY <kishon@ti.com> =
wrote:
>
> On Mon, Oct 11, 2010 at 11:48 AM, ABRAHAM, KISHON VIJAY <kishon@ti.co=
m> wrote:
>>
>> On Friday 08 October 2010 01:12 PM, Cousson, Benoit wrote:
>> > Hi Kishon,
>> >
>> > On 10/5/2010 6:37 PM, ABRAHAM, KISHON VIJAY wrote:
>> >> MCBSP 2 and 3 in OMAP3 has sidetone feature which requires
>> >> autoidle to be disabled before starting the sidetone. Also SYSCON=
=46IG
>> >> register has to be set with smart idle or no idle depending on th=
e
>> >> dma op mode (threshold or element sync). For doing these operatio=
ns
>> >> dynamically at runtime, hwmod API'S are used to modify SYSCONFIG
>> register
>> >> directly.
>> >
>> > OK, it looks like we don't have the choice... But for the
>> > implementation, please discussed with Manju on that, He is doing t=
he
>> > similar thing for the smartstandby issue on SDMA.
>>
>> =A0 OK.
>
>
> =A0 =A0 =A0 Looks like we have a problem when we write an API similar=
 to the one written
> =A0=A0=A0=A0=A0 by Manju (omap_hwmod_set_master_standbymode()) [1]. I=
n the case of McBSP,
> =A0=A0=A0=A0=A0 I have to modify omap_hwmod_set_slave_idlemode() (whi=
ch is already existing),
> =A0 =A0 =A0 to include something like
>
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 +=A0=A0=A0 if (sf & SYSC_HAS_SIDLEMODE) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 +=A0=A0=A0 =A0=A0=A0 if (idlemode)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 idlemode =3D HWMOD_IDLEMODE_NO;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 +=A0=A0=A0 =A0=A0=A0 else
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 idlemode =3D (oh->flags & HWMOD_SWSUP_S=
IDLE) ?
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 HWMOD_IDLEMODE_NO : HWMOD_IDL=
EMODE_SMART;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 +=A0=A0=A0 }
>
> =A0=A0=A0=A0=A0 Then an API like omap_device_require_no_idle() and om=
ap_device_release_no_idle()
> =A0=A0=A0=A0=A0 would be written similar to omap_device_require_no_ms=
tandby and
> =A0=A0=A0=A0=A0 omap_device_release_no_mstandby() (see [1]) that call=
s
> =A0=A0=A0=A0=A0 omap_hwmod_set_slave_idlemode() with true/false. Pass=
ing true to
> =A0=A0=A0=A0=A0 omap_hwmod_set_slave_idlemode() will write SIDLE bits=
 with
> =A0=A0=A0=A0=A0 HWMOD_IDLEMODE_NO and false to it will write
> =A0=A0=A0=A0=A0 HWMOD_IDLEMODE_NO/HWMOD_IDLEMODE_SMART depending on
> =A0=A0=A0=A0=A0 HWMOD_SWSUP_SIDLE to SIDLE bits.
>
> =A0=A0=A0=A0=A0 This works fine for McBSP since only two modes come t=
o play here
> =A0=A0=A0=A0=A0 (HWMOD_IDLEMODE_NO/HWMOD_IDLEMODE_SMART).
>
> =A0=A0=A0=A0=A0 But omap_hwmod_set_slave_idlemode() API is used by UA=
RT
> =A0=A0=A0=A0=A0 (serial.c Please refer [2]) which writes SIDLE bits t=
o
> =A0=A0=A0=A0=A0 HWMOD_IDLEMODE_NO/HWMOD_IDLEMODE_SMART/ and
> =A0=A0=A0=A0=A0 HWMOD_IDLEMODE_FORCE.
>
> =A0=A0=A0=A0=A0 Modifying omap_hwmod_set_slave_idlemode() will requir=
e
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 1) serial.c to be modified to call functi=
ons like 'omap_device_require_no_idle(),
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 omap_device_release_no_idle()=
' and 'omap_device_require_force_idle() and
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 omap_device_release_force_idl=
e()' instead of
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 omap_hwmod_set_slave_idlemode=
() which is currently present.
>
> =A0=A0=A0=A0=A0 There are 2 problems associated with it
> =A0=A0=A0=A0=A0 1) The first problem is having a single API like omap=
_hwmod_set_slave_idlemode() to
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 set two different values like HWMOD_IDLEM=
ODE_NO or
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 HWMOD_IDLEMODE_FORCE (intended to be call=
ed by omap_device_require_no_idle()
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 and omap_device_require_force_idle() resp=
ectively). According to the new design
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 omap_hwmod_set_slave_idlemode() is intend=
ed to take only true/false as
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 arguments.
>
> =A0=A0=A0=A0=A0 2) The second problem is having the release API's (om=
ap_device_release_no_idle() and
> =A0 =A0 =A0 =A0 =A0=A0 omap_device_release_force_idle()) to restore t=
he SYSCONFIG to the previous state.
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Remember, this was not problem for McB=
SP since only two modes were needed.
>
> =A0=A0=A0=A0=A0 Please provide your comment on this.
>
> -Kishon
>
> =A0=A0=A0=A0=A0 [1] https://patchwork.kernel.org/patch/335591/
> =A0=A0=A0=A0=A0 [2] http://git.kernel.org/?p=3Dlinux/kernel/git/tmlin=
d/linux-omap-2.6.git;a=3Dblob;f=3Darch/arm/mach-omap2/serial.c;h=3Dedd7=
c99de38dde5bf877788fb4e48055c0d9fbfa;hb=3DHEAD
>>
>> >
>> >>
>> >> Signed-off-by: Kishon Vijay Abraham I<kishon@ti.com>
>> >> Signed-off-by: Charulatha V<charu@ti.com>
>> >> Signed-off-by: Shubhrajyoti D<shubhrajyoti@ti.com>
>> >> Cc: Partha Basak<p-basak2@ti.com>
>> >> ---
>> >> =A0 =A0arch/arm/plat-omap/mcbsp.c | =A0 69
>> ++++++++++++++++++++++++++------------------
>> >> =A0 =A01 files changed, 41 insertions(+), 28 deletions(-)
>> >>
>> >> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbs=
p.c
>> >> index c7c6a83..6b705e1 100644
>> >> --- a/arch/arm/plat-omap/mcbsp.c
>> >> +++ b/arch/arm/plat-omap/mcbsp.c
>> >> @@ -228,10 +228,21 @@ void omap_mcbsp_config(unsigned int id, con=
st
>> struct omap_mcbsp_reg_cfg *config)
>> >> =A0 =A0EXPORT_SYMBOL(omap_mcbsp_config);
>> >>
>> >> =A0 =A0#ifdef CONFIG_ARCH_OMAP3
>> >> +static struct omap_hwmod **find_hwmods_by_dev(struct device *dev=
)
>> >> +{
>> >> + =A0 =A0struct platform_device *pdev;
>> >> + =A0 =A0struct omap_device *od;
>> >> + =A0 =A0pdev =3D container_of(dev, struct platform_device, dev);
>> >> + =A0 =A0od =3D container_of(pdev, struct omap_device, pdev);
>> >> + =A0 =A0return od->hwmods;
>> >
>> > Rule #1, don't touch oh in your code. The device should be the onl=
y
>> > interface.
>> > If such API is needed, it should be in omap_device. But in your ca=
se, I
>> > don't thing it is needed.
>>
>> =A0 OK
>> >
>> >> +}
>> >> +
>> >> =A0 =A0static void omap_st_on(struct omap_mcbsp *mcbsp)
>> >> =A0 =A0{
>> >> =A0 =A0 =A0unsigned int w;
>> >> + =A0 =A0struct omap_hwmod **oh;
>> >>
>> >> + =A0 =A0oh =3D find_hwmods_by_dev(mcbsp->dev);
>> >> =A0 =A0 =A0/*
>> >> =A0 =A0 =A0 * Sidetone uses McBSP ICLK - which must not idle when=
 sidetones
>> >> =A0 =A0 =A0 * are enabled or sidetones start sounding ugly.
>> >> @@ -244,8 +255,7 @@ static void omap_st_on(struct omap_mcbsp *mcb=
sp)
>> >> =A0 =A0 =A0w =3D MCBSP_READ(mcbsp, SSELCR);
>> >> =A0 =A0 =A0MCBSP_WRITE(mcbsp, SSELCR, w | SIDETONEEN);
>> >>
>> >> - =A0 =A0w =3D MCBSP_ST_READ(mcbsp, SYSCONFIG);
>> >> - =A0 =A0MCBSP_ST_WRITE(mcbsp, SYSCONFIG, w& =A0 ~(ST_AUTOIDLE));
>> >> + =A0 =A0omap_hwmod_set_module_autoidle(oh[1], 0);
>> >
>> > Don't use internal hwmod API. You have to create a similar omap_de=
vice
>> API.
>> > You don't have to select only one hwmod in this case, just change =
the
>> > sysconfig setting for all hwmod that belong to the omap_device, an=
d it
>> > will be fine. It will avoid you to access one hwmod in particular.
>> > This is the implementation that Manju is doing.
>>
>> =A0 OK
>>
>> >
>> >>
>> >> =A0 =A0 =A0/* Enable Sidetone from Sidetone Core */
>> >> =A0 =A0 =A0w =3D MCBSP_ST_READ(mcbsp, SSELCR);
>> >> @@ -255,12 +265,14 @@ static void omap_st_on(struct omap_mcbsp *m=
cbsp)
>> >> =A0 =A0static void omap_st_off(struct omap_mcbsp *mcbsp)
>> >> =A0 =A0{
>> >> =A0 =A0 =A0unsigned int w;
>> >> + =A0 =A0struct omap_hwmod **oh;
>> >> +
>> >> + =A0 =A0oh =3D find_hwmods_by_dev(mcbsp->dev);
>> >>
>> >> =A0 =A0 =A0w =3D MCBSP_ST_READ(mcbsp, SSELCR);
>> >> =A0 =A0 =A0MCBSP_ST_WRITE(mcbsp, SSELCR, w& =A0 ~(ST_SIDETONEEN))=
;
>> >>
>> >> - =A0 =A0w =3D MCBSP_ST_READ(mcbsp, SYSCONFIG);
>> >> - =A0 =A0MCBSP_ST_WRITE(mcbsp, SYSCONFIG, w | ST_AUTOIDLE);
>> >> + =A0 =A0omap_hwmod_set_module_autoidle(oh[1], 1);
>> >>
>> >> =A0 =A0 =A0w =3D MCBSP_READ(mcbsp, SSELCR);
>> >> =A0 =A0 =A0MCBSP_WRITE(mcbsp, SSELCR, w& =A0 ~(SIDETONEEN));
>> >> @@ -273,9 +285,11 @@ static void omap_st_off(struct omap_mcbsp *m=
cbsp)
>> >> =A0 =A0static void omap_st_fir_write(struct omap_mcbsp *mcbsp, s1=
6 *fir)
>> >> =A0 =A0{
>> >> =A0 =A0 =A0u16 val, i;
>> >> + =A0 =A0struct omap_hwmod **oh;
>> >>
>> >> - =A0 =A0val =3D MCBSP_ST_READ(mcbsp, SYSCONFIG);
>> >> - =A0 =A0MCBSP_ST_WRITE(mcbsp, SYSCONFIG, val& =A0 ~(ST_AUTOIDLE)=
);
>> >> + =A0 =A0oh =3D find_hwmods_by_dev(mcbsp->dev);
>> >> +
>> >> + =A0 =A0omap_hwmod_set_module_autoidle(oh[1], 0);
>> >>
>> >> =A0 =A0 =A0val =3D MCBSP_ST_READ(mcbsp, SSELCR);
>> >>
>> >> @@ -303,9 +317,11 @@ static void omap_st_chgain(struct omap_mcbsp
>> *mcbsp)
>> >> =A0 =A0{
>> >> =A0 =A0 =A0u16 w;
>> >> =A0 =A0 =A0struct omap_mcbsp_st_data *st_data =3D mcbsp->st_data;
>> >> + =A0 =A0struct omap_hwmod **oh;
>> >> +
>> >> + =A0 =A0oh =3D find_hwmods_by_dev(mcbsp->dev);
>> >>
>> >> - =A0 =A0w =3D MCBSP_ST_READ(mcbsp, SYSCONFIG);
>> >> - =A0 =A0MCBSP_ST_WRITE(mcbsp, SYSCONFIG, w& =A0 ~(ST_AUTOIDLE));
>> >> + =A0 =A0omap_hwmod_set_module_autoidle(oh[1], 0);
>> >>
>> >> =A0 =A0 =A0w =3D MCBSP_ST_READ(mcbsp, SSELCR);
>> >>
>> >> @@ -648,49 +664,46 @@ EXPORT_SYMBOL(omap_mcbsp_get_dma_op_mode);
>> >>
>> >> =A0 =A0static inline void omap34xx_mcbsp_request(struct omap_mcbs=
p *mcbsp)
>> >> =A0 =A0{
>> >> + =A0 =A0struct omap_hwmod **oh;
>> >> +
>> >> + =A0 =A0oh =3D find_hwmods_by_dev(mcbsp->dev);
>> >> =A0 =A0 =A0/*
>> >> =A0 =A0 =A0 * Enable wakup behavior, smart idle and all wakeups
>> >> =A0 =A0 =A0 * REVISIT: some wakeups may be unnecessary
>> >> =A0 =A0 =A0 */
>> >> =A0 =A0 =A0if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
>> >> - =A0 =A0 =A0 =A0 =A0 =A0u16 syscon;
>> >> -
>> >> - =A0 =A0 =A0 =A0 =A0 =A0syscon =3D MCBSP_READ(mcbsp, SYSCON);
>> >> - =A0 =A0 =A0 =A0 =A0 =A0syscon&=3D ~(ENAWAKEUP | SIDLEMODE(0x03)=
 |
>> CLOCKACTIVITY(0x03));
>> >>
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0if (mcbsp->dma_op_mode =3D=3D MCBSP_DM=
A_MODE_THRESHOLD) {
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0syscon |=3D (ENAWAKEUP |=
 SIDLEMODE(0x02) |
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0CLOCKACTIVITY(0x02));
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MCBSP_WRITE(mcbsp, WAKEU=
PEN, XRDYEN | RRDYEN);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_hwmod_enable_wakeup=
(oh[0]);
>> >
>> > Thanks to the patch done by Rajendra, the wakeup should enable bas=
ed on
>> > smartidle config.
>>
>> =A0 OK.
>>
>> >
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_hwmod_set_slave_idl=
emode(oh[0],
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0HWMOD_IDLEMODE_SMART);
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0syscon |=3D SIDLEMODE(0x=
01);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_hwmod_disable_wakeu=
p(oh[0]);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_hwmod_set_slave_idl=
emode(oh[0],
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0HWMOD_IDLEMODE_NO);
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> >> -
>> >> - =A0 =A0 =A0 =A0 =A0 =A0MCBSP_WRITE(mcbsp, SYSCON, syscon);
>> >> =A0 =A0 =A0}
>> >> =A0 =A0}
>> >>
>> >> =A0 =A0static inline void omap34xx_mcbsp_free(struct omap_mcbsp *=
mcbsp)
>> >> =A0 =A0{
>> >> + =A0 =A0struct omap_hwmod **oh;
>> >> +
>> >> + =A0 =A0oh =3D find_hwmods_by_dev(mcbsp->dev);
>> >> =A0 =A0 =A0/*
>> >> =A0 =A0 =A0 * Disable wakup behavior, smart idle and all wakeups
>> >> =A0 =A0 =A0 */
>> >> =A0 =A0 =A0if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
>> >
>> > Please try to avoid this cpu_is_xxx checks. You should identified =
the IP
>> > version if possible or add some SW rev, features or errata in hwmo=
d and
>> > retrieve them during omap_device_build.
>>
>> =A0 OK.
>>
>> >
>> >> - =A0 =A0 =A0 =A0 =A0 =A0u16 syscon;
>> >> -
>> >> - =A0 =A0 =A0 =A0 =A0 =A0syscon =3D MCBSP_READ(mcbsp, SYSCON);
>> >> - =A0 =A0 =A0 =A0 =A0 =A0syscon&=3D ~(ENAWAKEUP | SIDLEMODE(0x03)=
 |
>> CLOCKACTIVITY(0x03));
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 * HW bug workaround - If no_idle mode=
 is taken, we need
>> to
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 * go to smart_idle before going to al=
ways_idle, or the
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 * device will not hit retention anymo=
re.
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
>> >
>> > What is that other bug? The changelog does not mention it?
>>
>> =A0 This is based on the patch sent by Eero Nurkkala [1]. They've ob=
served
>> when DMA mode is selected to element sync(NO IDLE is set in sysconfi=
g),
>> the device does not hit retention if force idle mode is selected
>> without switching to smart idle..
>>
>> [1] http://kerneltrap.org/mailarchive/alsa-devel/2009/8/20/6333573
>> >
>> >> - =A0 =A0 =A0 =A0 =A0 =A0syscon |=3D SIDLEMODE(0x02);
>> >> - =A0 =A0 =A0 =A0 =A0 =A0MCBSP_WRITE(mcbsp, SYSCON, syscon);
>> >> -
>> >> - =A0 =A0 =A0 =A0 =A0 =A0syscon&=3D ~(SIDLEMODE(0x03));
>> >> - =A0 =A0 =A0 =A0 =A0 =A0MCBSP_WRITE(mcbsp, SYSCON, syscon);
>> >> -
>> >> + =A0 =A0 =A0 =A0 =A0 =A0omap_hwmod_disable_wakeup(oh[0]);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0omap_hwmod_set_slave_idlemode(oh[0],
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0HWMOD_IDLEMODE_SMART);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0omap_hwmod_set_slave_idlemode(oh[0],
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0HWMOD_IDLEMODE_FORCE);
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0MCBSP_WRITE(mcbsp, WAKEUPEN, 0);
>> >> =A0 =A0 =A0}
>> >> =A0 =A0}
>> >
>> > Regards,
>> > Benoit
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
