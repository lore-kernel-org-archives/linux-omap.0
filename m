From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 0/1] ARM: OMAP: add external clock provider support
Date: Mon, 4 Aug 2014 15:36:19 +0300
Message-ID: <53DF7E43.2060907@ti.com>
References: <1406898948-26113-1-git-send-email-t-kristo@ti.com> <53DF7094.7050601@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33709 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033AbaHDMe7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Aug 2014 08:34:59 -0400
In-Reply-To: <53DF7094.7050601@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, mturquette@linaro.org, linux-omap@vger.kernel.org, sassmann@kpanic.de, jsarha@ti.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 08/04/2014 02:37 PM, Peter Ujfalusi wrote:
> On 08/01/2014 04:15 PM, Tero Kristo wrote:
>> Hi,
>>
>> This patch adds possibility to register external clocks (outside the main
>> SoC) on TI boards through device tree. Clock sources as such include for
>> example twl-6030 / twl-6040 chips and variants which can be used to clock
>> for example audio / WLAN chips.
>
> Just one question to Mike and Tero:
> would it be possible to have generic binding for such an external clocks?
> We have the palmas clock driver already upstream which handles the 32K clocks
> from the PMIC. Palmas class of PMICs can be used with TI/nVidia(/Intel?)
> platforms. We use Palmas on omap5-uevm, DRA7-EVM also uses Palmas compatible
> PMIC and some nVidia platform also uses this class of devices (and they all
> need to have control over the 32K clock(s)).

Other platforms initialize their clocks in different manner, they can 
use generic of_clk_init I believe. If they can't use that for some 
reason, then they need to implement something similar to this.

-Tero

>
>> This patch can be queued once someone has a use-case + patches that requires
>> usage of such clocks.
>>
>> -Tero
>>
>
>

