From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] regulator: palmas: Fix SMPS enable/disable/is_enabled
Date: Mon, 23 Jun 2014 13:50:07 -0600
Message-ID: <53A884EF.100@wwwdotorg.org>
References: <1403285183-15926-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1403285183-15926-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 06/20/2014 11:26 AM, Nishanth Menon wrote:
> We use regmap regulator ops to enable/disable and check if regulator
> is enabled for various SMPS. However, these depend on valid
> enable_reg, enable_mask and enable_value in regulator descriptor.
> 
> Currently we do not populate these for SMPS other than SMPS10, this
> results in spurious results as regmap assumes that the values are
> valid and ends up reading register 0x0 RTC:SECONDS_REG on Palmas
> variants that do have RTC! To fix this, we update proper parameters
> for the descriptor fields.
> 
> Further, we want to ensure the behavior consistent with logic
> prior to commit dbabd624d4eec50b6, where, once you do a set_mode,
> enable/disable ensure the logic remains consistent and configures
> Palmas to the configuration that we set with set_mode (since the
> configuration register is common). To do this, we can rely on the
> regulator core's regulator_register behavior where the regulator
> descriptor pointer provided by the regulator driver is stored. (no
> reallocation and copy is done). This lets us update the enable_value
> post registration, to remain consistent with the mode we configure as
> part of set_mode.
> 
> Fixes: dbabd624d4eec50b6 ("regulator: palmas: Reemove open coded functions with helper functions")
> Reported-by: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>

Unfortunately, there is still some lingering problem in the original
commit. In next-20130623 (and indeed since at least next-20140611),
neither the LCD panel or HDMI work on the NVIDIA Dalmore board.
Reverting this commit (just for conflicts) and the original problematic
commit "regulator: palmas: Reemove open coded functions with helper
functions" solves this. I see the following on boot:

> [    3.558776] tegra-dsi 54300000.dsi: cannot get VDD supply
> [    3.564272] platform 54300000.dsi: Driver tegra-dsi requests probe deferral
> [    3.571990] tegra-hdmi 54280000.hdmi: failed to get PLL regulator
> [    3.578377] platform 54280000.hdmi: Driver tegra-hdmi requests probe deferral

... but probe deferral never completes, yet with your "remove open coded
..." patch reverted, it all works fine.

Can you please take another look at the original patch?
