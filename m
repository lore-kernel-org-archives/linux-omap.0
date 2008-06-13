From: "Arun KS" <getarunks@gmail.com>
Subject: Re: [PATCH] Separate out 3430 LCD panel support from 2430 file
Date: Fri, 13 Jun 2008 11:51:54 +0530
Message-ID: <dfeb90390806122321j416c85a6rd9e55d47e69aee8f@mail.gmail.com>
References: <1213266272-8585-1-git-send-email-iqbal@ti.com>
	 <afafe9c73f500ada378e662ea92fd1e5@felipebalbi.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB022BD380AD@dbde02.ent.ti.com>
	 <75388c8bcebd54adbdd87d1f042118eb@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.184]:62469 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535AbYFMGV6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jun 2008 02:21:58 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1153153tic.23
        for <linux-omap@vger.kernel.org>; Thu, 12 Jun 2008 23:21:56 -0700 (PDT)
In-Reply-To: <75388c8bcebd54adbdd87d1f042118eb@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, Iqbal <iqbal@ti.com>, linux-omap@vger.kernel.org

Felipe,

I think CONFIG_MACH_OMAP_XXX is chosen in arch/arm/mach-omap2/Kconfig
and not in drivers/media/video/omap.

Best Regards,
Arun

On Thu, Jun 12, 2008 at 6:09 PM, Felipe Balbi <me@felipebalbi.com> wrote:
>
>
> On Thu, 12 Jun 2008 17:24:49 +0530, "Gadiyar, Anand" <gadiyar@ti.com>
> wrote:
>>> > Separate out 3430 LCD panel support from 2430 SDP.
>>> >
>>> > Currently the support for the LCD on 3430SDP is added in the
>> lcd_2430sdp.c
>>> > file. This patch separates it out to a new file.
>>>
>>> You're at least missing 3430sdp defconfig updates, Kconfig changes
>>> in drivers/media/video/omap and the removal of conditional code in
>>> lcd_2430sdp.c
>>
>> Er... Why Kconfig in drivers/media/video/omap?
>
> brainfart :-p
> It uses CONFIG_MACH_OMAP_XXX :-)
>
> forget about the Kconfig :-)
>
> --
> Best Regards,
>
> Felipe Balbi
> http://felipebalbi.com
> me@felipebalbi.com
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
