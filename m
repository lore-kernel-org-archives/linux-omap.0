From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: Re: [PATCH 3/6] ARM: OMAP4: hwmod data: add mmu hwmod for ipu and dsp
Date: Tue, 19 Jun 2012 11:39:22 -0500
Message-ID: <CALLhW=67d7=4Jx1T4Kn5ddNz7vQ5YeN4AzuOuXrW1_UGYwpG2A@mail.gmail.com>
References: <1339811764-5337-1-git-send-email-omar.luna@linaro.org>
	<1339811764-5337-4-git-send-email-omar.luna@linaro.org>
	<4FE07268.7040606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:52186 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569Ab2FSQjX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jun 2012 12:39:23 -0400
Received: by vcbf11 with SMTP id f11so3338660vcb.19
        for <linux-omap@vger.kernel.org>; Tue, 19 Jun 2012 09:39:22 -0700 (PDT)
In-Reply-To: <4FE07268.7040606@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Ohad Ben-Cohen <ohad@wizery.com>, Joerg Roedel <joerg.roedel@amd.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org

Hi Benoit,

On 19 June 2012 07:36, Cousson, Benoit <b-cousson@ti.com> wrote:
> On 6/16/2012 3:56 AM, Omar Ramirez Luna wrote:
=2E..
>> +static struct omap_hwmod omap44xx_ipu_mmu_hwmod =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "ipu_mmu",
>> + =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap44xx_mmu_hwmod_class,
>> + =A0 =A0 .clkdm_name =A0 =A0 =3D "ducati_clkdm",
>> + =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_ipu_mmu_irqs,
>> + =A0 =A0 .rst_lines =A0 =A0 =A0=3D omap44xx_ipu_mmu_resets,
>> + =A0 =A0 .rst_lines_cnt =A0=3D ARRAY_SIZE(omap44xx_ipu_mmu_resets),
>> + =A0 =A0 .main_clk =A0 =A0 =A0 =3D "ipu_fck",
>> + =A0 =A0 .prcm =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .omap4 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_offs =3D OMAP4_CM=
_DUCATI_DUCATI_CLKCTRL_OFFSET,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .rstctrl_offs =3D OMAP4_RM=
_DUCATI_RSTCTRL_OFFSET,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .context_offs =3D OMAP4_RM=
_DUCATI_DUCATI_CONTEXT_OFFSET,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .modulemode =A0 =3D MODULE=
MODE_HWCTRL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 },
>> + =A0 =A0 .dev_attr =A0 =A0 =A0 =3D &ipu_mmu_dev_attr,
>> +};
>
> In fact, the MMU_IPU hwmod is now almost the same one than the previo=
us IPU one...
> If we do that we should maybe just rename the IPU -> MMU_IPU and DSP =
-> MMU_DSP.
>
> But by doing that we will assume that the MMU does represent the subs=
ystem, which is not necessarily super nice.
>
> I guess that a much better representation will be to keep the subsyst=
em (IPU) to handle the PRCM part:
>
> + =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "ipu_fck",
> + =A0 =A0 =A0 .prcm =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_offs =3D OMAP4_CM_DUCATI_DUCAT=
I_CLKCTRL_OFFSET,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .rstctrl_offs =3D OMAP4_RM_DUCATI_RSTCT=
RL_OFFSET,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .context_offs =3D OMAP4_RM_DUCATI_DUCAT=
I_CONTEXT_OFFSET,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .modulemode =A0 =3D MODULEMODE_HWCTRL,
>
> And then the MMU_IPU will handle the configuration registers part and=
 the reset + irq.
>
> But then, you will have to create a parent child dependency between y=
our devices to ensure that the IPU subsystem device will be enabled bef=
ore trying to access the MMU_IPU.
>
> This is what the DSS is about to do to handle the same kind of power =
dependency. The DSS device is the parent of all the DSS IPs (DISPC, HDM=
I...) and thus pm_runtime will ensure that the parent is enabled before=
 trying to enable the children.
>
> In term of DT, just to illustrate the situation, it will be something=
 like that:
>
> ipu {
> =A0 =A0 =A0 =A0compatible =3D "simple-bus";
> =A0 =A0 =A0 =A0ti,hwmods =3D "ipu";
>
> =A0 =A0 =A0 =A0ipu_mmu: mmu@4a066000 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "omap-mmu";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ti,hwmods =3D "mmu_ipu";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg...;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0irqs...;
> =A0 =A0 =A0 =A0}
> }
>
> Is it something you can handle with your current framework?

I agree it would be nice only IPU managed the prcm, however we can't
do that right now because hwmod expects the IP block to be out of
reset to continue the _enable sequence. On IPU both reset lines are
asserted at that point and hence _are_any_hardreset_lines_asserted
check will bail out, and ipu resets can't be lifted without a
configured iommu otherwise it might execute random garbage.

So, for IPU and DSP the mmu must be deasserted and configured before
the processor reset line (which is more like a parking brake) is
deasserted, and the latter should be made before _enable is called so
it can fully execute the enable sequence.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
