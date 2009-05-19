From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] omap3-iommu: reorganize
Date: Tue, 19 May 2009 12:43:49 +0300
Message-ID: <94a0d4530905190243h773e7e77t854aa71edcc7d0f1@mail.gmail.com>
References: <20090518.172613.116355729.Hiroshi.DOYU@nokia.com>
	 <1242664980-6324-1-git-send-email-felipe.contreras@gmail.com>
	 <20090519.090325.02296387.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:37050 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbZESJnu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 05:43:50 -0400
Received: by fg-out-1718.google.com with SMTP id d23so812070fga.17
        for <linux-omap@vger.kernel.org>; Tue, 19 May 2009 02:43:49 -0700 (PDT)
In-Reply-To: <20090519.090325.02296387.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com, linux-arm-kernel@lists.arm.linux.org.uk

On Tue, May 19, 2009 at 9:03 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
> From: ext Felipe Contreras <felipe.contreras@gmail.com>
> Subject: [PATCH] omap3-iommu: reorganize
> Date: Mon, 18 May 2009 18:43:00 +0200
>
>> No functional changes.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>
>> How about this?
>
> What's the advantage of introducing a new structure here?

That instead of having 3 arrays with potentially different sizes:

iommu_base
iommu_irq
omap3_iommu_pdata

You have one:

devices

Also, think about the hypothetical situation where you need 2 more
iommu devices (maybe OMAP4?). What would you need to do? You'll need
to add OMAP3_MMU3_BASE and OMAP3_MMU4_BASE add them to iommu_base,
then add OMAP3_MMU3_IRQ and OMAP3_MMU4_IRQ and put them to iommu_irq,
finally add the device data to omap3_iommu_pdata.

In the process a simple mistake would be easy to overlook:

static unsigned long iommu_base[] __initdata = {
       OMAP3_MMU1_BASE,
       OMAP3_MMU2_BASE,
+       OMAP3_MMU3_BASE,
+       OMAP3_MMU2_BASE,
};

With the 'devices' array you just need to add two more elements and
that's it. It leaves less room for mistakes.

However 'struct iommu_device' is a local structure, it could very well
be called __foobar__, nobody outside omap3-iommu.c will see it anyway.

-- 
Felipe Contreras
