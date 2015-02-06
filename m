From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v13 3/6] clk: Make clk API return per-user struct clk
 instances
Date: Fri, 06 Feb 2015 11:41:22 -0800
Message-ID: <54D518E2.8060405@codeaurora.org>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com> <1422011024-32283-4-git-send-email-tomeu.vizoso@collabora.com> <54D3C803.30706@samsung.com> <54D3CD6A.1010209@codeaurora.org> <54D3EB29.4090007@codeaurora.org> <20150206004210.GB8670@n2100.arm.linux.org.uk> <54D41A60.8040702@codeaurora.org> <20150206133920.GC8670@n2100.arm.linux.org.uk> <54D5164A.30503@codeaurora.org> <20150206193702.GD8670@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150206193702.GD8670@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, linux-omap@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 02/06/15 11:37, Russell King - ARM Linux wrote:
> On Fri, Feb 06, 2015 at 11:30:18AM -0800, Stephen Boyd wrote:
>> Why don't we make the legacy lookup more specific and actually indicate
>> "internal" for the con_id? Then the external clock would fail to be
>> found, but we can detect that case and figure out that it's not due to
>> probe defer, but instead due to the fact that there really isn't any
>> mapping. It looks like the code is already prepared for this anyway.
> We _could_, and that would solve this specific issue, but I'd suggest
> coccinelle is used to locate any other similar instances of this.
>
> As I'm allergic to coccinelle (or coccinelle is allergic to me since
> I never seem to be able to get it to do what I want...)
>

Great. I'd like to avoid adding clk_equal() until we actually need it,
and I hope we don't ever need it. We've already got coccinelle in the
works to find similar issues and it seems you and I have the same
allergies because I can't get it to work for me right now.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
