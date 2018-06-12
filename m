From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 0/2] ti-cpufreq: minor fixes/cleanups
Date: Tue, 12 Jun 2018 16:59:46 +0200
Message-ID: <3941876.itVUMqcnQG@aspire.rjw.lan>
References: <20180531222144.26739-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180531222144.26739-1-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Dave Gerlach <d-gerlach@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Friday, June 1, 2018 12:21:42 AM CEST Suman Anna wrote:
> Hi Rafael,
> 
> This is a repost of the v2 patches Ccing the proper linux-pm list.
> There are no code changes, I have picked up Viresh's acks and
> also added the stable kernel versions the first patch needs to be
> applied to.
> 
> regards
> Suman
> 
> v2: https://marc.info/?l=linux-omap&m=152268780921259&w=2
> v1: https://patchwork.kernel.org/patch/10308925/
> 
> Suman Anna (2):
>   cpufreq: ti-cpufreq: Fix an incorrect error return value
>   cpufreq: ti-cpufreq: Use devres managed API in probe()
> 
>  drivers/cpufreq/ti-cpufreq.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> 

Applied, thanks!
