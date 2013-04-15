From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V4 1/6] clk: OMAP: introduce device tree binding to kernel
 clock data
Date: Mon, 15 Apr 2013 13:43:52 -0500
Message-ID: <CAGo_u6oHLxu2zqb_5e3pbnHU7Rp+ReXM9nEeHBw6_d8__aoVxQ@mail.gmail.com>
References: <1365807278-554-1-git-send-email-nm@ti.com>
	<1365807278-554-2-git-send-email-nm@ti.com>
	<516C294D.6070700@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <516C294D.6070700@wwwdotorg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, lkml <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 15, 2013 at 11:22 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 04/12/2013 04:54 PM, Nishanth Menon wrote:
>> OMAP clock data is located in arch/arm/mach-omap2/cclockXYZ_data.c.
>> However, this presents an obstacle for using these clock nodes in
>> Device Tree definitions. This is especially true for board specific
>> clocks initially. The fixed clocks are currently found via clock
>> aliases table. There are many possible approaches to this problem as
>> discussed in the following thread:
>> http://marc.info/?t=136370325600009&r=1&w=2.
>> Highlights of the options:
>> a) device specific clk_add_alias:
>>    cons: driver handling required
>> b) using an generic clk node and indexing to reach the clock required.
>>    This is similar in approach taken by tegra and few other platforms.
>>    Example usage: clock = <&clk 5>;
>>    cons: potential to have mismatches in indexed table and associated
>>    dtb data. In addition, managing continued documentation in bindings
>>    as clock indexing increases. Even though readability angle could be
>>    improved by using preprocessing of DT using macros, indexed
>>    approach is inherently risky from cases like the following:
>>    clk indexes in kernel:
>>    1 - mpu_dpll
>>    2 - aux_clk1
>>    3 - core_clk
>>    DT entry for peripheral X uses <&clk 2> to reach aux_clk1. Now, let's
>>    say kernel updates indices to:
>>    1 - mpu_dpll
>>    2 - per_dpll
>>    3 - aux_clk1
>>    4 - core_clk
>>    using the old dtb(or dts missing an update), on new kernel which
>>    has updated indices will result in per_dpll now controlled for
>>    peripheral X without warning or any potential error detection.
>>
>>    Even though we could claim this is user error, such errors are hard
>>    to track down and fix.
>
> The error in case (b) is that you shouldn't be changing the DT bindings
> after they've first been created. That would avoid the problem
> situation. The person using the old DTB with the new kernel didn't
> commit user error.
That is what we'd like folks to follow, but when code is in
development, or productization, there is no saying the type of
mistakes people end up doing.
>
>> An alternate approach introduced here is to introduce device tree
>> bindings corresponding to the clock nodes required in DT definition
>> for SoC which automatically maps back to the definitions in
>> cclockXYZ_data.c.
>
> Well, I haven't read the patches, but isn't that exactly what the "2" is
> in <&clk 2>?
partly so. yes: it indexes back to the right clock node - at that
point the comparison stops. we just point back on naming as needed and
introduce nodes purely for the ones that we need.

Regards,
Nishanth Menon
