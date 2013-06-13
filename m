From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: OMAP v3.10-rc regressions that no one's fixed
Date: Thu, 13 Jun 2013 16:25:16 +0530
Message-ID: <51B9A514.6020706@ti.com>
References: <alpine.DEB.2.02.1306100716560.4604@utopia.booyaka.com> <20130612174842.GQ8164@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58705 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755868Ab3FMKzn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Jun 2013 06:55:43 -0400
In-Reply-To: <20130612174842.GQ8164@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony,
On Wednesday 12 June 2013 11:18 PM, Tony Lindgren wrote:
> * Paul Walmsley <paul@pwsan.com> [130610 00:27]:
>>
>> Hi folks -- particularly TIers working on mainline,
>>
>> There are several regressions that started with v3.10-rc that no one's
>> fixed for over a month.  Some of them should be quite easy:
>>
>> * 37xx EVM: boot fails
>>    - as of v3.10-rc1
>>    - Cause unknown
>
> This one is probably because of broken GPIO numbering in
> the board file that uses hardcoded GPIOs for what are probably
> twl GPIOs.
>
> Does commenting out omap3_evm_display_init() in the board file
> fix the booting for you?
Yes by commenting out omap3_evm_display_init() fixes the booting.
>
> If so, we should probably mark omap3_evm_display_init() with
> CONFIG_BROKEN for now rather than add more late init callback
> functions for the twl code.
As per your suggestion I have sent a patch for marking 
omap3_evm_display_init()
with CONFIG_BROKEN.

Thanks,
Lokesh
>
> Regards,
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

