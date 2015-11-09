From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 2/3] dmaengine: ti-dma-crossbar: dra7: Support for
 reserving DMA event ranges
Date: Mon, 9 Nov 2015 10:28:45 +0200
Message-ID: <5640593D.3020702@ti.com>
References: <1446192038-11158-1-git-send-email-peter.ujfalusi@ti.com>
 <1446192038-11158-3-git-send-email-peter.ujfalusi@ti.com>
 <20151106215310.GA20278@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151106215310.GA20278@rob-hp-laptop>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, vinod.koul@intel.com, r.schwebel@pengutronix.de, nsekhar@ti.com, linux-kernel@vger.kernel.org, tony@atomide.com, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 11/06/2015 11:53 PM, Rob Herring wrote:
> On Fri, Oct 30, 2015 at 10:00:37AM +0200, Peter Ujfalusi wrote:
>> In eDMA the events are directly mapped to a DMA channel (for example DMA
>> event 14 can only be handled by DMA channel 14). If the memcpy is enabled
>> on the eDMA, there is a possibility that the crossbar driver would assign
>> DMA event number already allocated in eDMA for memcpy. Furthermore the
>> eDMA can be shared with DSP in which case the crossbar driver should also
>> avoid mapping xbar events to DSP used event numbers (or channels).
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  .../devicetree/bindings/dma/ti-dma-crossbar.txt    |  6 +++
>>  drivers/dma/ti-dma-crossbar.c                      | 47 +++++++++++++++=
+++++--
>>  2 files changed, 49 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt b=
/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
>> index b152a75dceae..aead5869a28d 100644
>> --- a/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
>> +++ b/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
>> @@ -14,6 +14,10 @@ The DMA controller node need to have the following po=
roperties:
>>  =

>>  Optional properties:
>>  - ti,dma-safe-map: Safe routing value for unused request lines
>> +- ti,reserved-dma-request-ranges: DMA request ranges which should not b=
e used
>> +		when mapping xbar input to DMA request, they are either
>> +		allocated to be used by for example the DSP or they are used as
>> +		memcpy channels in eDMA.
> =

> How many requests are there? I think I'd rather see this as a mask =

> value.

The eDMA on dra7 family have 64 channels. I don't have visibility to custom=
er
kernels, but at least 32 channels need be allocated to be used by the DSP.
This depends on the system design. It could be that only the memcpy channels
need to be reserved, but in some setups we do need more than a few.

-- =

P=E9ter
