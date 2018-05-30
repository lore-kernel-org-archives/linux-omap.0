From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v2 1/6] ARM: dra762: hwmod: Add MCAN support
Date: Wed, 30 May 2018 18:41:59 +0300
Message-ID: <b0476932-a6e9-6ef1-69ad-c9a8c55d9739@ti.com>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-2-faiz_abbas@ti.com> <20180530145047.GC5705@atomide.com>
 <cfa9c9df-57a2-69f6-9509-440dc18292e7@ti.com>
 <20180530152825.GG5705@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180530152825.GG5705@atomide.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, paul@pwsan.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, Faiz Abbas <faiz_abbas@ti.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 30/05/18 18:28, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [180530 15:18]:
>> For the OCP if part, I think that is still needed until we switch over to
>> full sysc driver. clkctrl_offs you probably also need because that is used
>> for mapping the omap_hwmod against a specific clkctrl clock. Those can be
>> only removed once we are done with hwmod (or figure out some other way to
>> assign the clkctrl clock to a hwmod.)
> 
> Hmm might be worth testing. I thought your commit 70f05be32133
> ("ARM: OMAP2+: hwmod: populate clkctrl clocks for hwmods if available")
> already parses the clkctrl from dts?

It maps the clkctrl clock to be used by hwmod, if those are available. 
We didn't add any specific clock entries to DT for mapping the actual 
clkctrl clock without the hwmod_data hints yet though, as that was 
deemed temporary solution only due to transition to interconnect driver. 
I.e., you would need something like this in DT for every device node:

&uart3 {
   clocks = <l4per_clkctrl UART3_CLK 0>;
   clock-names = "clkctrl";
};

... which is currently not present.

Alternatively you could rename the main_clk in the hwmod_data to point 
towards the clkctrl clock, but again, that would be a temporary solution 
only.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
