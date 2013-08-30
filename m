From: Vaibhav Bedia <vaibhav.bedia@gmail.com>
Subject: Re: [PATCH v2 01/13] ARM: OMAP2+: CM: reintroduce SW_SLEEP for OMAP4
Date: Fri, 30 Aug 2013 14:04:23 -0400
Message-ID: <CANacCWxziz5rcvsuhCDdWFb5eC=UCg8FHxO6xbPVw2rVO3gpXQ@mail.gmail.com>
References: <cover.1375443858.git.afzal@ti.com>
	<cfcae1c52efc51786878c60b75cc3c182bcd50a5.1375443858.git.afzal@ti.com>
	<5214688C.9030801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:57310 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755387Ab3H3SEZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Aug 2013 14:04:25 -0400
Received: by mail-lb0-f182.google.com with SMTP id c11so1492573lbj.13
        for <linux-omap@vger.kernel.org>; Fri, 30 Aug 2013 11:04:24 -0700 (PDT)
In-Reply-To: <5214688C.9030801@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Afzal Mohammed <afzal@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, benoit.cousson@gmail.com, Vaibhav Bedia <vaibhav.bedia@ti.com>, Benoit Cousson <benoit.cousson@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Wed, Aug 21, 2013 at 3:13 AM, Rajendra Nayak <rnayak@ti.com> wrote:
[...]
>> +/**
>> + * omap4_cminst_clkdm_force_sleep - try to put a clockdomain to idle
>> + * @part: PRCM partition ID that the clockdomain registers exist in
>> + * @inst: CM instance register offset (*_INST macro)
>> + * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
>> + *
>> + * Put a clockdomain referred to by (@part, @inst, @cdoffs) to idle,
>> + * forcing it to sleep.  No return value.
>> + */
>> +void omap4_cminst_clkdm_force_sleep(u8 part, s16 inst, u16 cdoffs)
>> +{
>> +     _clktrctrl_write(OMAP34XX_CLKSTCTRL_FORCE_SLEEP, part, inst, cdoffs);
>
> I guess this won't work on omap4/5 where some clockdomains do not support
> SW_SLEEP and only support HW_AUTO. We might need to have different clkdm
> operations for the different omap4 variants.
>
>

I am probably missing something here but doesn't omap4_clkdm_clk_disable() from
where this gets invoked have the appropriate flags in place already?
