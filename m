From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v4 1/4] OMAP3: hwmod data: add mmu data for iva and isp
Date: Fri, 23 Dec 2011 09:53:58 -0600
Message-ID: <CAB-zwWhNNW1GEYr019xecuZTYhR55HpNGrhGjJdE1CEAfFSriQ@mail.gmail.com>
References: <1323922709-6986-1-git-send-email-omar.ramirez@ti.com>
	<1323922709-6986-2-git-send-email-omar.ramirez@ti.com>
	<CAMP44s2WFghH4qPKuwSQJFaoLEmfAtcHB3DRZwNYe4zXTQexfQ@mail.gmail.com>
	<CAB-zwWiTHD38s6Mz_xfxhxBqYph1ctTmhU5dntnp4zHsUwJtHA@mail.gmail.com>
	<CAMP44s2H7v6dRPXO6eBBNrYAnym_ZLdmKcAQPmYyCC6Wo5qOmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:35160 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752779Ab1LWPyB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Dec 2011 10:54:01 -0500
In-Reply-To: <CAMP44s2H7v6dRPXO6eBBNrYAnym_ZLdmKcAQPmYyCC6Wo5qOmw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Russell King <linux@arm.linux.org.uk>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, iommu@lists.linux-foundation.org, MyungJoo Ham <myungjoo.ham@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Dec 19, 2011 at 10:11 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Fri, Dec 16, 2011 at 4:01 AM, Ramirez Luna, Omar <omar.ramirez@ti.=
com> wrote:
>> On Thu, Dec 15, 2011 at 6:39 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> Are you sure you are not missing something like:
>>>
>>> =A0.clk =3D "cam_ick",
>>
>> I believe in this case cam_ick is used as the main clock as it
>> supplies both functional and interface.
>
> Are you sure?

As sure as 4.7.4.1.7 CAM Power Domain ;), if someone else could
clarify would be great to avoid the "are you sure" discussion.

>>>> +/* isp mmu slave ports */
>>>> +static struct omap_hwmod_ocp_if *omap3xxx_isp_mmu_slaves[] =3D {
>>>> + =A0 =A0 =A0 &omap3xxx_l4_core__isp_mmu,
>>>> +};
>>>> +
>>>> +static struct omap_hwmod omap3xxx_isp_mmu_hwmod =3D {
>>>> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "isp_mmu",
>>>> + =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap3xxx_mmu_hwmod_cl=
ass,
>>>> + =A0 =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap3xxx_isp_mmu_irqs,
>>>> + =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "cam_ick",
>>>
>>> It's not "cam_fck"?
>>
>> AFAIK cam_fck doesn't exist in the code, and CAM_L3_ICK is used as
>> both ick/fck according to TRM.
>
> Then maybe the code is wrong.
>
> Look at the OMAP34xx documentation, it says that:
>
> CAM_L3_ICLK -> CAM_FCLK
> CAM_L4_ICLK -> CAM_ICLK
> CAM_MCLK -> CAM_MCLK
> CSI2_96M_FCLK -> CSI2_96M_FCLK
>
> CAM_FCLK
> Functional clock (L3 interconnect clock domain)
> Functional clock domain.
>
> CAM_ICLK
> Interface clock (L4 interconnect clock domain)
> Interface clock domain.

"The camera subsystem interface is clocked with the L3 and L4 clocks
(CAM_L3_ICLK and CAM_L4_ICLK, respectively). CAM_L3_ICLK is also used
as the main functional clock. The functional clock (CAM_MCLK) is
provided by DPLL4 to supply the external sensor."

Either CAM subsystem section or PRCM - CAM PWRDM is ambiguous or wrong.

=2E..
>
> Looks like the driver is manually calling clk_get() and clk_put() for
> the "i3_ick", where I guess the clock framework is supposed to do
> that... It's almost as if somebody forgot a dependency somewhere.

Would be good to clarify the intentions to keep the code as it is.

>>>> + =A0 =A0 =A0 .dev_attr =A0 =A0 =A0 =3D &isp_mmu_dev_attr,
>>>> + =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap3xxx_isp_mmu_slaves,
>>>> + =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap3xxx_isp_mmu_=
slaves),
>>>> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_NO_IDLEST,
>>>> +};
>>>
>>> Most of the stuff I see the hwmods is .main_lock =3D "foo_fck", sla=
ve
>>> .clk =3D "foo_ick". Maybe that explains the irq issues you get.
>>
>> I see irq issues with iva hwmod because tidspbridge doesn't use iomm=
u
>> API yet, so if you enable both the mmu hwmod and tidspbridge own mmu
>> implementation there will be some conflicts.
>>
>> I didn't see isp issues though, but I didn't went more than
>> booting/enabling with isp mmu.
>
> This is what you said:
> Removed clk handling during interrupt, given that in order to receive=
 one,
> the device should be powered on in advance.

Yes, you should receive an interrupt if the clock is enabled and the
iommu is being used, hence the part inside in the ISR to enable the
clocks was removed.

> I'm not sure how this clock stuff works, but I'm guessing the device
> is supposed to go to sleep at some points in time, and with your patc=
h
> "OMAP3/4: iommu: adapt to runtime pm" it won't, as long as the module
> is loaded, unless I'm missing something.

The device should be able to be put to sleep at anytime when it is NOT
being used. AFAIK there is no mechanism for the main processor (the
one running the kernel) to know when the other iommus are not being
used, given that they are in independent processors/subsystems, at
least for the ones in the DSP or M3 processors. Once the user releases
its iommu resource it means it is no longer using it, at that point
the device can be put to sleep.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
