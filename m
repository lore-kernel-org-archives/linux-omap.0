From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: Re: [PATCH 1/2] clk: change clk_ops' ->round_rate() prototype
Date: Tue, 28 Apr 2015 18:11:28 +0300
Message-ID: <553FA320.4040006@kapsi.fi>
References: <1429255769-13639-1-git-send-email-boris.brezillon@free-electrons.com> <1429255769-13639-2-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1429255769-13639-2-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-doc-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Mike Turquette <mturquette@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shawn Guo <shawn.guo@linaro.org>, ascha Hauer <kernel@pengutronix.de>, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Max Filippov <jcmvbkbc@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Barry Song <baohua@kernel.org>, Viresh Kumar <viresh.linux@gmail.com>, =?UTF-8?B?RW1pbGlvIEzDs3Bleg==?= <emilio@elopez.com.ar>, Maxime Ripard <maxime.ripard@free-electrons.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, Stephen Warren <swarr>
List-Id: linux-omap@vger.kernel.org

The series

Tested-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>

on Jetson-TK1.

I rebased my cpufreq series on top of this and everything's working well 
now. :)

Thanks,
Mikko.

On 04/17/2015 10:29 AM, Boris Brezillon wrote:
> ...
