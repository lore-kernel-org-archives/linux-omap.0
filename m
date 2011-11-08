From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH] ARM: omap4: prm: Fix up swapped offset macros
Date: Tue, 08 Nov 2011 11:52:11 +0530
Message-ID: <4EB8CA93.3020706@ti.com>
References: <1320660386-18148-1-git-send-email-rnayak@ti.com> <4EB7DBF5.8000305@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:36510 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751738Ab1KHGWS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Nov 2011 01:22:18 -0500
Received: by mail-yw0-f54.google.com with SMTP id 32so274312ywt.13
        for <linux-omap@vger.kernel.org>; Mon, 07 Nov 2011 22:22:17 -0800 (PST)
In-Reply-To: <4EB7DBF5.8000305@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, Gina Glaser <g-glaser@ti.com>

>>
>>    /* OMAP4 specific register offsets */
>>    #define OMAP4_RM_RSTCTRL				0x0000
>> -#define OMAP4_RM_RSTTIME				0x0004
>> -#define OMAP4_RM_RSTST				0x0008
>> +#define OMAP4_RM_RSTST				0x0004
>> +#define OMAP4_RM_RSTTIME				0x0008
>>    #define OMAP4_PM_PWSTCTRL				0x0000
>>    #define OMAP4_PM_PWSTST				0x0004
>
> In fact these defines were already defined correctly later (with a slightly different name):
>
> /* PRM.DEVICE_PRM register offsets */
>
> [...]
>
> #define OMAP4_PRM_RSTST_OFFSET		0x0004
> #define OMAP4430_PRM_RSTST		OMAP44XX_PRM_REGADDR(OMAP4430_PRM_DEVICE_INST, 0x0004)
> #define OMAP4_PRM_RSTTIME_OFFSET	0x0008
> #define OMAP4430_PRM_RSTTIME		OMAP44XX_PRM_REGADDR(OMAP4430_PRM_DEVICE_INST, 0x0008)
>
>
> I don't know where these defines are used, but we'd better use the existing ones.

Yes, it looks like it makes sense to completely get rid of these and
instead use the auto-generated ones.
I see there are these multiple defines for omap3 too, maybe its best to
get rid of them for omap3 too?

>
> Benoit

