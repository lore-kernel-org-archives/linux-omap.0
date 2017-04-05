From: Alexandre Bailon <abailon@baylibre.com>
Subject: Re: [PATCH] ARM: davinci: Add the clock for the CPPI 4.1 DMA engine
Date: Wed, 5 Apr 2017 19:10:43 +0200
Message-ID: <e2bbe80a-834e-717d-c62b-1f33efff0488@baylibre.com>
References: <20170329160932.27157-1-abailon@baylibre.com>
 <f53545e0-d009-2ef5-ab21-e9f9b3518045@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <f53545e0-d009-2ef5-ab21-e9f9b3518045@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: grygorii.strashko@ti.com, sergei.shtylyov@cogentembedded.com, tony@atomide.com, khilman@baylibre.com, linux-usb@vger.kernel.org, ptitiano@baylibre.com, linux-omap@vger.kernel.org, b-liu@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On 04/04/2017 08:16 AM, Sekhar Nori wrote:
> On Wednesday 29 March 2017 09:39 PM, Alexandre Bailon wrote:
>> The CPPI 4.1 DMA is sharing its clock with the USB OTG,
>> and most of the time, the clock will be enabled by USB.
>> But during the init of the DMA, USB is not enabled (waiting for DMA),
>> and then we must enable the clock before to do anything.
>> Add the clock for the CPPI 4.1 DMA engine.
>>
>> Note:
>> This patch is to apply instead of:
>> "ARM: davinci: Make the usb20 clock available to PM runtime"
> Okay, but I still liked the fact that that patch was using NULL as
> con_id for MUSB clock. That makes sense because MUSB gets a single clock
> input. I think you should still make that change. If not for v4.12, then
> for v4.13.
>
>> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
>> ---
>>   arch/arm/mach-davinci/da830.c    | 1 +
>>   arch/arm/mach-davinci/da850.c    | 1 +
>>   arch/arm/mach-davinci/da8xx-dt.c | 2 ++
>>   3 files changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
>> index 073c458..ae4a8a5 100644
>> --- a/arch/arm/mach-davinci/da830.c
>> +++ b/arch/arm/mach-davinci/da830.c
>> @@ -413,6 +413,7 @@ static struct clk_lookup da830_clks[] = {
>>   	CLK("davinci-mcasp.1",	NULL,		&mcasp1_clk),
>>   	CLK("davinci-mcasp.2",	NULL,		&mcasp2_clk),
>>   	CLK("musb-da8xx",	"usb20",	&usb20_clk),
>> +	CLK("cppi41-dmaengine",	NULL,		&usb20_clk),
> Did you try reading /sys/kernel/debug/davinci_clocks after this patch?
> It will hang because of the loop created here.
I have tried and I did not get any issues.
>
> Looks like what you want is cppi4.1 dma clock to be a child of MUSB
> clock. That way, even if DMA is enabled before MUSB, it still works.
OK. I will update the patch to make cppi4.1 clock a child of usb clock.
>
> Thanks,
> Sekhar
Thanks,
Alexandre
