From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v2] ARM: davinci: Add the clock for the CPPI 4.1 DMA engine
Date: Wed, 12 Apr 2017 16:57:19 +0530
Message-ID: <5578004a-682f-f135-a03c-eb41fa4d1426@ti.com>
References: <20170405171750.16821-1-abailon@baylibre.com>
 <e941f7f4-1904-a0c5-3ef0-973477087b2b@ti.com>
 <dade7b1b-af0f-0f3e-26fc-4e845c451330@baylibre.com>
 <d73b5bf4-4772-4089-0e04-76275b6a00a3@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <d73b5bf4-4772-4089-0e04-76275b6a00a3@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alexandre Bailon <abailon@baylibre.com>
Cc: grygorii.strashko@ti.com, sergei.shtylyov@cogentembedded.com, tony@atomide.com, khilman@baylibre.com, linux-usb@vger.kernel.org, ptitiano@baylibre.com, linux-omap@vger.kernel.org, b-liu@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Friday 07 April 2017 11:01 PM, Alexandre Bailon wrote:
> 
> 
> On 04/07/2017 06:15 PM, Alexandre Bailon wrote:
>>
>>
>> On 04/07/2017 04:36 PM, Sekhar Nori wrote:
>>> On Wednesday 05 April 2017 10:47 PM, Alexandre Bailon wrote:
>>>> The CPPI 4.1 DMA is sharing its clock with the USB OTG,
>>>> and most of the time, the clock will be enabled by USB.
>>>> But during the init of the DMA, USB is not enabled (waiting for DMA),
>>>> and then we must enable the clock before doing anything.
>>>> Add the clock for the CPPI 4.1 DMA engine.
>>>>
>>>> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
>>>> ---
>>>>   arch/arm/mach-davinci/da830.c | 6 ++++++
>>>>   arch/arm/mach-davinci/da850.c | 6 ++++++
>>>>   2 files changed, 12 insertions(+)
>>>>
>>>> diff --git a/arch/arm/mach-davinci/da830.c
>>>> b/arch/arm/mach-davinci/da830.c
>>>> index 073c458..bd88470 100644
>>>> --- a/arch/arm/mach-davinci/da830.c
>>>> +++ b/arch/arm/mach-davinci/da830.c
>>>> @@ -304,6 +304,11 @@ static struct clk usb20_clk = {
>>>>       .gpsc        = 1,
>>>>   };
>>>>   +static struct clk cppi41_clk = {
>>>> +    .name        = "cppi41",
>>>> +    .parent        = &usb20_clk,
>>>> +};
>>>> +
>>>>   static struct clk aemif_clk = {
>>>>       .name        = "aemif",
>>>>       .parent        = &pll0_sysclk3,
>>>> @@ -413,6 +418,7 @@ static struct clk_lookup da830_clks[] = {
>>>>       CLK("davinci-mcasp.1",    NULL,        &mcasp1_clk),
>>>>       CLK("davinci-mcasp.2",    NULL,        &mcasp2_clk),
>>>>       CLK("musb-da8xx",    "usb20",    &usb20_clk),
>>>> +    CLK("cppi41-dmaengine",    NULL,        &cppi41_clk),
>>> I dont see this device name being used in current linux-next. Is this
>>> name accepted ?
>> There is here a typo. The name should be cppi41-dma-engine.
>> I will fix it.
> Actually, it is not a typo. It would have be more logical to name it
> cppi41-dma-engine
> (like the driver name) but the name is correct.
> The device name is not yet in linux-next as the device is created in
> da8xx driver.
> http://marc.info/?l=linux-usb&m=149080474124498&w=2

Alright, applied this and sent a pull request. Made some minor changes
to commit message text.

Thanks,
Sekhar
