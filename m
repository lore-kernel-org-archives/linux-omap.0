From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH DO NOT MERGE 5/6] ARM: dts: omap4: add some sample clkctrl
 data
Date: Tue, 7 Mar 2017 11:04:08 +0200
Message-ID: <c81492c2-aff8-3adb-33c5-b72b4469488c@ti.com>
References: <1486992157-10673-1-git-send-email-t-kristo@ti.com>
 <1486992157-10673-6-git-send-email-t-kristo@ti.com>
 <20170306224535.GP20572@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170306224535.GP20572@atomide.com>
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
Cc: mturquette@baylibre.com, linux-omap@vger.kernel.org, sboyd@codeaurora.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 07/03/17 00:45, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [170213 05:24]:
>> @@ -304,6 +339,8 @@
>>  			#gpio-cells = <2>;
>>  			interrupt-controller;
>>  			#interrupt-cells = <2>;
>> +			clocks = <&cm_l4per_clkctrl OMAP4_GPIO2_CLKCTRL 0>;
>> +			clock-names = "clkctrl";
>>  		};
>>
>>  		gpio3: gpio@48057000 {
>> @@ -315,6 +352,8 @@
>>  			#gpio-cells = <2>;
>>  			interrupt-controller;
>>  			#interrupt-cells = <2>;
>> +			clocks = <&cm_l4per_clkctrl OMAP4_GPIO3_CLKCTRL 0>;
>> +			clock-names = "clkctrl";
>>  		};
>>
>>  		gpio4: gpio@48059000 {
>> @@ -384,6 +423,8 @@
>>  			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
>>  			ti,hwmods = "uart1";
>>  			clock-frequency = <48000000>;
>> +			clocks = <&cm_l4per_clkctrl OMAP4_UART1_CLKCTRL 0>;
>> +			clock-names = "clkctrl";
>>  		};
>
> BTW, one thing you might want to test also is that the opt clocks
> can be mapped here properly for gpios to reset. That can be easily
> tested by kexec booting on beagle-x15 where we currently get warnings
> on kexec boot about GPIOs failing to reset.

Ok, I'll check that also. I am planning to post the cleanup series this 
week, and post the clkctrl support next, as this one needs some data 
changes + additional testing.

-Tero
