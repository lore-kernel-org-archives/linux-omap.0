From: Andy Gross <agross@codeaurora.org>
Subject: Re: [PATCH] ARM: Remove __ref on hotplug cpu die path
Date: Tue, 15 Sep 2015 12:58:55 -0500
Message-ID: <20150915175855.GA18435@qualcomm.com>
References: <1442276597-14325-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442276597-14325-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: arm@kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Barry Song <baohua@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, spear-devel@list.st.com, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 14, 2015 at 05:23:17PM -0700, Stephen Boyd wrote:
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

<snip>

Acked-by: Andy Gross <agross@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
