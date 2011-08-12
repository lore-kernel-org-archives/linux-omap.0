From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH 2/5 v4] arm: omap: usb: ehci and ohci hwmod structures for omap3
Date: Fri, 12 Aug 2011 13:42:32 +0530
Message-ID: <CAP05o4KNWo2B8opzhUVrxJ+SFe-b0iuVuduwxtKwdX-usU2Arg@mail.gmail.com>
References: <1312899309-24067-1-git-send-email-keshava_mgowda@ti.com>
	<1312899309-24067-2-git-send-email-keshava_mgowda@ti.com>
	<1312899309-24067-3-git-send-email-keshava_mgowda@ti.com>
	<CACVXFVMqwzSOSvkq4q6GnR2gso8NuQD4DRumAVesQB=P_8yDaQ@mail.gmail.com>
	<CAP05o4JDz_53k73-yUXn4S3hFNZ=ccEhaee-U53M+M6qm41Y=A@mail.gmail.com>
	<CACVXFVPN0dS0P4rdvAhKKaTr1yuHRE_KbMiL-1PivObt9aGLhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:39947 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750932Ab1HLIMm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Aug 2011 04:12:42 -0400
In-Reply-To: <CACVXFVPN0dS0P4rdvAhKKaTr1yuHRE_KbMiL-1PivObt9aGLhw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, tony@atomide.com, khilman@ti.com, b-cousson@ti.com, paul@pwsan.com, johnstul@us.ibm.com, vishwanath.bs@ti.com

On Fri, Aug 12, 2011 at 12:55 PM, Ming Lei <tom.leiming@gmail.com> wrot=
e:
> On Fri, Aug 12, 2011 at 1:46 PM, Munegowda, Keshava
> <keshava_mgowda@ti.com> wrote:
>> On Thu, Aug 11, 2011 at 8:53 PM, Ming Lei <tom.leiming@gmail.com> wr=
ote:
>
>>>> +static struct omap_hwmod_class_sysconfig omap34xx_usb_host_hs_sys=
c =3D {
>>>> + =A0 =A0 =A0 .rev_offs =A0 =A0 =A0 =3D 0x0000,
>>>> + =A0 =A0 =A0 .sysc_offs =A0 =A0 =A0=3D 0x0010,
>>>> + =A0 =A0 =A0 .syss_offs =A0 =A0 =A0=3D 0x0014,
>>>> + =A0 =A0 =A0 .sysc_flags =A0 =A0 =3D (SYSC_HAS_MIDLEMODE | SYSC_H=
AS_SIDLEMODE),
>>>
>>> SYSC_HAS_ENAWAKEUP is missed or not needed?
>>
>> not needed. wakeup will through irq-chaining mechanism.
>
> I am wondering how irq-chaining mechanism can wakeup MPU, could you
> describe it in a little detail?
>
> In fact, I have tested usb remote wakeup on rc1 plus your patches on =
beagle
> xm, seems the usb mouse can't wakeup MPU at all.
>
>>>
>>>> + =A0 =A0 =A0 .idlemodes =A0 =A0 =A0=3D (SIDLE_FORCE | SIDLE_NO | =
SIDLE_SMART |
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MSTANDBY_FORC=
E | MSTANDBY_NO | MSTANDBY_SMART),
>>>> + =A0 =A0 =A0 .sysc_fields =A0 =A0=3D &omap_hwmod_sysc_type1,
>>>> +};
>>>> +
>>>> +static struct omap_hwmod_class omap34xx_usb_host_hs_hwmod_class =3D=
 {
>>>> + =A0 =A0 =A0 .name =3D "usbhs_uhh",
>>>> + =A0 =A0 =A0 .sysc =3D &omap34xx_usb_host_hs_sysc,
>>>> +};
>>>> +
>>>> +static struct omap_hwmod_ocp_if *omap34xx_usb_host_hs_masters[] =3D=
 {
>>>> + =A0 =A0 =A0 &omap34xx_usb_host_hs__l3_main_2,
>>>> +};
>>>> +
>>>> +static struct omap_hwmod_addr_space omap34xx_usb_host_hs_addrs[] =
=3D {
>>>> + =A0 =A0 =A0 {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "uhh",
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x48064000=
,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x480643=
ff,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_T=
YPE_RT
>>>> + =A0 =A0 =A0 },
>>>> + =A0 =A0 =A0 {} /* Terminating Entry */
>>>> +};
>>>> +
>>>> +static struct omap_hwmod_ocp_if omap34xx_l4_cfg__usb_host_hs =3D =
{
>>>> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap3xxx_l4_core_hwmod,
>>>> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap34xx_usb_host_hs_=
hwmod,
>>>> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_ick",
>>>> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap34xx_usb_host_hs_a=
ddrs,
>>>> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USE=
R_SDMA,
>>>> +};
>>>
>>> Even USBHOST_L4_ICLK is used only by USBHOST_SICLK, it is better to
>>> define a "usbhost_siclk" clk for consistence with TRM.
>>
>> I dint understand, what is the change you are suggesting?
>
> From 23.2.1 of OMAP35x TRM(Rev. M), USBHOST_SICLK inside
> 'High-speed USB Host controller' is driven by L4 slave interface
> clock, so looks like l4 iclk should be parent of USBHOST_SICLK.
>
> Considered =A0USBHOST_L4_ICLK is used only by USBHOST_SICLK,
> you may ignore my question about it.
>
> thanks,
> --
> Ming Lei

Thanks Ming Lei

keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
