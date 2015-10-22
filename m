From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH/RESEND] ARM: Remove __ref on hotplug cpu die path
Date: Thu, 22 Oct 2015 09:55:56 -0700
Message-ID: <20151022165556.GE19953@localhost>
References: <1445285133-11977-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445285133-11977-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: arm@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, linux-arm-msm@vger.kernel.org, spear-devel@list.st.com, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 19, 2015 at 01:05:33PM -0700, Stephen Boyd wrote:
> Now that __cpuinit has been removed, the __ref markings on these
> functions are useless. Remove them. This also reduces the size of
> the multi_v7_defconfig image:
> 
> $ size before after
>    text    data     bss     dec     hex filename
>    12683578        1470996  348904 14503478         dd4e36 before
>    12683274        1470996  348904 14503174         dd4d06 after
> 
> presumably because now we don't have to jump to code in the
> .ref.text section and/or the noinline marking is removed.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Acked-by: Barry Song <baohua@kernel.org>
> Acked-by: Andy Gross <agross@codeaurora.org>
> Acked-by: Viresh Kumar <vireshk@kernel.org>
> Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Acked-by: Thierry Reding <thierry.reding@gmail.com>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
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
> Collected the acks and resent.

Applied to next/cleanup. Thanks!


-Olof
