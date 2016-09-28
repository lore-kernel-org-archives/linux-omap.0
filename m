From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 0/9] dmaengine: ti drivers: enable COMPILE_TESTing
Date: Wed, 28 Sep 2016 08:58:16 +0300
Message-ID: <e138bd1b-8705-11b8-c4c2-a50db5292fcc@ti.com>
References: <20160921124135.11849-1-peter.ujfalusi@ti.com>
 <20160928032605.GK2467@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160928032605.GK2467@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: dan.j.williams@intel.com, arnd@arndb.de, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Vinod,

On 09/28/16 06:26, Vinod Koul wrote:
> On Wed, Sep 21, 2016 at 03:41:26PM +0300, Peter Ujfalusi wrote:
>> Hi,
>>
>> Changes since v2:
>> - Instead of converting to use enum for the of_device_id data parameter the two
>>   patch for edma and ti-dma-crossbar is using pointers to u32 variables to make
>>   sure that the code compile (and in theory work) on all architectures.
>> - fixed issue in the ti-dma-crossbar driver I have made with the enum change to
>>   not handle the DMA offset parameters correctly.
>>
>> Changes since v1:
>> - added the compiler warning message to ti-dma-crossbar enum type patch
>> - moved the Kconfig patches at the end of the seris
>>
>> The following series will enable unconditional COMPILE_TEST coverage for the
>> following drivers: omap-dma, edma and ti-dma-crossbar
>>
>> The series includes fixes noticed when compiling the drivers for x86_64 and
>> aarch64.
> 
> I have applied the series after fixing code style nit-picks.
> 
> Also applied the edma patch and reordered the series to have that come
> before compile test enable patch
> 
> Please verify.

Looks good, thank you!

-- 
Péter
