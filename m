From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] pinctrl: dra: dt-bindings: Fix output pull up/down
Date: Mon, 3 Nov 2014 11:28:57 +0200
Message-ID: <54574AD9.3040907@ti.com>
References: <1414752745-13696-1-git-send-email-rogerq@ti.com> <20141031135030.GA25252@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40121 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbaKCJ3B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Nov 2014 04:29:01 -0500
In-Reply-To: <20141031135030.GA25252@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: tony@atomide.com, balbi@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

On 10/31/2014 03:50 PM, Nishanth Menon wrote:
> On 12:52-20141031, Roger Quadros wrote:
>> For PIN_OUTPUT_PULLUP and PIN_OUTPUT_PULLDOWN we must not set the
>> PULL_DIS bit which disables the PULLs.
>>
>> While at that get rid for the PULL_ENA defination. It is misleading
>> as there is no PULL enable bit in the register. And a zero bit defination
>> makes no sense.
> It was done to make it readable. Pull is enabled when that bit is 0 and
> disabled when that bit is 1. it is counter intutive enough for a macro

But you can't enable the PULL by ORing it. you have to AND it's inverted version with the rest.
It is confusing because it doesn't follow the logic of the other bit masks.

> to be defined. I suggest retaining that and not mixing with the current
> patch.

Agreed. I'll revise this patch to not touch that macro.

cheers,
-roger

> 
> 
>>
>> Fixes: 23d9cec07c58 (:pinctrl: dra: dt-bindings: Fix pull enable/disable")
> s/:pinctrl/"pinctrl/ ?
> 
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  include/dt-bindings/pinctrl/dra.h | 9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/dt-bindings/pinctrl/dra.h b/include/dt-bindings/pinctrl/dra.h
>> index 3d33794..71098e4 100644
>> --- a/include/dt-bindings/pinctrl/dra.h
>> +++ b/include/dt-bindings/pinctrl/dra.h
>> @@ -30,7 +30,6 @@
>>  #define MUX_MODE14	0xe
>>  #define MUX_MODE15	0xf
>>  
>> -#define PULL_ENA		(0 << 16)
>>  #define PULL_DIS		(1 << 16)
>>  #define PULL_UP			(1 << 17)
>>  #define INPUT_EN		(1 << 18)
>> @@ -40,12 +39,12 @@
>>  
>>  /* Active pin states */
>>  #define PIN_OUTPUT		(0 | PULL_DIS)
>> -#define PIN_OUTPUT_PULLUP	(PIN_OUTPUT | PULL_ENA | PULL_UP)
>> -#define PIN_OUTPUT_PULLDOWN	(PIN_OUTPUT | PULL_ENA)
>> +#define PIN_OUTPUT_PULLUP	(PULL_UP)
>> +#define PIN_OUTPUT_PULLDOWN	(0)
>>  #define PIN_INPUT		(INPUT_EN | PULL_DIS)
>>  #define PIN_INPUT_SLEW		(INPUT_EN | SLEWCONTROL)
>> -#define PIN_INPUT_PULLUP	(PULL_ENA | INPUT_EN | PULL_UP)
>> -#define PIN_INPUT_PULLDOWN	(PULL_ENA | INPUT_EN)
>> +#define PIN_INPUT_PULLUP	(INPUT_EN | PULL_UP)
>> +#define PIN_INPUT_PULLDOWN	(INPUT_EN)
>>  
>>  #endif
>>  
>> -- 
>> 1.8.3.2
>>
> 

