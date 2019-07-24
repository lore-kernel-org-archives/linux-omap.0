From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 1/6] dt-bindings: irqchip: Add PRUSS interrupt controller
 bindings
Date: Wed, 24 Jul 2019 14:42:33 -0500
Message-ID: <6871c381-9fc6-f6be-6386-f183fcc5546a@ti.com>
References: <20190708035243.12170-1-s-anna@ti.com>
 <20190708035243.12170-2-s-anna@ti.com> <20190724163419.GA29254@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190724163419.GA29254@bogus>
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
To: Rob Herring <robh@kernel.org>
Cc: David Lechner <david@lechnology.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>, Tony Lindgren <tony@atomide.com>, Murali Karicheri <m-karicheri2@ti.com>, linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On 7/24/19 11:34 AM, Rob Herring wrote:
> On Sun, 7 Jul 2019 22:52:38 -0500, Suman Anna wrote:
>> The Programmable Real-Time Unit Subsystem (PRUSS) contains an interrupt
>> controller (INTC) that can handle various system input events and post
>> interrupts back to the device-level initiators. The INTC can support
>> upto 64 input events on most SoCs with individual control configuration
>> and hardware prioritization. These events are mapped onto 10 interrupt
>> lines through two levels of many-to-one mapping support. Different
>> interrupt lines are routed to the individual PRU cores or to the
>> host CPU or to other PRUSS instances.
>>
>> The K3 AM65x and J721E SoCs have the next generation of the PRU-ICSS IP,
>> commonly called ICSSG. The ICSSG interrupt controller on K3 SoCs provide
>> a higher number of host interrupts (20 vs 10) and can handle an increased
>> number of input events (160 vs 64) from various SoC interrupt sources.
>>
>> Add the bindings document for these interrupt controllers on all the
>> applicable SoCs. It covers the OMAP architecture SoCs - AM33xx, AM437x
>> and AM57xx; the Keystone 2 architecture based 66AK2G SoC; the Davinci
>> architecture based OMAPL138 SoCs, and the K3 architecture based AM65x
>> and J721E SoCs.
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>> Prior version: https://patchwork.kernel.org/patch/10795771/
>>
>>  .../interrupt-controller/ti,pruss-intc.txt    | 92 +++++++++++++++++++
>>  1 file changed, 92 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc.txt
>>
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

Thanks Rob. I am going to submit a v2 with some minor reword changes
based on couple of comments, but no addition or removal of properties.
Should I be retaining your Reviewed-by for v2?

regards
Suman
