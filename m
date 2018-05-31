From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v2 3/6] clk: ti: dra7: Add clkctrl clock data for the mcan
 clocks
Date: Thu, 31 May 2018 15:44:43 +0530
Message-ID: <e7e3ade1-76b7-f216-ece5-bd64a55cede6@ti.com>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-4-faiz_abbas@ti.com>
 <20180531040350.GA25132@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180531040350.GA25132@rob-hp-laptop>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com, paul@pwsan.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Thursday 31 May 2018 09:33 AM, Rob Herring wrote:
> On Wed, May 30, 2018 at 07:41:30PM +0530, Faiz Abbas wrote:
>> Add clkctrl data for the m_can clocks and register it within the
...
>>  
>> diff --git a/include/dt-bindings/clock/dra7.h b/include/dt-bindings/clock/dra7.h
>> index 5e1061b15aed..d7549c57cac3 100644
>> --- a/include/dt-bindings/clock/dra7.h
>> +++ b/include/dt-bindings/clock/dra7.h
>> @@ -168,5 +168,6 @@
>>  #define DRA7_COUNTER_32K_CLKCTRL	DRA7_CLKCTRL_INDEX(0x50)
>>  #define DRA7_UART10_CLKCTRL	DRA7_CLKCTRL_INDEX(0x80)
>>  #define DRA7_DCAN1_CLKCTRL	DRA7_CLKCTRL_INDEX(0x88)
>> +#define DRA7_ADC_CLKCTRL	DRA7_CLKCTRL_INDEX(0xa0)
> 
> ADC and mcan are the same thing?
> 

The register to control MCAN clocks is called ADC_CLKCTRL, Yes.

Thanks,
Faiz
