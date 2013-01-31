From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH] ARM: omap4: clock data: Add missing clkdm association
 for dpll_usb
Date: Thu, 31 Jan 2013 17:14:08 +0530
Message-ID: <510A5908.30804@ti.com>
References: <1359095795-9538-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1301250810090.471@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46622 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282Ab3AaLoS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Jan 2013 06:44:18 -0500
In-Reply-To: <alpine.DEB.2.00.1301250810090.471@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: mturquette@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Paul,

>> dpll_usb needs the clkdm association so the clkdm can be
>> turned on before a relock. All other dplls for omap4 belong
>> to the ALWON (always on) domain.
>>
>> The association was present as part of the older data file
>> (clock44xx_data.c) but looks like was accidently dropped with
>> the common clk convertion.
>
> Thanks, queued for v3.8-rc fixes.

I just realized that apart from adding the missing .clkdm_name, I
also need to populate a .init as part of clk_ops for dpll_usb
so the clockdomain lookup can then happen based on the .clkdm_name.

I have updated the $Subject patch and posted a v2 (http://marc.info
/?l=linux-omap&m=135963212530790&w=2). Would it be possible for you to
pick the v2 instead and drop this one from your fixes branch.

regards,
Rajendra

>
> - Paul
>

