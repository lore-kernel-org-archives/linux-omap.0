From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v4 08/11] dt-bindings: sdhci-omap: Add documentation for
 ti,needs-special-reset property
Date: Tue, 7 Jan 2020 16:48:02 +0530
Message-ID: <fa2866cb-485a-9eed-47c2-fb3f6f260d31@ti.com>
References: <20200106110133.13791-1-faiz_abbas@ti.com>
 <20200106110133.13791-9-faiz_abbas@ti.com> <20200106220313.GA6822@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200106220313.GA6822@bogus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, kishon@ti.com, adrian.hunter@intel.com, mark.rutland@arm.com, ulf.hansson@linaro.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Hi Rob,

On 07/01/20 3:33 am, Rob Herring wrote:
> On Mon, Jan 06, 2020 at 04:31:30PM +0530, Faiz Abbas wrote:
>> Some controllers need a special software reset sequence. Document the
>> ti,needs-special-reset binding to indicate that a controller needs this.
>>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> ---
>>  Documentation/devicetree/bindings/mmc/sdhci-omap.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
>> index 97efb01617dd..0f5389c72bda 100644
>> --- a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
>> @@ -21,6 +21,7 @@ Optional properties:
>>  - dma-names:	List of DMA request names. These strings correspond 1:1 with the
>>  		DMA specifiers listed in dmas. The string naming is to be "tx"
>>  		and "rx" for TX and RX DMA requests, respectively.
>> +- ti,needs-special-reset: Requires a special softreset sequence
> 
> Why can't this be implied by the compatible string?
> 

You are right. We can assign the special_reset flag in the next patch
using compatible as well. Will drop this patch in next version.

Thanks,
Faiz
