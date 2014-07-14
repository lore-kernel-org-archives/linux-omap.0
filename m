From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH v4 02/11] memory: emif: Move EMIF register defines to
 include/linux/
Date: Mon, 14 Jul 2014 12:42:46 -0500
Message-ID: <53C41696.6020004@ti.com>
References: <1405047349-15101-1-git-send-email-d-gerlach@ti.com> <1405047349-15101-3-git-send-email-d-gerlach@ti.com> <20140714111222.GB20068@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39696 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755934AbaGNRnK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Jul 2014 13:43:10 -0400
In-Reply-To: <20140714111222.GB20068@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Russ Dill <russ.dill@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Mack <daniel@zonque.org>, Suman Anna <s-anna@ti.com>, Benoit Cousson <bcousson@baylibre.com>

On 07/14/2014 06:12 AM, Tony Lindgren wrote:
> * Dave Gerlach <d-gerlach@ti.com> [140710 19:59]:
>> OMAP4 and AM33XX share the same EMIF controller IP. Although there
>> are significant differences in the IP integration due to which
>> AM33XX can't reuse the EMIF driver DVFS similar to OMAP4,
>> it can definitely benefit by reusing the EMIF related macros
>> defined in drivers/memory/emif.h.
>>
>> In the current OMAP PM framework the PM code resides under
>> arch/arm/mach-omap2/. To enable reuse of the register defines move
>> the register defines in the emif header file to include/linux so that
>> both the EMIF driver and the AM33XX PM code can benefit.
>>
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> Reviewed-by: Russ Dill <russ.dill@ti.com>
>> Acked-by: Santosh Shililmar <santosh.shilimkar@ti.com>
>> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>> v3->v4:
>> patch unchanged from original:
>> 	http://www.spinics.net/lists/linux-omap/msg95314.html
>>
>>   drivers/memory/emif.h   | 543 +---------------------------------------------
>>   include/linux/ti_emif.h | 558 ++++++++++++++++++++++++++++++++++++++++++++++++
>
> So far we've seen that exposing hardware registers like this
> will lead into various drivers misusing them. I think a better
> solution is to implement few targeted functions that allow
> sharing code between the platform idle code and memory driver.
>
> Maybe you can have the shared functions in in something like
> drivers/memory/ti-emif.c that's always built in? The idle
> code won't need any of that early on.

Well the reason it was done this way was to utilize all of the addresses of EMIF 
register in the ASM sleep code to do relative addressing from the EMIF base 
address. The ASM sleep code (patch 9) needs to save and restore emif context and 
set and unset self refresh in emif. The issues will come from the ASM being 
copied to and running from SRAM without the ability to access code in DDR 
(because we are shutting the EMIF off), so we would need to copy these functions 
as well and have to worry about any issues we introduce by relocating c code. Is 
it worth the added maintenance burden?

Regards,
Dave

> Regards,
>
> Tony
>

