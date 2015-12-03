From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: Change core_initcall levels to
 postcore_initcall
Date: Thu, 3 Dec 2015 20:08:24 +0200
Message-ID: <56608518.7060406@ti.com>
References: <1448900789-4034-1-git-send-email-tony@atomide.com>
 <1448900789-4034-3-git-send-email-tony@atomide.com>
 <20151203160014.GL23396@atomide.com> <56606F20.9050805@ti.com>
 <20151203164113.GS23396@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151203164113.GS23396@atomide.com>
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
Cc: Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 12/03/2015 06:41 PM, Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko@ti.com> [151203 08:35]:
>> On 12/03/2015 06:00 PM, Tony Lindgren wrote:
>>> * Tony Lindgren <tony@atomide.com> [151130 08:29]:
>>>> We want to be able to probe a few selected device drivers before hwmod
>>>> code populates the clocks in omap_hwmod_setup_all(). This allows us to
>>>> convert most of the clock drivers into regular device drivers.
>>
>> if understand things right, ti clks now will be populated and initialized
>> from
>> __omap_sync32k_timer_init
>>   - omap_clk_init()
>>     - ..
>>     - of_clk_init()
>>     - ..
>>     - omap_clk_soc_init()
>>
>> and __omap_sync32k_timer_init(), in turn, will be called from:
>> arch/arm/kernel/time.c
>>   - time_init()
>> 	machine_desc->init_time();
>> (without your patch 1).
> 
> Yes that's the current approach, but we can do better. We only need the following
> clocks for system timers at that point:
> 
> - mux clocks to select between the 32k and hf oscillator source
> 
> - clkctrl driver to gate the ocp clock
> 
> All the other clocks can be initialized at core_initcall time with this change.
> 
>> So, I don't see real dependency here between clk initialization and hwmods :(
> 
> You don't because it's only implemented so far for the dm814x ADPLL clock :)
> 
> That I posted as "[PATCH 0/2] Clock driver for dm814x ADPLL". Note how it's
> just a regular device driver that also works as loadable module on boards that
> have all the necessary clocks enabled already by the bootloader.
> 

Ah. Thanks. I see it now.

-- 
regards,
-grygorii
