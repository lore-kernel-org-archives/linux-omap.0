From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v4 1/4] OMAP3: hwmod data: add mmu data for iva and isp
Date: Thu, 5 Jan 2012 13:24:25 -0600
Message-ID: <CAB-zwWgZ5QBFBBRQNYrpbcVo4QaZ8MYLVCMDsvAe7scHQSBBKw@mail.gmail.com>
References: <1323922709-6986-1-git-send-email-omar.ramirez@ti.com>
	<CAMP44s2H7v6dRPXO6eBBNrYAnym_ZLdmKcAQPmYyCC6Wo5qOmw@mail.gmail.com>
	<CAB-zwWhNNW1GEYr019xecuZTYhR55HpNGrhGjJdE1CEAfFSriQ@mail.gmail.com>
	<201112252208.20148.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:46939 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754713Ab2AETY0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jan 2012 14:24:26 -0500
In-Reply-To: <201112252208.20148.laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Russell King <linux@arm.linux.org.uk>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, iommu@lists.linux-foundation.org, MyungJoo Ham <myungjoo.ham@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Laurent

On Sun, Dec 25, 2011 at 3:08 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> > I'm not sure how this clock stuff works, but I'm guessing the device
>> > is supposed to go to sleep at some points in time, and with your patch
>> > "OMAP3/4: iommu: adapt to runtime pm" it won't, as long as the module
>> > is loaded, unless I'm missing something.
>>
>> The device should be able to be put to sleep at anytime when it is NOT
>> being used. AFAIK there is no mechanism for the main processor (the
>> one running the kernel) to know when the other iommus are not being
>> used, given that they are in independent processors/subsystems, at
>> least for the ones in the DSP or M3 processors. Once the user releases
>> its iommu resource it means it is no longer using it, at that point
>> the device can be put to sleep.
>
> How should the OMAP3 ISP driver proceed to make sure that its IOMMU is clocked
> off when it doesn't need it ?

If there is an specific scenario where the iommu should be disabled,
iommu_detach_device can be called to release the iommu resource. On
suspend/resume scenarios runtime pm callbacks should still be able to
put the device in idle.

Regards,

Omar
