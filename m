From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: k3-am6: Introduce pinmux
 definitions
Date: Fri, 9 Nov 2018 14:20:10 +0530
Message-ID: <1c400ca6-9257-0831-6909-fb00b00c4698@ti.com>
References: <20181108112647.7205-1-vigneshr@ti.com>
 <20181108112647.7205-2-vigneshr@ti.com>
 <20181108134533.3dcy3f53oxze5nlz@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181108134533.3dcy3f53oxze5nlz@kahuna>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On 08/11/18 7:15 PM, Nishanth Menon wrote:
> On 16:56-20181108, Vignesh R wrote:
>> From: Tero Kristo <t-kristo@ti.com>
>>
>> The dt-bindings header for TI K3-AM6 SoCs define a set of macros for
>> defining pinmux configs in human readable form, instead of raw-coded
>> hex values.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>>  MAINTAINERS                          |  1 +
>>  include/dt-bindings/pinctrl/k3-am6.h | 49 ++++++++++++++++++++++++++++
>>  2 files changed, 50 insertions(+)
>>  create mode 100644 include/dt-bindings/pinctrl/k3-am6.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index fb58c64dda49..7fd59955fd21 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2204,6 +2204,7 @@ S:	Supported
>>  F:	Documentation/devicetree/bindings/arm/ti/k3.txt
>>  F:	arch/arm64/boot/dts/ti/Makefile
>>  F:	arch/arm64/boot/dts/ti/k3-*
>> +F:	include/dt-bindings/pinctrl/k3-am6.h
>>  
>>  ARM/TEXAS INSTRUMENT KEYSTONE ARCHITECTURE
>>  M:	Santosh Shilimkar <ssantosh@kernel.org>
>> diff --git a/include/dt-bindings/pinctrl/k3-am6.h b/include/dt-bindings/pinctrl/k3-am6.h
>> new file mode 100644
>> index 000000000000..42e22ee57600
>> --- /dev/null
>> +++ b/include/dt-bindings/pinctrl/k3-am6.h
> 
> Are we thinking of creating headers for every single SoC?

We would need one file per SoC family (i.e atleast one for K3 family as
a whole) as pinctrl register layout is significantly different than
other TI SoCs. I can rename the file to include/dt-bindings/pinctrl/k3.h
to indicate its intended to be common for all K3 SoCs, if you prefer.

> 
> Is it possible for us to reduce the number of headers we'd need?
> 
>> @@ -0,0 +1,49 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * This header provides constants for TI K3-AM6 pinctrl bindings.
>> + *
>> + * Copyright (C) 2018 Texas Instruments
> 
> Please fix this:
> Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
> 

Done.

>> + */
>> +#ifndef _DT_BINDINGS_PINCTRL_TI_K3_AM6_H
>> +#define _DT_BINDINGS_PINCTRL_TI_K3_AM6_H
>> +
>> +/* K3 mux mode options for each pin. See TRM for options */
>> +#define MUX_MODE0	0
>> +#define MUX_MODE1	1
>> +#define MUX_MODE2	2
>> +#define MUX_MODE3	3
>> +#define MUX_MODE4	4
>> +#define MUX_MODE5	5
>> +#define MUX_MODE6	6
>> +#define MUX_MODE7	7
>> +#define MUX_MODE15	15
>> +
> bit 15?
> 

Nope its 0xF. Anyway, dropping these macros as suggested by Tony on
Patch 2/2

>> +#define PULL_DISABLE		(1 << 16)
> PULLUDEN -> this bit enables the Pull
>> +#define PULL_UP			(1 << 17)
> This is a pull direction selection bit.
> 
> so, should these be:
> #define PULLUDEN_SHIFT (16)
> #define PULLTYPESEL_SHIFT (17)
> #define RXACTIVE_SHIFT (18)
> 
> #define PULL_DISABLE (1 << PULLUDEN_SHIFT)
> #define PULL_ENABLE (0 << PULLUDEN_SHIFT)
> 
> #define PULL_UP (1 << PULLTYPESEL_SHIFT | PULL_ENABLE)
> #define PULL_DOWN (0 << PULLTYPESEL_SHIFT | PULL_ENABLE)
> 
>> +#define INPUT_EN		(1 << 18)
> #define INPUT_EN (1 << RXACTIVE_SHIFT)
> 
> These names dont seem to match up to the http://www.ti.com/lit/pdf/spruid7
> 
> This might be readable when people look up trm and try to generate the
> pinmux setup.
> 

Ok, will update as you suggested above.

>> +#define SLEWCTRL_200MHZ		0
>> +#define SLEWCTRL_150MHZ		(1 << 19)
>> +#define SLEWCTRL_100MHZ		(2 << 19)
>> +#define SLEWCTRL_50MHZ		(3 << 19)
> 
>> +#define TX_DIS			(1 << 21)
> What does this mean? Transmit disable? or output disable?
> 
>> +#define ISO_OVR			(1 << 22)
>> +#define ISO_BYPASS		(1 << 23)
>> +#define DS_EN			(1 << 24)
>> +#define DS_INPUT		(1 << 25)
> Seems to be DSOUT_DIS not the same as input -> in deepsleep,
> there is no input - this bit simply means that you are driving an output
> or not during deep sleep?
> 
>> +#define DS_FORCE_OUT_HIGH	(1 << 26)
> you need a FORCE_OUT_LOW as well to be readable.
> 
>> +#define DS_PULL_UP_DOWN_EN	0
>> +#define DS_PULL_UP_DOWN_DIS	(1 << 27)
>> +#define DS_PULL_UP_SEL		(1 << 28)
>> +#define WAKEUP_ENABLE		(1 << 29)
> I do have a similar set of confusion here as well.

Dropping all the above from v2 as we wont be needing them ATM.

>> +
>> +#define PIN_OUTPUT		(PULL_DISABLE)
>> +#define PIN_OUTPUT_PULLUP	(PULL_UP)
>> +#define PIN_OUTPUT_PULLDOWN	0
>> +#define PIN_INPUT		(INPUT_EN | PULL_DISABLE)
>> +#define PIN_INPUT_PULLUP	(INPUT_EN | PULL_UP)
>> +#define PIN_INPUT_PULLDOWN	(INPUT_EN)
> 
> 
> Not exactly sure of the approach taken here -> it seems to be a mix of
> implicit macro -> there needs to be some level of consistency and
> guidance to dts folks as to which macros are to be used and what not.
> 

Will fix that.

> will be nice if the number of macros are minimal and is clearly
> documented as to what macros are expected to be used in dts.
> 

I will come up with minimal set needed for now and add a comment as to
what macros are intended to be used in DT.

>> +
>> +#define AM65X_IOPAD(pa, val)		(((pa) & 0x1fff)) (val)
>> +#define AM65X_WKUP_IOPAD(pa, val)	(((pa) & 0x1fff)) (val)
>> +
>> +#endif
>> -- 
>> 2.19.1
>>
> 

-- 
Regards
Vignesh
