From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 10/11] OMAP: GPIO: Implement GPIO as a platform device
Date: Thu, 20 May 2010 09:36:38 -0700
Message-ID: <87vdaifs2x.fsf@deeprootsystems.com>
References: <1274194260-16401-1-git-send-email-charu@ti.com>
	<1274194260-16401-2-git-send-email-charu@ti.com>
	<1274194260-16401-3-git-send-email-charu@ti.com>
	<1274194260-16401-4-git-send-email-charu@ti.com>
	<1274194260-16401-5-git-send-email-charu@ti.com>
	<1274194260-16401-6-git-send-email-charu@ti.com>
	<1274194260-16401-7-git-send-email-charu@ti.com>
	<1274194260-16401-8-git-send-email-charu@ti.com>
	<1274194260-16401-9-git-send-email-charu@ti.com>
	<1274194260-16401-10-git-send-email-charu@ti.com>
	<1274194260-16401-11-git-send-email-charu@ti.com>
	<4BF2CD67.3090208@ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5666252@dbde02.ent.ti.com>
	<74583B8642AB8841B30447520659FCA9EC423083@dnce01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37620 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947Ab0ETQgq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 May 2010 12:36:46 -0400
Received: by vws9 with SMTP id 9so17798vws.19
        for <linux-omap@vger.kernel.org>; Thu, 20 May 2010 09:36:45 -0700 (PDT)
In-Reply-To: <74583B8642AB8841B30447520659FCA9EC423083@dnce01.ent.ti.com> (Benoit Cousson's message of "Wed\, 19 May 2010 09\:50\:52 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, 'Paul Walmsley' <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, linux-omap <linux-omap@vger.kernel.org>

"Cousson, Benoit" <b-cousson@ti.com> writes:

> Hi Charu
>
>>From: Varadarajan, Charulatha
>>
>>> From: Cousson, Benoit
>>> Sent: Tuesday, May 18, 2010 10:55 PM
>>>
>>> Hi Charu,
>>>
>>> On 5/18/2010 4:50 PM, Charulatha V wrote:
>>>
>>> [snip]
>>>
>>> > diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-
>>> omap2/clock2420_data.c
>>> > index d932b14..a693403 100644
>>> > --- a/arch/arm/mach-omap2/clock2420_data.c
>>> > +++ b/arch/arm/mach-omap2/clock2420_data.c
>>> > @@ -1802,8 +1802,14 @@ static struct omap_clk omap2420_clks[] = {
>>> >          CLK(NULL,       "uart2_fck",&uart2_fck,     CK_242X),
>>> >          CLK(NULL,       "uart3_ick",&uart3_ick,     CK_242X),
>>> >          CLK(NULL,       "uart3_fck",&uart3_fck,     CK_242X),
>>> > -       CLK(NULL,       "gpios_ick",&gpios_ick,     CK_242X),
>>> > -       CLK(NULL,       "gpios_fck",&gpios_fck,     CK_242X),
>>> > +       CLK("omap-gpio.0",      "ick",&gpios_ick,     CK_242X),
>>> > +       CLK("omap-gpio.1",      "ick",&gpios_ick,     CK_242X),
>>> > +       CLK("omap-gpio.2",      "ick",&gpios_ick,     CK_242X),
>>> > +       CLK("omap-gpio.3",      "ick",&gpios_ick,     CK_242X),
>>> > +       CLK("omap-gpio.0",      "fck",&gpios_fck,     CK_242X),
>>> > +       CLK("omap-gpio.1",      "fck",&gpios_fck,     CK_242X),
>>> > +       CLK("omap-gpio.2",      "fck",&gpios_fck,     CK_242X),
>>> > +       CLK("omap-gpio.3",      "fck",&gpios_fck,     CK_242X),
>>>
>>> Are you sure that this is still needed? In theory Paul removed the
>>> dependency a couple of months ago.
>>> HWMOD does not need that anymore at least, it is relying on the clock
>>> name only.
>>
>>You are right. These are not required if hwmod is used. But
>>here we use pm_runtime APIs which needs clk_get/ clk_enable in
>>case of CONFIG_PM_RUNTIME is not defined.
>>Also in OMAP3&4, for dbck we need clk_get/clk_enable to be
>>used as opt_clk is
>>taken care by the driver. Hence the above changes are required.
>
> That still looks wrong to me. We cannot keep exposing manual clock management method in case runtime_pm is not used.
> It makes the whole hwmod isolation stuff a little bit useless, it forces us to maintain some dummy clocks node...
> In that case you should use the omap_device to enable the device.

I agree, the !CONFIG_PM_RUNTIME case can still use omap_device API.

> Dbck are listed as opt_clock in the hwmod struct and thus can be accesses.

Agreed.

Kevin

