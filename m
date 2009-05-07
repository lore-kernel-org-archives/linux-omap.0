From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 0/3] omap3-iommu: cleanups and remote registration
Date: Thu, 7 May 2009 23:39:44 +0300
Message-ID: <94a0d4530905071339i7e67d1fm236af1858a6f13c5@mail.gmail.com>
References: <94a0d4530905071302g3510fdabne659a42bd9009909@mail.gmail.com>
	 <1241727069-15168-1-git-send-email-felipe.contreras@gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E2AED092B@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:64456 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752427AbZEGUjp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 May 2009 16:39:45 -0400
Received: by fxm2 with SMTP id 2so1027363fxm.37
        for <linux-omap@vger.kernel.org>; Thu, 07 May 2009 13:39:44 -0700 (PDT)
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E2AED092B@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Tony Lindgren <tony@atomide.com>

On Thu, May 7, 2009 at 11:28 PM, Kanigeri, Hari <h-kanigeri2@ti.com> wrote:
>> Currently the iva2 code (tidspbridge) is not using iommu, therefore it
>> can't be
>> used as-is with the current omap iommu.
>
> Bridge can use IOMMU module that Hiroshi has sent by calling below 2 lines of code.
>
> struct iommu *iva_iommu_ptr;
> iva_iommu_ptr = iommu_get("iva2");

>From where? Care to send an actual patch?

-- 
Felipe Contreras
