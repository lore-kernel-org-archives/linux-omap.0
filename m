From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] ARM: Remove __ref on hotplug cpu die path
Date: Tue, 15 Sep 2015 15:12:30 +0100
Message-ID: <55F8274E.5060008@arm.com>
References: <1442276597-14325-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442276597-14325-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, "arm@kernel.org" <arm@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Barry Song <baohua@kernel.org>, Andy Gross <agross@codeaurora.org>, Viresh Kumar <vireshk@kernel.org>, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Will Deacon <Will.Deacon@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "spear-devel@list.st.com" <spear-devel@list.st.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel>
List-Id: linux-omap@vger.kernel.org



On 15/09/15 01:23, Stephen Boyd wrote:
> Now that __cpuinit has been removed, the __ref markings on these
> functions are useless. Remove them. This also reduces the size of
> the multi_v7_defconfig image:
>
> $ size before after
>     text    data     bss     dec     hex filename
>     12683578        1470996  348904 14503478         dd4e36 before
>     12683274        1470996  348904 14503174         dd4d06 after
>
> presumably because now we don't have to jump to code in the
> .ref.text section and/or the noinline marking is removed.
>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Andy Gross <agross@codeaurora.org>
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: <linux-omap@vger.kernel.org>
> Cc: <linux-arm-msm@vger.kernel.org>
> Cc: <spear-devel@list.st.com>
> Cc: <linux-tegra@vger.kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>
> This patch can be broken up into per-SoC if desired.
>

[...]

>   arch/arm/mach-vexpress/hotplug.c     | 2 +-

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Regards,
