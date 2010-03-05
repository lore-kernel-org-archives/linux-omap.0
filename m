From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 15/16] OMAP3: PM: VP force update method of voltage
	scaling
Date: Fri, 5 Mar 2010 17:26:30 +0200
Message-ID: <94a0d4531003050726y52b2fe51r7fc11558144eb7e1@mail.gmail.com>
References: <1267003757-22456-1-git-send-email-thara@ti.com>
	 <1267003757-22456-10-git-send-email-thara@ti.com>
	 <1267003757-22456-11-git-send-email-thara@ti.com>
	 <1267003757-22456-12-git-send-email-thara@ti.com>
	 <1267003757-22456-13-git-send-email-thara@ti.com>
	 <1267003757-22456-14-git-send-email-thara@ti.com>
	 <1267003757-22456-15-git-send-email-thara@ti.com>
	 <1267003757-22456-16-git-send-email-thara@ti.com>
	 <87ljeap6f6.fsf@deeprootsystems.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB0321CBD2BB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f172.google.com ([209.85.221.172]:39638 "EHLO
	mail-qy0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371Ab0CEP0c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Mar 2010 10:26:32 -0500
Received: by qyk2 with SMTP id 2so824917qyk.1
        for <linux-omap@vger.kernel.org>; Fri, 05 Mar 2010 07:26:32 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0321CBD2BB@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Menon, Nishanth" <nm@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>

Hi Thara,

On Fri, Mar 5, 2010 at 5:22 PM, Gopinath, Thara <thara@ti.com> wrote:
> Will do this as V2

Can you please remove the chunks of text you are not replying to in you=
r mails?

All the following text is just a waste of bandwidth, and time for
people that actually scroll down trying to find further comments. This
is a practice not only you, but other people have started to follow in
this mailing list and it's annoying me a bit.

Cheers.

>>>
>>>> ---
>>>> =C2=A0arch/arm/mach-omap2/voltage.c | =C2=A0149 ++++++++++++++++++=
+++++++++++++++++++++--
>>>> =C2=A0arch/arm/mach-omap2/voltage.h | =C2=A0 =C2=A01 +
>>>> =C2=A0arch/arm/plat-omap/Kconfig =C2=A0 =C2=A0| =C2=A0 19 +++++
>>>> =C2=A03 files changed, 162 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/v=
oltage.c
>>>> index 49167c0..4f325af 100644
>>>> --- a/arch/arm/mach-omap2/voltage.c
>>>> +++ b/arch/arm/mach-omap2/voltage.c
>>>> @@ -29,7 +29,8 @@
>>>> =C2=A0#include "prm-regbits-34xx.h"
>>>> =C2=A0#include "voltage.h"
>>>>
>>>> -#define VP_IDLE_TIMEOUT 200
>>>> +#define VP_IDLE_TIMEOUT =C2=A0 =C2=A0200
>>>> +#define VP_TRANXDONE_TIMEOUT =C2=A0 =C2=A0 =C2=A0 300
>>>>
>>>> =C2=A0/*
>>>> =C2=A0 * OMAP3 Voltage controller SR parameters. TODO: Pass this i=
nfo as part of
>>>> @@ -70,6 +71,7 @@ struct vp_reg_info {
>>>> =C2=A0 =C2=A0 u32 vp_vddmin;
>>>> =C2=A0 =C2=A0 u32 vp_vddmax;
>>>> =C2=A0 =C2=A0 u32 vp_timeout;
>>>> + =C2=A0 u32 vp_tranxdone_status;
>>>> =C2=A0};
>>>> =C2=A0static struct vp_reg_info *vp_reg;
>>>> =C2=A0/*
>>>> @@ -299,6 +301,8 @@ static void __init vp_reg_configure(int vp_id)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OMAP3430_VD=
DMIN_SHIFT);
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 vp_reg[vp_id].vp_vddmax =3D (OMAP3_VP1_VLIMITTO_VDDMAX <<
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OMAP3430_VD=
DMAX_SHIFT);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v=
p_reg[vp_id].vp_tranxdone_status =3D
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OMAP3430_VP1_TRANX=
DONE_ST;
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (vp_id =3D=3D =
VP2) {
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /*
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0* OMAP3430 has error gain varying btw higher and
>>>> @@ -312,6 +316,8 @@ static void __init vp_reg_configure(int vp_id)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OMAP3430_VD=
DMIN_SHIFT);
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 vp_reg[vp_id].vp_vddmax =3D (OMAP3_VP2_VLIMITTO_VDDMAX <<
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OMAP3430_VD=
DMAX_SHIFT);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v=
p_reg[vp_id].vp_tranxdone_status =3D
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OMAP3430_VP2_TRANX=
DONE_ST;
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 pr_warning("Voltage processor%d does not exisit\
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 in OMAP3 \n=
", vp_id);
>>>> @@ -346,6 +352,131 @@ static void __init vp_reg_configure(int vp_i=
d)
>>>> =C2=A0 =C2=A0 /* TODO Extend this for OMAP4 ?? Or need a separate =
file =C2=A0*/
>>>> =C2=A0}
>>>>
>>>> +#ifdef CONFIG_OMAP_VOLT_VPFORCEUPDATE
>>>> +/* VP force update method of voltage scaling */
>>>> +static int vp_forceupdate_scale_voltage(u32 vdd, u8 target_vsel,
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 u8 current_vsel)
>>>> +{
>>>> + =C2=A0 u32 smps_steps =3D 0, smps_delay =3D 0;
>>>> + =C2=A0 u32 vpconfig;
>>>> + =C2=A0 int timeout =3D 0;
>>>> + =C2=A0 int vp_id =3D vdd - 1;
>>>> +
>>>> + =C2=A0 if (!((vdd =3D=3D VDD1_OPP) || (vdd =3D=3D VDD2_OPP))) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_warning("Wrong vdd id pass=
ed to vp forceupdate\n");
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;
>>>> + =C2=A0 }
>>>> +
>>>> + =C2=A0 smps_steps =3D abs(target_vsel - current_vsel);
>>>> +
>>>> + =C2=A0 /* OMAP3430 has errorgain varying btw higher and lower op=
p's */
>>>> + =C2=A0 if (cpu_is_omap34xx()) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vdd =3D=3D VDD1_OPP) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u=
32 vc_cmdval0;
>>>> +
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v=
c_cmdval0 =3D voltage_read_reg(vc_reg.vc_cmdval0_reg);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v=
c_cmdval0 &=3D ~VC_CMD_ON_MASK;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v=
c_cmdval0 |=3D (target_vsel << VC_CMD_ON_SHIFT);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v=
oltage_write_reg(vc_reg.vc_cmdval0_reg, vc_cmdval0);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v=
p_reg[vp_id].vp_errorgain =3D (((get_vdd1_opp() > 2) ?
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (OMAP3_VP_CONFIG_E=
RRORGAIN_HIGHOPP) :
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (OMAP3_VP_CONFIG_E=
RRORGAIN_LOWOPP)) <<
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OMAP3430_ERRORGAIN=
_SHIFT);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (vdd =3D=3D VDD2_OP=
P) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u=
32 vc_cmdval1;
>>>> +
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v=
c_cmdval1 =3D voltage_read_reg(vc_reg.vc_cmdval1_reg);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v=
c_cmdval1 &=3D ~VC_CMD_ON_MASK;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v=
c_cmdval1 |=3D (target_vsel << VC_CMD_ON_SHIFT);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v=
oltage_write_reg(vc_reg.vc_cmdval1_reg, vc_cmdval1);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v=
p_reg[vp_id].vp_errorgain =3D (((get_vdd2_opp() > 2) ?
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (OMAP3_VP_CONFIG_E=
RRORGAIN_HIGHOPP) :
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (OMAP3_VP_CONFIG_E=
RRORGAIN_LOWOPP)) <<
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OMAP3430_ERRORGAIN=
_SHIFT);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>>> + =C2=A0 }
>>>> +
>>>> + =C2=A0 /* Clear all pending TransactionDone interrupt/status. Ty=
pical latency
>>>> + =C2=A0 =C2=A0* is <3us
>>>> + =C2=A0 =C2=A0*/
>>>> + =C2=A0 while (timeout++ < VP_TRANXDONE_TIMEOUT) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 voltage_write_reg(PRM_IRQSTAT=
US_REG,
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 vp_reg[vp_id].vp_tranxdone_status);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(voltage_read_reg(PRM_IR=
QSTATUS_REG) &
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 vp_reg[vp_id].vp_tranxdone_status))
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 break;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 udelay(1);
>>>> + =C2=A0 }
>>>> +
>>>> + =C2=A0 if (timeout >=3D VP_TRANXDONE_TIMEOUT) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_warning("VP%d TRANXDONE ti=
meout exceeded. Voltage change \
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 aborted", vdd);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;
>>>> + =C2=A0 }
>>>> +
>>>> + =C2=A0 /* Configure for VP-Force Update */
>>>> + =C2=A0 vpconfig =3D voltage_read_reg(vp_reg[vp_id].vp_offs.vp_vp=
config_reg);
>>>> + =C2=A0 vpconfig &=3D ~(VP_CONFIG_INITVDD | VP_FORCEUPDATE |
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 V=
P_INITVOLTAGE_MASK | VP_ERRORGAIN_MASK);
>>>> + =C2=A0 vpconfig |=3D ((target_vsel << VP_INITVOLTAGE_SHIFT) |
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v=
p_reg[vp_id].vp_errorgain);
>>>> + =C2=A0 voltage_write_reg(vp_reg[vp_id].vp_offs.vp_vpconfig_reg, =
vpconfig);
>>>> +
>>>> + =C2=A0 /* Trigger initVDD value copy to voltage processor */
>>>> + =C2=A0 vpconfig |=3D VP_CONFIG_INITVDD;
>>>> + =C2=A0 voltage_write_reg(vp_reg[vp_id].vp_offs.vp_vpconfig_reg, =
vpconfig);
>>>> +
>>>> + =C2=A0 /* Force update of voltage */
>>>> + =C2=A0 vpconfig |=3D VP_FORCEUPDATE;
>>>> + =C2=A0 voltage_write_reg(vp_reg[vp_id].vp_offs.vp_vpconfig_reg, =
vpconfig);
>>>> +
>>>> + =C2=A0 timeout =3D 0;
>>>> + =C2=A0 /* Wait for TransactionDone. Typical latency is <200us.
>>>> + =C2=A0 =C2=A0* Depends on SMPSWAITTIMEMIN/MAX and voltage change
>>>> + =C2=A0 =C2=A0*/
>>>
>>>multi-line comment style
>>>
>>>> + =C2=A0 while ((timeout++ < VP_TRANXDONE_TIMEOUT) &&
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (=
!(voltage_read_reg(PRM_IRQSTATUS_REG) &
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v=
p_reg[vp_id].vp_tranxdone_status)))
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 udelay(1);
>>>> +
>>>> + =C2=A0 if (timeout >=3D VP_TRANXDONE_TIMEOUT)
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_warning("VP%d TRANXDONE ti=
meout exceeded. TRANXDONE never \
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g=
ot set after the voltage update.Serious error!!!!\n",
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v=
dd);
>>>> +
>>>> + =C2=A0 /* Wait for voltage to settle with SW wait-loop */
>>>> + =C2=A0 smps_delay =3D ((smps_steps * 125) / 40) + 2;
>>>> + =C2=A0 udelay(smps_delay);
>>>> +
>>>> + =C2=A0 /* Disable TransactionDone interrupt , clear all status, =
clear
>>>> + =C2=A0 =C2=A0* control registers
>>>> + =C2=A0 =C2=A0*/
>>>
>>>muti-line comment
>>>
>>>> + =C2=A0 timeout =3D 0;
>>>> + =C2=A0 while (timeout++ < VP_TRANXDONE_TIMEOUT) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 voltage_write_reg(PRM_IRQSTAT=
US_REG,
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 vp_reg[vp_id].vp_tranxdone_status);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(voltage_read_reg(PRM_IR=
QSTATUS_REG) &
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 vp_reg[vp_id].vp_tranxdone_status))
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 break;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 udelay(1);
>>>> + =C2=A0 }
>>>> + =C2=A0 if (timeout >=3D VP_TRANXDONE_TIMEOUT)
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_warning("VP%d TRANXDONE ti=
meout exceeded while trying to \
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c=
lear the TRANXDONE status\n", vdd);
>>>> +
>>>> + =C2=A0 vpconfig =3D voltage_read_reg(vp_reg[vp_id].vp_offs.vp_vp=
config_reg);
>>>> + =C2=A0 /* Clear initVDD copy trigger bit */
>>>> + =C2=A0 vpconfig &=3D ~VP_CONFIG_INITVDD;
>>>> + =C2=A0 voltage_write_reg(vp_reg[vp_id].vp_offs.vp_vpconfig_reg, =
vpconfig);
>>>> + =C2=A0 /* Clear force bit */
>>>> + =C2=A0 vpconfig &=3D ~VP_FORCEUPDATE;
>>>> + =C2=A0 voltage_write_reg(vp_reg[vp_id].vp_offs.vp_vpconfig_reg, =
vpconfig);
>>>> +
>>>> + =C2=A0 return true;
>>>> +}
>>>> +#endif
>>>> +
>>>> +#ifdef CONFIG_OMAP_VOLT_VCBYPASS
>>>> =C2=A0/**
>>>> =C2=A0 * vc_bypass_scale_voltage - VC bypass method of voltage sca=
ling
>>>> =C2=A0 */
>>>> @@ -437,7 +568,7 @@ static int vc_bypass_scale_voltage(u32 vdd, u8=
 target_vsel, u8 current_vsel)
