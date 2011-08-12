From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH 2/5 v4] arm: omap: usb: ehci and ohci hwmod structures for omap3
Date: Fri, 12 Aug 2011 15:25:20 +0800
Message-ID: <CACVXFVPN0dS0P4rdvAhKKaTr1yuHRE_KbMiL-1PivObt9aGLhw@mail.gmail.com>
References: <1312899309-24067-1-git-send-email-keshava_mgowda@ti.com>
	<1312899309-24067-2-git-send-email-keshava_mgowda@ti.com>
	<1312899309-24067-3-git-send-email-keshava_mgowda@ti.com>
	<CACVXFVMqwzSOSvkq4q6GnR2gso8NuQD4DRumAVesQB=P_8yDaQ@mail.gmail.com>
	<CAP05o4JDz_53k73-yUXn4S3hFNZ=ccEhaee-U53M+M6qm41Y=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAP05o4JDz_53k73-yUXn4S3hFNZ=ccEhaee-U53M+M6qm41Y=A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, tony@atomide.com, khilman@ti.com, b-cousson@ti.com, paul@pwsan.com, johnstul@us.ibm.com, vishwanath.bs@ti.com
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 12, 2011 at 1:46 PM, Munegowda, Keshava
<keshava_mgowda@ti.com> wrote:
> On Thu, Aug 11, 2011 at 8:53 PM, Ming Lei <tom.leiming@gmail.com> wro=
te:

>>> +static struct omap_hwmod_class_sysconfig omap34xx_usb_host_hs_sysc=
 =3D {
>>> + =A0 =A0 =A0 .rev_offs =A0 =A0 =A0 =3D 0x0000,
>>> + =A0 =A0 =A0 .sysc_offs =A0 =A0 =A0=3D 0x0010,
>>> + =A0 =A0 =A0 .syss_offs =A0 =A0 =A0=3D 0x0014,
>>> + =A0 =A0 =A0 .sysc_flags =A0 =A0 =3D (SYSC_HAS_MIDLEMODE | SYSC_HA=
S_SIDLEMODE),
>>
>> SYSC_HAS_ENAWAKEUP is missed or not needed?
>
> not needed. wakeup will through irq-chaining mechanism.

I am wondering how irq-chaining mechanism can wakeup MPU, could you
describe it in a little detail?

In fact, I have tested usb remote wakeup on rc1 plus your patches on be=
agle
xm, seems the usb mouse can't wakeup MPU at all.

>>
>>> + =A0 =A0 =A0 .idlemodes =A0 =A0 =A0=3D (SIDLE_FORCE | SIDLE_NO | S=
IDLE_SMART |
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MSTANDBY_FORCE=
 | MSTANDBY_NO | MSTANDBY_SMART),
>>> + =A0 =A0 =A0 .sysc_fields =A0 =A0=3D &omap_hwmod_sysc_type1,
>>> +};
>>> +
>>> +static struct omap_hwmod_class omap34xx_usb_host_hs_hwmod_class =3D=
 {
>>> + =A0 =A0 =A0 .name =3D "usbhs_uhh",
>>> + =A0 =A0 =A0 .sysc =3D &omap34xx_usb_host_hs_sysc,
>>> +};
>>> +
>>> +static struct omap_hwmod_ocp_if *omap34xx_usb_host_hs_masters[] =3D=
 {
>>> + =A0 =A0 =A0 &omap34xx_usb_host_hs__l3_main_2,
>>> +};
>>> +
>>> +static struct omap_hwmod_addr_space omap34xx_usb_host_hs_addrs[] =3D=
 {
>>> + =A0 =A0 =A0 {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "uhh",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x48064000,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x480643f=
f,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TY=
PE_RT
>>> + =A0 =A0 =A0 },
>>> + =A0 =A0 =A0 {} /* Terminating Entry */
>>> +};
>>> +
>>> +static struct omap_hwmod_ocp_if omap34xx_l4_cfg__usb_host_hs =3D {
>>> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap3xxx_l4_core_hwmod,
>>> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap34xx_usb_host_hs_h=
wmod,
>>> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_ick",
>>> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap34xx_usb_host_hs_ad=
drs,
>>> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER=
_SDMA,
>>> +};
>>
>> Even USBHOST_L4_ICLK is used only by USBHOST_SICLK, it is better to
>> define a "usbhost_siclk" clk for consistence with TRM.
>
> I dint understand, what is the change you are suggesting?

=46rom 23.2.1 of OMAP35x TRM(Rev. M), USBHOST_SICLK inside
'High-speed USB Host controller' is driven by L4 slave interface
clock, so looks like l4 iclk should be parent of USBHOST_SICLK.

Considered  USBHOST_L4_ICLK is used only by USBHOST_SICLK,
you may ignore my question about it.

thanks,
--=20
Ming Lei
