From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: Re: [PATCH 3/6] ARM: OMAP4: hwmod data: add mmu hwmod for ipu and dsp
Date: Wed, 27 Jun 2012 20:27:28 -0500
Message-ID: <CALLhW=4rnUFVciYe8OD+HaUr21qWy+8viJru3VKg1QEgXxofAQ@mail.gmail.com>
References: <1339811764-5337-1-git-send-email-omar.luna@linaro.org>
	<1339811764-5337-4-git-send-email-omar.luna@linaro.org>
	<4FE07268.7040606@ti.com>
	<CALLhW=67d7=4Jx1T4Kn5ddNz7vQ5YeN4AzuOuXrW1_UGYwpG2A@mail.gmail.com>
	<4FE0BB57.3080403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:44814 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754852Ab2F1B13 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 21:27:29 -0400
Received: by vcbf11 with SMTP id f11so1177445vcb.19
        for <linux-omap@vger.kernel.org>; Wed, 27 Jun 2012 18:27:29 -0700 (PDT)
In-Reply-To: <4FE0BB57.3080403@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Ohad Ben-Cohen <ohad@wizery.com>, Joerg Roedel <joerg.roedel@amd.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org

+ Paul

On 19 June 2012 12:48, Cousson, Benoit <b-cousson@ti.com> wrote:
> On 6/19/2012 6:39 PM, Omar Ramirez Luna wrote:
>>
>> Hi Benoit,
>>
>> On 19 June 2012 07:36, Cousson, Benoit <b-cousson@ti.com> wrote:
>>>
>>> On 6/16/2012 3:56 AM, Omar Ramirez Luna wrote:
>>
>> ...
>>>>
>>>> +static struct omap_hwmod omap44xx_ipu_mmu_hwmod =3D {
>>>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "ipu_mmu",
>>>> + =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap44xx_mmu_hwmod_class,
>>>> + =A0 =A0 .clkdm_name =A0 =A0 =3D "ducati_clkdm",
>>>> + =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_ipu_mmu_irqs,
>>>> + =A0 =A0 .rst_lines =A0 =A0 =A0=3D omap44xx_ipu_mmu_resets,
>>>> + =A0 =A0 .rst_lines_cnt =A0=3D ARRAY_SIZE(omap44xx_ipu_mmu_resets=
),
>>>> + =A0 =A0 .main_clk =A0 =A0 =A0 =3D "ipu_fck",
>>>> + =A0 =A0 .prcm =3D {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 .omap4 =3D {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_offs =3D
>>>> OMAP4_CM_DUCATI_DUCATI_CLKCTRL_OFFSET,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .rstctrl_offs =3D OMAP4_=
RM_DUCATI_RSTCTRL_OFFSET,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .context_offs =3D
>>>> OMAP4_RM_DUCATI_DUCATI_CONTEXT_OFFSET,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .modulemode =A0 =3D MODU=
LEMODE_HWCTRL,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>>>> + =A0 =A0 },
>>>> + =A0 =A0 .dev_attr =A0 =A0 =A0 =3D &ipu_mmu_dev_attr,
>>>> +};
>>>
>>>
>>> In fact, the MMU_IPU hwmod is now almost the same one than the prev=
ious
>>> IPU one...
>>> If we do that we should maybe just rename the IPU -> MMU_IPU and DS=
P ->
>>> MMU_DSP.
>>>
>>> But by doing that we will assume that the MMU does represent the
>>> subsystem, which is not necessarily super nice.
>>>
>>> I guess that a much better representation will be to keep the subsy=
stem
>>> (IPU) to handle the PRCM part:
>>>
>>> + =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "ipu_fck",
>>> + =A0 =A0 =A0 .prcm =3D {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_offs =3D OMAP4_CM_DUCATI_DUC=
ATI_CLKCTRL_OFFSET,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .rstctrl_offs =3D OMAP4_RM_DUCATI_RST=
CTRL_OFFSET,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .context_offs =3D OMAP4_RM_DUCATI_DUC=
ATI_CONTEXT_OFFSET,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .modulemode =A0 =3D MODULEMODE_HWCTRL=
,
>>>
>>> And then the MMU_IPU will handle the configuration registers part a=
nd the
>>> reset + irq.
>>>
>>> But then, you will have to create a parent child dependency between=
 your
>>> devices to ensure that the IPU subsystem device will be enabled bef=
ore
>>> trying to access the MMU_IPU.
>>>
>>> This is what the DSS is about to do to handle the same kind of powe=
r
>>> dependency. The DSS device is the parent of all the DSS IPs (DISPC,=
 HDMI...)
>>> and thus pm_runtime will ensure that the parent is enabled before t=
rying to
>>> enable the children.
>>>
>>> In term of DT, just to illustrate the situation, it will be somethi=
ng
>>> like that:
>>>
>>> ipu {
>>> =A0 =A0 =A0 =A0compatible =3D "simple-bus";
>>> =A0 =A0 =A0 =A0ti,hwmods =3D "ipu";
>>>
>>> =A0 =A0 =A0 =A0ipu_mmu: mmu@4a066000 {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "omap-mmu";
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ti,hwmods =3D "mmu_ipu";
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg...;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0irqs...;
>>> =A0 =A0 =A0 =A0}
>>> }
>>>
>>> Is it something you can handle with your current framework?
>>
>>
>> I agree it would be nice only IPU managed the prcm, however we can't
>> do that right now because hwmod expects the IP block to be out of
>> reset to continue the _enable sequence. On IPU both reset lines are
>> asserted at that point and hence _are_any_hardreset_lines_asserted
>> check will bail out, and ipu resets can't be lifted without a
>> configured iommu otherwise it might execute random garbage.
>
>
> That's a good point, but like Paul said, the hard reset was removed o=
utside
> of the fmwk due to the lack of understanding about the real usage / n=
eed for
> it.
>
> If we do have a better understanding, we might add some more support =
in the
> fmwk or at least improve it.
>
> I'm now realizing that aborting the init if some reset lines are asse=
rted is
> not what we want to do for the IPU SS hwmod that will contain the IPU
> (processor) reset control.
> In fact the previous approach with a fake hwmod for the ipu_c0 proces=
sor
> would have been avoided that issue.
>
> If we do not want to go back with that, we should clearly revise the
> _are_any_hardreset_lines_asserted approach and not prevent the init i=
n such
> case since it will prevent all the subsystem to start properly.
>
>
>> So, for IPU and DSP the mmu must be deasserted and configured before
>> the processor reset line (which is more like a parking brake) is
>> deasserted, and the latter should be made before _enable is called s=
o
>> it can fully execute the enable sequence.
>
>
> Yep, so we have to change the way it is handled today.
>
>
> Paul,
>
> If we consider that the reset lines are stored in the subsystem hwmod=
 (IPU,
> DSP or IVA), we cannot prevent the init phase because some line are
> asserted. Otherwise we will never allow the MMU or processor to be en=
abled
> later.
> We might have to remove that check, maybe based on flag if we want to=
 keep
> that functionality or do an explicit reset control like we use to do.
>
> What do you think?

I was waiting for some comments then I realized Paul wasn't actually
in the list of recipients for this email.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
