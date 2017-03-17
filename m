From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 1/9] Documentation: dt-bindings: Add binding
 documentation for TI clkctrl clocks
Date: Fri, 17 Mar 2017 17:01:22 +0200
Message-ID: <2c30dc5a-203e-fbcf-229f-b4366dfe2774@ti.com>
References: <1489741781-12816-1-git-send-email-t-kristo@ti.com>
 <1489741781-12816-2-git-send-email-t-kristo@ti.com>
 <20170317141813.GS20572@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170317141813.GS20572@atomide.com>
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
Cc: Paul Walmsley <paul@pwsan.com>, mturquette@baylibre.com, sboyd@codeaurora.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 17/03/17 16:18, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [170317 02:12]:
>> From: Tony Lindgren <tony@atomide.com>
>> +Example: Clock controller node on omap 4430:
>> +
>> +&cm2 {
>> +	l4per: cm@1400 {
>> +		cm_l4per@0 {
>> +			cm_l4per_clkctrl: clk@20 {
>> +				compatible = "ti,clkctrl";
>> +				reg = <0x20 0x1b0>;
>> +				#clock-cells = <4>;
>> +			};
>> +		};
>> +	};
>> +};
>
> The #clock-cells = <4> is a typo left over from earlier revisions,
> care to update it to 2 like the binding doc specifies?

Ouch, yea I can update that. Will post along with v3 once more comments 
pour in.

-Tero
