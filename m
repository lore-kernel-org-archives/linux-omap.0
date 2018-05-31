From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v2 3/6] clk: ti: dra7: Add clkctrl clock data for the mcan
 clocks
Date: Thu, 31 May 2018 16:29:56 +0300
Message-ID: <678ef467-a235-91db-8bae-f249ad98eac8@ti.com>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-4-faiz_abbas@ti.com>
 <20180531040350.GA25132@rob-hp-laptop>
 <e7e3ade1-76b7-f216-ece5-bd64a55cede6@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <e7e3ade1-76b7-f216-ece5-bd64a55cede6@ti.com>
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
To: Faiz Abbas <faiz_abbas@ti.com>, Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, paul@pwsan.com, tony@atomide.com, linux-kernel@vger.kernel.org, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 31/05/18 13:14, Faiz Abbas wrote:
> Hi,
> 
> On Thursday 31 May 2018 09:33 AM, Rob Herring wrote:
>> On Wed, May 30, 2018 at 07:41:30PM +0530, Faiz Abbas wrote:
>>> Add clkctrl data for the m_can clocks and register it within the
> ...
>>>   
>>> diff --git a/include/dt-bindings/clock/dra7.h b/include/dt-bindings/clock/dra7.h
>>> index 5e1061b15aed..d7549c57cac3 100644
>>> --- a/include/dt-bindings/clock/dra7.h
>>> +++ b/include/dt-bindings/clock/dra7.h
>>> @@ -168,5 +168,6 @@
>>>   #define DRA7_COUNTER_32K_CLKCTRL	DRA7_CLKCTRL_INDEX(0x50)
>>>   #define DRA7_UART10_CLKCTRL	DRA7_CLKCTRL_INDEX(0x80)
>>>   #define DRA7_DCAN1_CLKCTRL	DRA7_CLKCTRL_INDEX(0x88)
>>> +#define DRA7_ADC_CLKCTRL	DRA7_CLKCTRL_INDEX(0xa0)
>>
>> ADC and mcan are the same thing?
>>
> 
> The register to control MCAN clocks is called ADC_CLKCTRL, Yes.

Is there any reason for this or is that just a documentation bug?

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
