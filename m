From: Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH 10/14] ARM: OMAP2+: Remove legacy data from hwmod for omap3
Date: Tue, 14 Feb 2017 11:56:07 -0600
Message-ID: <CAHCN7xK7p_4Am8-=ZdLLO=hek0QZdkFCCO-F983BWOHHcwLRJA@mail.gmail.com>
References: <20161111191711.5079-1-tony@atomide.com>
 <20161111191711.5079-11-tony@atomide.com>
 <CAHCN7x+XEnu2agB6mjre8-RdS-MAE3Zh2HGPQcpohfxhmMM0PA@mail.gmail.com>
 <20170214174446.GJ21809@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170214174446.GJ21809@atomide.com>
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
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 14, 2017 at 11:44 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Adam Ford <aford173@gmail.com> [170214 09:01]:
>> On Fri, Nov 11, 2016 at 1:17 PM, Tony Lindgren <tony@atomide.com> wrote:
>> > This data is now coming from device tree so we can remove the
>> > duplicate data. Let's keep the DSS and DMA related things for now
>> > until those have been converted to device tree completely.
>> >
>> > While at it, let's also add the trailing commas to data structures
>> > so further processing with scripts will be a bit easier.
>> >
>> Tony,
>>
>> I am having some errors with this patch.
>>
>> Smartreflex on a DM3730 drops a few errors:
>>
>> [    1.209747] smartreflex smartreflex.0: invalid resource
>> [    1.215301] smartreflex smartreflex.0: omap_sr_probe: ioremap fail
>> [    1.221832] smartreflex smartreflex.1: invalid resource
>> [    1.227294] smartreflex smartreflex.1: omap_sr_probe: ioremap fail
>> [    1.233856] sr_init: platform driver register failed for SR
>>
>> I used Git bisect to narrow it down to this patch, and I confirmed it
>> manually.  Sorry it took so long to get feedback on this, but I was on
>> vacation.
>
> Oh OK sorry about that.
>
>> I attempted to just add back the smartreflex stuff for the omap36xx,
>> but that didn't work.  I am going to assume something is missing or
>> wrong in the device tree, but I could be wrong. If you  have any
>> suggestions before I go down a rabbit hole, I am open for ideas.
>
> That's all there is to it :) You must have missed some part of it.
> Below is a fix that seems to work for me, care to test?

Damn, you're fast! :-)

I tested it and it works just fine now.

>
> Regards,
>
> Tony
>
> 8< -----------------------
> From tony Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony@atomide.com>
> Date: Tue, 14 Feb 2017 09:33:25 -0800
> Subject: [PATCH] ARM: OMAP3: Fix smartreflex platform data regression
>
> Commit d9d9cec02835 ("ARM: OMAP2+: Remove legacy data from hwmod for
> omap3") dropped platform data that should no longer be used as we're
> booting with device tree. It turns out that smartreflex is still
> using platform data and produces the following errors during probe:
>
> smartreflex smartreflex.0: invalid resource
> smartreflex smartreflex.0: omap_sr_probe: ioremap fail
> smartreflex: probe of smartreflex.0 failed with error -22
> smartreflex smartreflex.1: invalid resource
> smartreflex smartreflex.1: omap_sr_probe: ioremap fail
> smartreflex: probe of smartreflex.1 failed with error -22
>
> Let's fix the regression by adding back the smartreflex hwmod data.
> The long term is to update the smartreflex driver to use device tree
> based probing.
>
Tested-by: Adam Ford  <aford173@gmail.com>
> Reported-by: Adam Ford <aford173@gmail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -1946,6 +1946,7 @@ static struct omap_hwmod_ocp_if omap3xxx_dss__l3 = {
>  };
>
>  /* l3_core -> usbhsotg interface */
> +
>  static struct omap_hwmod_ocp_if omap3xxx_usbhsotg__l3 = {
>         .master         = &omap3xxx_usbhsotg_hwmod,
>         .slave          = &omap3xxx_l3_main_hwmod,
> @@ -2112,11 +2113,20 @@ static struct omap_hwmod_ocp_if omap3_l4_core__i2c3 = {
>  };
>
>  /* L4 CORE -> SR1 interface */
> +static struct omap_hwmod_addr_space omap3_sr1_addr_space[] = {
> +       {
> +               .pa_start       = OMAP34XX_SR1_BASE,
> +               .pa_end         = OMAP34XX_SR1_BASE + SZ_1K - 1,
> +               .flags          = ADDR_TYPE_RT,
> +       },
> +       { },
> +};
>
>  static struct omap_hwmod_ocp_if omap34xx_l4_core__sr1 = {
>         .master         = &omap3xxx_l4_core_hwmod,
>         .slave          = &omap34xx_sr1_hwmod,
>         .clk            = "sr_l4_ick",
> +       .addr           = omap3_sr1_addr_space,
>         .user           = OCP_USER_MPU,
>  };
>
> @@ -2124,15 +2134,25 @@ static struct omap_hwmod_ocp_if omap36xx_l4_core__sr1 = {
>         .master         = &omap3xxx_l4_core_hwmod,
>         .slave          = &omap36xx_sr1_hwmod,
>         .clk            = "sr_l4_ick",
> +       .addr           = omap3_sr1_addr_space,
>         .user           = OCP_USER_MPU,
>  };
>
>  /* L4 CORE -> SR1 interface */
> +static struct omap_hwmod_addr_space omap3_sr2_addr_space[] = {
> +       {
> +               .pa_start       = OMAP34XX_SR2_BASE,
> +               .pa_end         = OMAP34XX_SR2_BASE + SZ_1K - 1,
> +               .flags          = ADDR_TYPE_RT,
> +       },
> +       { },
> +};
>
>  static struct omap_hwmod_ocp_if omap34xx_l4_core__sr2 = {
>         .master         = &omap3xxx_l4_core_hwmod,
>         .slave          = &omap34xx_sr2_hwmod,
>         .clk            = "sr_l4_ick",
> +       .addr           = omap3_sr2_addr_space,
>         .user           = OCP_USER_MPU,
>  };
>
> @@ -2140,6 +2160,7 @@ static struct omap_hwmod_ocp_if omap36xx_l4_core__sr2 = {
>         .master         = &omap3xxx_l4_core_hwmod,
>         .slave          = &omap36xx_sr2_hwmod,
>         .clk            = "sr_l4_ick",
> +       .addr           = omap3_sr2_addr_space,
>         .user           = OCP_USER_MPU,
>  };
>
> --
> 2.11.1
