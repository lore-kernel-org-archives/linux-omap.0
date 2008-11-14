From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH 1/2] HSMMC: Make loopback clock configurable
Date: Fri, 14 Nov 2008 10:34:10 -0800
Message-ID: <5e088bd90811141034l4d5cc1ddl9e2852f69486216c@mail.gmail.com>
References: <5e088bd90811132241i3a8ccdc3ua30d941e0315dc6f@mail.gmail.com>
	 <1226659752-21741-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.190]:38173 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910AbYKNSeN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Nov 2008 13:34:13 -0500
Received: by gv-out-0910.google.com with SMTP id e6so313777gvc.37
        for <linux-omap@vger.kernel.org>; Fri, 14 Nov 2008 10:34:11 -0800 (PST)
In-Reply-To: <1226659752-21741-1-git-send-email-notasas@gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Fri, Nov 14, 2008 at 2:49 AM, Grazvydas Ignotas <notasas@gmail.com> wrote:
> On Fri, Nov 14, 2008 at 8:41 AM, Steve Sakoman <sakoman@gmail.com> wrote:
>> On Thu, Nov 13, 2008 at 3:06 PM, Tony Lindgren <tony@atomide.com> wrote:
>>> * Grazvydas Ignotas <notasas@gmail.com> [081113 13:40]:
>>>> Some boards use input clock from external pin for MMC/SDIO
>>>> modules in OMAP chips. Make that option selectable instead of
>>>> forcing loop back clock on everyone.
>>>
>>> Thanks, pushing both today.
>>
>> Hmm . . . not sure if it is related to this patch, but I now get an
>> oops on Overo.
>
> Oops.. Haven't thought to try it without gpio_cd set up, in which case c->mmc
> is not set initialized.. Please try the following patch:

I did, and I am happy to report that it fixed the oops on mmc2 and my
wi2wi driver is happily working again.

Thanks!

Steve

> diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
> index 0ea6ba6..626d668 100644
> --- a/arch/arm/mach-omap2/mmc-twl4030.c
> +++ b/arch/arm/mach-omap2/mmc-twl4030.c
> @@ -239,6 +239,7 @@ static int twl_mmc1_set_power(struct device *dev, int slot, int power_on,
>        u32 reg;
>        int ret = 0;
>        struct twl_mmc_controller *c = &hsmmc[0];
> +       struct omap_mmc_platform_data *mmc = dev->platform_data;
>
>        if (power_on) {
>                if (cpu_is_omap2430()) {
> @@ -250,7 +251,7 @@ static int twl_mmc1_set_power(struct device *dev, int slot, int power_on,
>                        omap_ctrl_writel(reg, OMAP243X_CONTROL_DEVCONF1);
>                }
>
> -               if (c->mmc->slots[0].internal_clock) {
> +               if (mmc->slots[0].internal_clock) {
>                        reg = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
>                        reg |= OMAP2_MMCSDIO1ADPCLKISEL;
>                        omap_ctrl_writel(reg, OMAP2_CONTROL_DEVCONF0);
> @@ -293,11 +294,11 @@ static int twl_mmc1_set_power(struct device *dev, int slot, int power_on,
>  static int twl_mmc2_set_power(struct device *dev, int slot, int power_on, int vdd)
>  {
>        int ret;
> -
>        struct twl_mmc_controller *c = &hsmmc[1];
> +       struct omap_mmc_platform_data *mmc = dev->platform_data;
>
>        if (power_on) {
> -               if (c->mmc->slots[0].internal_clock) {
> +               if (mmc->slots[0].internal_clock) {
>                        u32 reg;
>
>                        reg = omap_ctrl_readl(control_devconf1_offset);
>
