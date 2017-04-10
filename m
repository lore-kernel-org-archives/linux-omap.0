From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 0/9] clk: ti: add support for clkctrl clocks
Date: Mon, 10 Apr 2017 21:33:43 +0300
Message-ID: <74c65472-cc1c-1ab9-7d27-65a164a6f025@ti.com>
References: <94d20a17-5072-ffab-3529-4bbb14327a10@ti.com>
 <20170323010057.GI10760@atomide.com> <20170323170210.GL10760@atomide.com>
 <8648f054-cf04-41df-20f3-82e0d63feefa@ti.com>
 <20170330165448.GF10760@atomide.com>
 <55b439ed-8b81-2e6b-64f1-34f9f3cc5369@ti.com>
 <20170403153604.GI10760@atomide.com>
 <b135c5d6-f06d-030d-333b-5223ef1aca9a@ti.com>
 <20170407164731.GJ13234@atomide.com>
 <6dd4c892-f0b5-f72e-c5e9-357cb8506f05@ti.com>
 <20170410161816.GD5339@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170410161816.GD5339@atomide.com>
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

On 10/04/17 19:18, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [170410 00:34]:
>> On 07/04/17 19:47, Tony Lindgren wrote:
>>> OK hdmi works now on panda for both omapfb and omapdrm. Any ideas why
>>> that change is now needed though?
>>
>> Yes, it is pretty clear actually. Previously, the hwmod main clock was
>> controlling the hdmi clock, but this is now rerouted to the clkctrl module
>> clock, which is shared between all DSS submodules. This leaves the hdmi
>> clock disabled, causing the failure.
>>
>> The fix just puts the hdmi clock into the optional clocks list, and forces
>> all the optional clocks on when pm_runtime is enabled for the module.
>
> OK so no need to fix it in the current kernels then.

Yeah, just need to figure out a clean order of applying these patches. 
The hwmod data change for DSS modules can most likely be applied before 
the dts change for clkctrl is going in, as it is just causing double 
clk_enable / disable for the main clocks in that case.

-Tero