>>>> =C2=A0 =C2=A0 udelay(smps_delay);
>>>> =C2=A0 =C2=A0 return true;
>>>> =C2=A0}
>>>> -
>>>> +#endif
>>>>
>>>> =C2=A0static void __init init_voltageprocessors(void)
>>>> =C2=A0{
>>>> @@ -474,13 +605,16 @@ void omap_voltageprocessor_enable(int vp_id)
>>>> =C2=A0 =C2=A0 if (voltage_read_reg(vp_reg[vp_id - 1].vp_offs.vp_vp=
config_reg) &
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VP_CONFIG_VPENABLE)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>>>> +
>>>> +#ifdef CONFIG_OMAP_VOLT_VCBYPASS
>>>> =C2=A0 =C2=A0 /*
>>>> =C2=A0 =C2=A0 =C2=A0* This latching is required only if VC bypass =
method is used for
>>>> =C2=A0 =C2=A0 =C2=A0* voltage scaling during dvfs.
>>>> =C2=A0 =C2=A0 =C2=A0*/
>>>> =C2=A0 =C2=A0 vp_latch_vsel(vp_id - 1);
>>>> - =C2=A0 vpconfig =3D voltage_read_reg(vp_reg[vp_id - 1].vp_offs.v=
p_vpconfig_reg);
>>>> +#endif
>>>> =C2=A0 =C2=A0 /* Enable VP */
>>>> + =C2=A0 vpconfig =3D voltage_read_reg(vp_reg[vp_id - 1].vp_offs.v=
p_vpconfig_reg);
>>>> =C2=A0 =C2=A0 voltage_write_reg(vp_reg[vp_id - 1].vp_offs.vp_vpcon=
fig_reg,
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vpconfig | VP_CONFIG_VPENABLE);
>>>> =C2=A0}
>>>> @@ -529,11 +663,12 @@ void omap_voltageprocessor_disable(int vp_id=
)
>>>> =C2=A0 * for a particular voltage domain during dvfs or any other =
situation.
>>>> =C2=A0 */
>>>> =C2=A0int omap_voltage_scale(int vdd, u8 target_vsel, u8 current_v=
sel)
>>>> -{ =C2=A0/*
>>>> - =C2=A0 =C2=A0* TODO add VP force update method of voltage scalin=
g
>>>> - =C2=A0 =C2=A0* and choose btw the two
>>>> - =C2=A0 =C2=A0*/
>>>> +{
>>>> +#ifdef CONFIG_OMAP_VOLT_VCBYPASS
>>>> =C2=A0 =C2=A0 return vc_bypass_scale_voltage(vdd, target_vsel, cur=
rent_vsel);
>>>> +#elif CONFIG_OMAP_VOLT_VPFORCEUPDATE
>>>> + =C2=A0 return vp_forceupdate_scale_voltage(vdd, target_vsel, cur=
rent_vsel);
>>>> +#endif
>>>> =C2=A0}
>>>>
>>>> =C2=A0/**
>>>> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/v=
oltage.h
>>>> index c3203c9..615bde6 100644
>>>> --- a/arch/arm/mach-omap2/voltage.h
>>>> +++ b/arch/arm/mach-omap2/voltage.h
>>>> @@ -17,6 +17,7 @@
>>>> =C2=A0extern int get_vdd1_opp(void);
>>>> =C2=A0extern int get_vdd2_opp(void);
>>>>
>>>> +#define PRM_IRQSTATUS_REG =C2=A0OMAP3430_PRM_IRQSTATUS_MPU
>>>> =C2=A0/* Generic VP definitions. Need to be redefined for OMAP4 */
>>>> =C2=A0#define VP_CONFIG_TIMEOUTEN =C2=A0 =C2=A0 =C2=A0 =C2=A0OMAP3=
430_TIMEOUTEN
>>>> =C2=A0#define VP_CONFIG_INITVDD =C2=A0OMAP3430_INITVDD
>>>> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconf=
ig
>>>> index 9d286e6..1a611a9 100644
>>>> --- a/arch/arm/plat-omap/Kconfig
>>>> +++ b/arch/arm/plat-omap/Kconfig
>>>> @@ -92,6 +92,25 @@ config OMAP_SMARTREFLEX_TESTING
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 WARNING: Enabling this option may cause your =
device to hang!
>>>>
>>>> +choice
>>>> + =C2=A0 prompt "Choose Voltage Scale method"
>>>> + =C2=A0 depends on ARCH_OMAP3 && PM
>>>> + =C2=A0 default OMAP_VOLT_VPFORCEUPDATE
>>>> +
>>>> +config OMAP_VOLT_VPFORCEUPDATE
>>>> + =C2=A0 bool "Voltage scaling via VP force update method"
>>>> + =C2=A0 help
>>>> + =C2=A0 =C2=A0Say Y if you want to enable VP force update method
>>>> + =C2=A0 =C2=A0of voltage scaling. This is the h/w recomended way
>>>> + =C2=A0 =C2=A0of voltage scaling in OMAP3.
>>>> +
>>>> +config OMAP_VOLT_VCBYPASS
>>>> + =C2=A0 bool "Voltage Scale via Voltage controller in bypass"
>>>> + =C2=A0 help
>>>> + =C2=A0 =C2=A0Say Y if you want to enable VC Bypass method of vol=
tage scaling.
>>>> + =C2=A0 =C2=A0Not the default recommended method.
>>>> +endchoice
>>>> +
>>>> =C2=A0config OMAP_RESET_CLOCKS
>>>> =C2=A0 =C2=A0 bool "Reset unused clocks during boot"
>>>> =C2=A0 =C2=A0 depends on ARCH_OMAP
>>>> --
>>>> 1.7.0.rc1.33.g07cf0f
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>



--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
