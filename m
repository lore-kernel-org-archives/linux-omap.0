From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv13 00/40] ARM: TI SoC clock DT conversion
Date: Mon, 13 Jan 2014 17:49:19 +0200
Message-ID: <52D40AFF.9000308@ti.com>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
 <CAGhQ9Vz8i2EEG+GgFwXFj3vgeV_Eg0dDfRvKn-XRRVBjwJkDXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAGhQ9Vz8i2EEG+GgFwXFj3vgeV_Eg0dDfRvKn-XRRVBjwJkDXQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, paul@pwsan.com, mturquette@linaro.org, Tony Lindgren <tony@atomide.com>, rnayak@ti.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 01/11/2014 06:35 PM, Joachim Eastwood wrote:
> On 9 January 2014 15:00, Tero Kristo <t-kristo@ti.com> wrote:
>> Hi,
>>
>> So, bad luck number release for this, as v12 wasn't sufficient still.
>>
>> Changes compared to previous version:
>> - Dropped any changes to generic clock drivers, as it seems impossible
>>    to agree anything in short term, this means the patch set shrank in
>>    size from 49 patches to 40 (first 9 patches were dropped).
>> - Copy pasted implementation for clk-divider and clk-mux from drivers/clk
>>    to drivers/clk/ti, and made the modifications needed to the TI version
>>    of the clock drivers only (based on discussions with Mike, this is fine)
>> - Changed name of clk_ll_ops to ti_clk_ll_ops so that this doesn't conflict
>>    with any generic implementation we might have at some point, migrating
>>    this to the generic version should be easy enough also.
>> - Fixed trace_clk_div_div_ck for omap4, this node was broken in previous
>>    versions and resulted into an orphan clock node
>> - Fixed compile problem for omap5 only build reported by Felipe
>> - Fixed a couple of sparse warnings
>> - changed the mach-omap2/clock.c to use readl_relaxed / writel_relaxed
>>    instead of __raw_readl / __raw_writel
>>
>> Testing done:
>> - omap3-beagle: boot / suspend-resume (RET) / suspend-resume (OFF)
>> - omap4-panda-es: boot / suspend-resume (RET)
>> - omap5-uevm: boot
>> - am335x-bone: boot
>> - dra7-evm: boot
>>
>> Maintainer friendly branches also available:
>>
>> tree: https://github.com/t-kristo/linux-pm.git
>>
>> clk driver only (Mike): clk-next-dt-clks-v13
>> DTS data only (Benoit): dts_for_3.14-dt-clks-v13
>> full-branch (Tony/Paul): 3.13-rc7-dt-clks-v13
>
> I tested 3.13-rc7-dt-clks-v13 on top of a next branch I am working on
> with a OMAP4460 and it's working fine.
>
> A couple of things I noticed in the boot log:
> [ 0.000000] ti_dt_clocks_register: failed to lookup clock node bandgap_fclk
> [ 0.000000] smp_twd: clock not found -2
>
> I am get the bandgap_fclk clock lookup fail since it doesn't exist on
> 4460 and I guess the bandgap_ts_fclk clock will fail the same way on
> 4430. So maybe you need to differentiate between 4460 and 4430 in
> clk-44xx.c to get rid of this warning.

Yeah thats true. I was kind of lazy with the omap4 clk file (these are 
supposed to be temporary anyway until we can get rid of the clock 
aliases through proper driver DT mappings), and didn't separate omap4430 
vs omap4460 there. If this print needs to go away, we need to do this 
similarly to what was done with different omap3 versions (the clock data 
delta is much more larger there), but the additional code needed for 
this was rather large for the minimal impact... we would need separate 
board files, separate io.c setups, and logic within the clk-44xx.c file 
itself.

Just to re-phrase it, this doesn't impact functionality, the resultant 
clock nodes etc. are exactly the same before-and-after this set, the 
kernel just tries to register one additional clock alias which it can't 
find and prints the single line out.

-Tero

>
> As for the smp_twd clock I assume we can add "clocks =
> <&mpu_periphclk>" to local-timer@48240600 in omap4.dtsi to get rid of
> the warning. I can cook up a patch here if it is the right thing to
> do.
> I think the smp_twd warning existed before I applied this patch set.
>
> regards
> Joachim Eastwood
>
