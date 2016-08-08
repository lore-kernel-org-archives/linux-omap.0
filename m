From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 6/6] dmaengine: omap-dma: Support for LinkedList
 transfer of slave_sg
Date: Mon, 8 Aug 2016 16:58:15 +0300
Message-ID: <76993999-9638-7c46-a85a-e2ed2ef1b8a0@ti.com>
References: <20160720085032.2955-1-peter.ujfalusi@ti.com>
 <20160720085032.2955-7-peter.ujfalusi@ti.com>
 <20160808054226.GR9681@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160808054226.GR9681@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On 08/08/16 08:42, Vinod Koul wrote:
> On Wed, Jul 20, 2016 at 11:50:32AM +0300, Peter Ujfalusi wrote:
>> sDMA in OMAP3630 or newer SoC have support for LinkedList transfer. When
>> LinkedList or Descriptor load feature is present we can create the
>> descriptors for each and program sDMA to walk through the list of
>> descriptors instead of the current way of sDMA stop, sDMA reconfiguration
>> and sDMA start after each SG transfer.
>> By using LinkedList transfer in sDMA the number of DMA interrupts will
>> decrease dramatically.
>> Booting up the board with filesystem on SD card for example:
>> W/o LinkedList support:
>>  27:       4436          0     WUGEN  13 Level     omap-dma-engine
>>
>> Same board/filesystem with this patch:
>>  27:       1027          0     WUGEN  13 Level     omap-dma-engine
>>
>> Or copying files from SD card to eMCC:
>> 2.1G    /usr/
>> 232001
>>
>> W/o LinkedList we see ~761069 DMA interrupts.
>> With LinkedList support it is down to ~269314 DMA interrupts.
>>
>> With the decreased DMA interrupt number the CPU load is dropping
>> significantly as well.
> 
> Interesting, I would have counted the throughput of DMA by using time for
> transfer and not really interrupts and CPU load. With LL mode, you get a
> big performance boost due to starting next transaction by hardware without
> waiting for CPU intervention and yes side effect is lesser interrupts and
> load :)

I did throughput test as well, it was slightly faster, but not the boost I was
hoping for.
The copy of the /usr (2.1G) - 5 runs average:
w/o linked list: 7:30 mins
with this patch: 7:23 mins

The limiting factor here is the SD card I have used. But the board was way
more responsible during heavy I/O tasks, like running 'emerge --sync' I can
still use the board.

>> @@ -743,6 +863,7 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
>>  	struct omap_desc *d;
>>  	dma_addr_t dev_addr;
>>  	unsigned i, es, en, frame_bytes;
>> +	bool ll_failed = false;
>>  	u32 burst;
>>  
>>  	if (dir == DMA_DEV_TO_MEM) {
>> @@ -818,16 +939,47 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
>>  	 */
>>  	en = burst;
>>  	frame_bytes = es_bytes[es] * en;
>> +
>> +	if (sglen >= 2)
>> +		d->using_ll = od->ll123_supported;
> 
> No upperbound on length? Does the hardware support any lengths?

No, we don't have upper limit, we can link as many sg as we could allocate
from the pool.

-- 
Péter
