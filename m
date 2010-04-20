From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] ARM:iommu support for OMAP4
Date: Tue, 20 Apr 2010 16:26:00 +0300
Message-ID: <u2t94a0d4531004200626lb26e4835jd2ea7628ee6ce96e@mail.gmail.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E4B216AE2@dlee03.ent.ti.com>
	 <j2y94a0d4531004190011va5afdc92g5e9b1a204dee88b0@mail.gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E4B343B10@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:41369 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754494Ab0DTN0D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Apr 2010 09:26:03 -0400
Received: by bwz19 with SMTP id 19so20308bwz.21
        for <linux-omap@vger.kernel.org>; Tue, 20 Apr 2010 06:26:02 -0700 (PDT)
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E4B343B10@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>

On Tue, Apr 20, 2010 at 2:51 PM, Kanigeri, Hari <h-kanigeri2@ti.com> wrote:
>> This looks like based on an old version of omap3-iommu.c; maybe you
>> should update it.
>>
>
> -- I thought about doing this, but then I felt it doesn't make sense putting OMAP4 specific definitions in a file that is named after omap3 and all the functions in it having omap3 pre-fix.
>
> May be we can rename the omap3-iommu file to omap-iommu and change omap3 prefix in functions to omap, and just change the devices structure based on the platform. This way it would look more generic to all OMAPs.
>
> Please let me know your thoughts.

Er, that's not what I meant.

I meant that the omap4-iommu.c that you are proposing looks very
different from the current omap3-iommu.c, for example there's no
'struct iommu_device'.

Check it out:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/arm/mach-omap2/omap3-iommu.c;h=fbbcb5c8336760c52085f873107930ec7f57422c;hb=HEAD

But I also like your idea of a generic omap-iommu.

Cheers.

-- 
Felipe Contreras
