From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH] clk: fix compile for OF && !COMMON_CLK
Date: Tue, 17 Jul 2012 19:24:35 +0530
Message-ID: <50056E9B.1060509@ti.com>
References: <1342475161-20402-1-git-send-email-robherring2@gmail.com> <20120717001228.GA28886@gmail.com> <5004C935.4050707@gmail.com> <50056648.6000906@ti.com> <50056CB3.90004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50056CB3.90004@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Mike Turquette <mturquette@ti.com>, Shawn Guo <shawn.guo@linaro.org>, Prashant Gaikwad <pgaikwad@nvidia.com>, aletes.xgr@gmail.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Archit Taneja <archit@ti.com>, loml <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday 17 July 2012 07:16 PM, Rob Herring wrote:
>> So how is this expected to work on platforms (like OMAP) which have
>> >  CONFIG_OF enabled but not CONFIG_COMMON_CLK?
>> >
> As I mentioned in my other reply, this really belongs with Shawn's patch
> that changes the return value checking from NULL to err values.
>
ah, I seemed to have missed that. Just had a look at Shawn's patch and
that should work for OMAP too. thanks.
