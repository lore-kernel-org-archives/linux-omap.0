From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH 2/5 v13] arm: omap: usb: ehci and ohci hwmod structures
 for omap3
Date: Fri, 7 Oct 2011 13:13:15 +0530
Message-ID: <CAP05o4Kfo2fjkaSmhu1wERN4BsznMo3EFe9VMLm9gVA9iXcBzg@mail.gmail.com>
References: <1317901123-2546-1-git-send-email-keshava_mgowda@ti.com>
	<alpine.DEB.2.00.1110061030490.4611@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1110061030490.4611@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, khilman@ti.com, b-cousson@ti.com, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, tony@atomide.com, johnstul@us.ibm.com, vishwanath.bs@ti.com
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 6, 2011 at 10:05 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi Keshava,
>
> On Thu, 6 Oct 2011, Keshava Munegowda wrote:
>
>> Following 2 hwmod structures are added
>> =A0 =A0 1. usb_host_hs
>> =A0 =A0 =A0 =A0 =A0The hwmod of usbhs with uhh, ehci and ohci base a=
ddresses
>> =A0 =A0 =A0 =A0 =A0functional clock and ehci, ohci irqs
>>
>> =A0 =A0 2. usb_tll_hs
>> =A0 =A0 =A0 =A0 =A0 hwmod of usbhs with the TLL base address and irq=
=2E
>>
>> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
>> Reviewed-by: Partha Basak <parthab@india.ti.com>
>> ---
>> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0227 +++++++++++++=
+++++++++++++++
>> =A01 files changed, 227 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/m=
ach-omap2/omap_hwmod_3xxx_data.c
>> index 59fdb9f..b8ca690 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> @@ -84,6 +84,8 @@ static struct omap_hwmod omap3xxx_mcbsp4_hwmod;
>
> ...
>
>> +static struct omap_hwmod_ocp_if omap34xx_usb_host_hs__ick =3D {
>> + =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap3xxx_l4_core_hwmod,
>> + =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap34xx_usb_host_hs_hwmod,
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "usbhost_ick",
>> + =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap34xx_usb_host_hs_addrs,
>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_SDMA=
,
>> +/*
>> + * This clock should be on/off only with main clock; If auto idle i=
s set,
>> + * the usbhs controller prevents the omap to enter in to low power =
mode,
>> + * hence don't use auto idle here.
>> + */
>> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D OCPIF_SWSUP_IDLE,
>
> This is still unclear to me. =A0Doesn't this interface clock support
> interface clock auto-idle? =A0If so, then when the UHH's target port =
is
> forced idle and its initiator port is forced to standby, then shouldn=
't
> the PRCM automatically idle this interface clock?

Thanks paul;
Now I am seeing that  without  OCPIF_SWSUP_IDLE the system is going to
low power mode but after
adding HWMOD_INIT_NO_RESET flag ;  After adding this flag; I dint
check the system without this flag;
so, PRCM automatically idle this interface clock if UHH target port is
forced idle and force standby.
I can remove it now.  :-)

> Or is there some hardware problem where the PRCM won't auto-idle this
> clock when the UHH is in idle + standby?
>
>> +};
>> +
>
> ...
>
>> +static struct omap_hwmod_ocp_if omap34xx_ick_cfg__usb_tll_hs =3D {
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "usbtll_ick",
>> + =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap34xx_usb_tll_hs_addrs,
>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_SDMA=
,
>> +/*
>> + * This clock should be on/off only with main clock; If auto idle i=
s set,
>> + * the usbhs controller prevents the omap to enter in to low power =
mode,
>> + * hence don't use auto idle here.
>> + */
>> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D OCPIF_SWSUP_IDLE,
>
> Same comment here, with the exception of the part about standby since=
 the
> TLL doesn't have an initiator port.

I will remove this also;

regards
keshava
