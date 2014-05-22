From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v3 09/13] dt/bindings: ti,edma: Remove redundant properties
 from documentation
Date: Thu, 22 May 2014 15:23:21 +0530
Message-ID: <537DC911.3040409@ti.com>
References: <1400242640-9902-1-git-send-email-peter.ujfalusi@ti.com> <1400242640-9902-10-git-send-email-peter.ujfalusi@ti.com> <5379BDB9.50905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <5379BDB9.50905@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, joelf@ti.com, arnd@arndb.de, linux@arm.linux.org.uk, vinod.koul@intel.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, tony@atomide.com, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

On Monday 19 May 2014 01:45 PM, Sekhar Nori wrote:
> + DT maintainers
> 
> On Friday 16 May 2014 05:47 PM, Peter Ujfalusi wrote:
>> From CCCFG register of eDMA3 we can get all the needed information for the
>> driver about the IP:
>> Number of channels: NUM_DMACH
>> Number of regions: NUM_REGN
>> Number of slots (PaRAM sets): NUM_PAENTRY
>> Number of TC/EQ: NUM_EVQUE
>>
>> The ti,edma-regions; ti,edma-slots and dma-channels in DT are
>> redundant since the very same information can be obtained from the HW.
>> The mentioned properties are deprecated.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> DT maintainers,
> 
> Can I get an ack on deprecation of these bindings? We are using hardware
> to detect the same properties so it should not cause any backward
> compatibility issue when moving to newer kernels while keeping the same DTB.
> 
> Link to last mail on this topic as part of v2 thread:
> 
> http://lkml.iu.edu/hypermail/linux/kernel/1405.1/05152.html

Ping. Sorry for being a pest, but this ack is the only thing holding
this series up. I would hate this series to miss the v3.16 deadline.

Thanks,
Sekhar

